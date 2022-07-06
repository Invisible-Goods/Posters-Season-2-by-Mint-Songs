const { task } = require("hardhat/config");

task("deploy", "Deploys a contract").setAction(async () => {
  await hre.run("compile");

  const ERC_1155_FACTORY = await hre.ethers.getContractFactory("PosterFactory");
  const deployment = await hre.upgrades.deployProxy(
    ERC_1155_FACTORY,
    [
      "Posters (Season 2) by Mint Songs",
      "PS2",
      "Posters (Season 2) by Mint Songs. TODO: work with Dwight / Nathan to get more info here.",
      "ipfs://QmWoaiiNB9NoDfj3q1xhMt6DJSAU8fMsNePuhH8gwbaKND",
      "https://mintsongs.com",
      300,
      "0x0CC9F41a5bDc884A95dEfB0b38DED565BB36C7BF", // Mint Songs Multi-Sig (Mumbai)
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
