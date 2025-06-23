import { Query, Document } from "mongoose";

export interface Pagination {
  currentPage?: number;
  postPerPage?: number;
}

type QueryObject = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

class APIFeatures<T extends Document> {
  query: Query<T[], T>;

  queryString: QueryObject;

  pagination: Pagination;

  constructor(query: Query<T[], T>, queryString: QueryObject) {
    this.query = query;
    this.queryString = queryString;
    this.pagination = {};
  }

  filter(): this {
    const queryObj: QueryObject = { ...this.queryString };
    const excludedFields = ["page", "sort", "limit", "fields", "populate", "popOptions"];
    excludedFields.forEach((el) => delete queryObj[el]);

    // Advanced filtering
    if (queryObj.name) {
      if (typeof queryObj.name === "string") {
        queryObj.name = { regex: queryObj.name || "" };
      }
      queryObj.name.$options = "i";
    }
    let queryStr = JSON.stringify(queryObj);
    queryStr = queryStr.replace(/\b(gte|gt|lte|lt|regex|in)\b/g, (match) => `$${match}`);

    this.query = this.query.find(JSON.parse(queryStr));

    return this;
  }

  sort(): this {
    if (this.queryString.sort) {
      const sortBy = this.queryString.sort.split(",").join(" ");
      this.query = this.query.sort(sortBy);
    } else {
      this.query = this.query.sort("-createdAt");
    }

    return this;
  }

  limitFields(): this {
    if (this.queryString.fields) {
      const fields = this.queryString.fields.split(",").join(" ");
      this.query = this.query.select(fields);
    } else {
      this.query = this.query.select("-__v");
    }

    return this;
  }

  paginate(): this {
    const page = this.queryString.page * 1 || 1;
    const limit = this.queryString.limit * 1 || 10000;
    const skip = (page - 1) * limit;

    this.query = this.query.skip(skip).limit(limit);
    Object.assign(this.pagination, {
      currentPage: page,
      postPerPage: limit
    });

    return this;
  }
}

export default APIFeatures;
