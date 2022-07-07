const { task } = require("hardhat/config");

task("upgrade", "upgrade a contract").setAction(async () => {
  await hre.run("compile");

  const supportedChains = ['mumbai', 'matic', 'goerli']
  
  if (!supportedChains.includes(network.name)) {
    console.log(`${network.name} not supported.`);
    return;
  }

  const contract = await hre.ethers.getContractFactory("PosterFactory");

  const address = "0xAB7D3d1a1a16D5178c283256CcA9A8A5474cf8a4";
  implAddress = await upgrades.erc1967.getImplementationAddress(address);
  console.log("Old implementation address:", implAddress);
  await upgrades.upgradeProxy(address, contract);
  console.log("Upgraded Poster Factory at: ", address);
});
