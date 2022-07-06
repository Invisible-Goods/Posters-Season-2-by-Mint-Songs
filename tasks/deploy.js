const { task } = require("hardhat/config");

task("deploy", "Deploys a contract").setAction(async () => {
  await hre.run("compile");

  const ERC_1155_FACTORY = await hre.ethers.getContractFactory("PosterFactory");
  const deployment = await hre.upgrades.deployProxy(ERC_1155_FACTORY, ["URI"], {
    initializer: "initialize",
  });

  await deployment.deployed();
  console.log("deployed to:", deployment.address);

  const proxyImplAddress = await upgrades.erc1967.getImplementationAddress(
    deployment.address
  );
  console.log("verifying implementation: ", proxyImplAddress);
  await hre.run("verify:verify", { address: proxyImplAddress });
});
