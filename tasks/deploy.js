const { task } = require("hardhat/config");
const {
  getMultisigAddress,
  getTrustedForwarderAddress,
} = require("../utils/getContractAddress");
require("dotenv").config();

task("deploy", "Deploys a contract").setAction(async () => {
  await hre.run("compile");

  const ERC_1155_FACTORY = await hre.ethers.getContractFactory(
    "PostersSeason2ByMintSongs"
  );
  const deployment = await hre.upgrades.deployProxy(
    ERC_1155_FACTORY,
    [
      process.env.CONTRACT_WEI_PER_POSTER,
      process.env.CONTRACT_NAME,
      process.env.CONTRACT_SYMBOL,
      process.env.CONTRACT_DESCRIPTION,
      process.env.CONTRACT_IMAGE_URI,
      process.env.CONTRACT_EXTERNAL_URL,
      process.env.CONTRACT_SELLER_FEE_BASIS_POINTS,
      getMultisigAddress(network),
      getTrustedForwarderAddress(network),
    ],
    {
      initializer: "initialize",
    }
  );

  await deployment.deployed();
  console.log("deployed to:", deployment.address);

  const proxyImplAddress = await upgrades.erc1967.getImplementationAddress(
    deployment.address
  );
  console.log("verifying implementation: ", proxyImplAddress);
  await hre.run("verify:verify", { address: proxyImplAddress });
});
