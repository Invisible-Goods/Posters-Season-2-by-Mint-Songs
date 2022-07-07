const { task } = require("hardhat/config");
require("dotenv").config();

task("upgrade", "upgrade a contract").setAction(async () => {
  await hre.run("compile");

  if (
    network.name !== "mumbai" &&
    network.name !== "matic" &&
    network.name !== "goerli"
  ) {
    console.log(`${network.name} not supported.`);
    return;
  }

  const contract = await hre.ethers.getContractFactory("PosterFactory");

  const address = process.env.POSTER_FACTORY_CONTRACT_ADDRESS_MUMBAI;
  implAddress = await upgrades.erc1967.getImplementationAddress(address);
  console.log("Old implementation address:", implAddress);
  await upgrades.upgradeProxy(address, contract);
  console.log("Upgraded Poster Factory at: ", address);
});
