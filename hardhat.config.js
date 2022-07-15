require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@openzeppelin/hardhat-defender");
require("./tasks/deploy");
require("./tasks/upgrade");
require("./tasks/propose-upgrade");
require("@nomiclabs/hardhat-etherscan");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defender: {
    apiKey: process.env.OPENZEPPELIN_DEFENDER_TEAM_API_KEY,
    apiSecret: process.env.OPENZEPPELIN_DEFENDER_TEAM_API_SECRET_KEY,
  },
  solidity: {
    compilers: [
      {
        version: "0.5.16",
      },
      {
        version: "0.6.2",
      },
      {
        version: "0.6.4",
      },
      {
        version: "0.7.0",
      },
      {
        version: "0.8.0",
      },
      {
        version: "0.8.2",
      },
      {
        version: "0.8.10",
      },
    ],
  },
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: 31337,
      forking: {
        url: process.env.RPC_ETHEREUM,
        blockNumber: 14787640,
      },
    },
    mumbai: {
      url: process.env.RPC_MUMBAI,
      chainId: 80001,
      accounts: [`0x${process.env.TESTNET_PRIVATE_KEY}`],
    },
    matic: {
      gasPrice: 500_000_000_000,
      url: process.env.RPC_MATIC,
      chaindId: 137,
      accounts: [`0x${process.env.MAINNET_PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: {
      polygon: process.env.POLYGONSCAN_API_KEY,
      polygonMumbai: process.env.POLYGONSCAN_API_KEY,
    },
  },
};
