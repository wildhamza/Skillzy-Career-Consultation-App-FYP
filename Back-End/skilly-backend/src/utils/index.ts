/**
 * Rounds of the number to the required length
 * @param num Number to format
 * @param round digits after decimal
 * @returns Formatted number with required digits after decimal
 */
export const roundNumber = (num: number, round = 0) => {
  return +num.toFixed(round);
};

/**
 * Checks if date is valid or not
 * @param date Date to validate
 * @returns true if date is valid, false if date is invalid
 */
export const isValidDate = (date: string) => {
  return !Number.isNaN(new Date(date).getTime());
};

/**
 * Converts string to snake case
 * @param str String to convert to snake case
 * @returns snake case string
 */
export const snakeCase = (str: string) => str.replace(/\s+/g, "_").toUpperCase();

/**
 * Converts centimeter to meter
 * @param val Length in cm
 * @returns meter
 */
export const cmToMeters = (val: number) => val / 100;
