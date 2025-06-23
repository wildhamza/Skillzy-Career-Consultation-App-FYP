import { Model as MongooseModel, PopulateOptions } from "mongoose";

import APIFeatures from "./apiFeatures";
import AppError from "./AppError";
import catchAsync from "./catchAsync";
import getPaginationData from "./pagination";
import responseBody from "./responseBody";

interface Props {
  Model: MongooseModel<unknown>;
  popOptions?: PopulateOptions[];
  restrictedFields?: string[];
}

const filterRestrictedFields = (obj: { [key: string]: string }, ...restrictedFields: string[]): { [key: string]: string } => {
  const newObj = {};
  const fields = [...restrictedFields, "_id", "__v", "createdAt", "updatedAt"];

  Object.keys(obj).forEach((el) => {
    if (!fields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

export const createOne = ({ Model, restrictedFields = [] }: Props) =>
  catchAsync(async (req, res) => {
    const data = filterRestrictedFields(req.body, ...restrictedFields);

    const doc = await Model.create(data);

    responseBody({
      res,
      status: "success",
      statusCode: 201,
      data: {
        [Model.modelName.toLowerCase()]: doc
      }
    });
  });

export const getAll = ({ Model, popOptions }: Props) =>
  catchAsync(async (req, res) => {
    const { findOptions } = req;

    const features = new APIFeatures(Model.find(findOptions).populate(popOptions), req.query).filter().sort().limitFields().paginate();
    const doc = await features.query;

    // SEND RESPONSE
    responseBody({
      res,
      statusCode: 200,
      status: "success",
      results: doc.length,
      data: {
        [`${Model.modelName.toLowerCase()}s`]: doc,
        pagination: await getPaginationData(Model, features)
      }
    });
  });

export const getOne = ({ Model, popOptions }: Props) =>
  catchAsync(async (req, res, next) => {
    const { findOptions } = req;

    let query = Model.findOne({ _id: req.params.id, ...findOptions });
    if (popOptions) query = query.populate(popOptions);
    const doc = await query;

    if (!doc) {
      return next(new AppError("No data found with that ID", 404));
    }

    responseBody({
      res,
      status: "success",
      statusCode: 200,
      data: {
        [Model.modelName.toLowerCase()]: doc
      }
    });
  });

export const updateOne = ({ Model, restrictedFields = [] }: Props) =>
  catchAsync(async (req, res, next) => {
    const { findOptions } = req;

    const data = filterRestrictedFields(req.body, ...restrictedFields);
    const doc = await Model.findOneAndUpdate({ _id: req.params.id, ...findOptions }, data, {
      new: true,
      runValidators: true
    });

    if (!doc) {
      return next(new AppError("No data found with that ID", 404));
    }

    responseBody({
      res,
      status: "success",
      statusCode: 200,
      data: {
        [Model.modelName.toLowerCase()]: doc
      }
    });
  });

export const deleteOne = ({ Model }: Props) =>
  catchAsync(async (req, res, next) => {
    const { findOptions } = req;

    const doc = await Model.findOneAndDelete({ _id: req.params.id, ...findOptions });

    if (!doc) {
      return next(new AppError("No data found with that ID", 404));
    }

    responseBody({
      res,
      status: "success",
      statusCode: 204,
      data: null
    });
  });

export const deleteMany = ({ Model }: Props) =>
  catchAsync(async (req, res, _next) => {
    const { findOptions } = req;

    await Model.deleteMany({ _id: { $in: req.body }, ...findOptions });

    responseBody({
      res,
      status: "success",
      statusCode: 204,
      data: null
    });
  });
