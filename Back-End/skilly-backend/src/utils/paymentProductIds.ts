export type Plans = {
  monthly: string;
  half_yearly: string;
  yearly: string;
  lifetime: string;
};

export const stripePriceIds = (isTest) => {
  const plans: Plans = {
    monthly: isTest ? "price_1PdRSoKS3bfsFgOHtyFFxHvy" : "price_1PdQDXKS3bfsFgOH7lJ1ywcZ",
    half_yearly: isTest ? "price_1PdRTyKS3bfsFgOHYFtEJzQr" : "price_1PdQf7KS3bfsFgOHtOuK0eZb",
    yearly: isTest ? "price_1Pd6ZaKS3bfsFgOHaohcg3e1" : "price_1PdQfgKS3bfsFgOHV8cSLYss",
    lifetime: isTest ? "price_1PfhgjKS3bfsFgOHpaJG7x14" : "price_1PdQhEKS3bfsFgOHBUgLbdc7"
  };

  return plans;
};

export const appleProductIds = () => {
  const plans: Plans = {
    monthly: "gfwuMonthly1999",
    half_yearly: "gfwubiYearly10199",
    yearly: "gfwuYearly179.99",
    lifetime: "gfwu_79999_lt"
  };

  return plans;
};

export const googleProductIds = () => {
  const plans: Plans = {
    monthly: "gfwu_1_m",
    half_yearly: "gwu_10199_6m",
    yearly: "gfwu_1_yearly",
    lifetime: "gfwu_life_time"
  };

  return plans;
};
