import mongoose from "mongoose";

import app from ".";

process.on("uncaughtException", (err) => {
  console.error(err.name, err.message); // eslint-disable-line no-console
  process.exit(1);
});

const DB = process.env.DB_URL.replace("<password>", process.env.DB_PASS);

mongoose
  .connect(DB)
  .then(() => console.log("\x1b[33m%s\x1b[0m", "DB connection successful!")) // eslint-disable-line no-console
  .catch(() => console.log("DB connection failed")); // eslint-disable-line no-console

const port = process.env.PORT || 8000;
const server = app.listen(port, () => {
  console.log("\x1b[35m%s\x1b[0m", `App running on port ${port}...`); // eslint-disable-line no-console
});

process.on("unhandledRejection", (err: Error) => {
  console.error(err.name, err.message); // eslint-disable-line no-console
  server.close(() => process.exit(1));
});
