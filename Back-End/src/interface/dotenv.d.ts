declare module "dotenv" {
  type DotenvParseOptions = {
    debug?: boolean;
  };

  type DotenvParseOutput = {
    [key: string]: string;
  };

  type DotenvConfigOptions = {
    path?: string;
    encoding?: string;
    debug?: boolean;
  };

  type DotenvConfigOutput = {
    parsed?: DotenvParseOutput;
    error?: Error;
  };

  function parse(src: string | Buffer, options?: DotenvParseOptions): DotenvParseOutput;

  function config(options?: DotenvConfigOptions): DotenvConfigOutput;

  export { parse, config };
}
