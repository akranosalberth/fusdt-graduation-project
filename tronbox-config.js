require("dotenv").config();

module.exports = {
  networks: {
    shasta: {
      privateKey: process.env.PRIVATE_KEY_SHASTA,
      fullHost: "https://api.shasta.trongrid.io",
      feeLimit: 1_000_000_000,
      userFeePercentage: 100,
      network_id: "2"
    },
    nile: {
      privateKey: process.env.PRIVATE_KEY_NILE,
      fullHost: "https://nile.trongrid.io",
      feeLimit: 1_000_000_000,
      userFeePercentage: 100,
      network_id: "3"
    }
  },
  compilers: {
    solc: {
      version: "0.8.6",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};

