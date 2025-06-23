import request, { CoreOptions } from "request";

const awaitRequest = async (url: string, options: CoreOptions) =>
  new Promise((resolve, reject) => {
    request(url, options, (error, _res, data) => {
      if (error) reject(error);
      else resolve(data);
    });
  });

export default awaitRequest;
