const { task } = require("hardhat/config");

task("deploy", "Deploys a contract").setAction(async () => {
  hre.run("compile");

  const ETH_ERC721 = await hre.ethers.getContractFactory("Greeter");
  const deployment = await ETH_ERC721.deploy("hello");

  await deployment.deployed();
  console.log("deployed to:", deployment.address);
});
