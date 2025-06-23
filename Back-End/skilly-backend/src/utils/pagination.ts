import { Model } from "mongoose";

import { Pagination } from "./apiFeatures";

interface Query {
  [key: string]: any; // eslint-disable-line @typescript-eslint/no-explicit-any
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
async function getPaginationData(model: Model<any>, features: { query: Query; pagination: Pagination }) {
  const { pagination } = features;
  const totalDocuments = await model.countDocuments(features.query._conditions);
  const totalPages = Math.ceil(totalDocuments / (pagination.postPerPage || 1));
  return {
    ...pagination,
    totalPages,
    totalDocuments,
    previousPage: pagination.currentPage !== 1,
    nextPage: pagination.currentPage !== totalPages
  };
}

export default getPaginationData;
