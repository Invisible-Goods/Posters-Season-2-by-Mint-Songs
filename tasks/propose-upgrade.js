const { task } = require("hardhat/config");
const { getContractAddress } = require("../utils/getContractAddress");

task("propose-upgrade", "Propose a upgrade for a contract").setAction(
  async ({}) => {
    hre.run("compile");

    const supportedChains = ["mumbai", "matic"];

    if (!supportedChains.includes(network.name)) {
      console.log(`${network.name} not supported.`);
      return;
    }

    const contract = await hre.ethers.getContractFactory(
      "PostersSeason2ByMintSongs"
    );

    let address = getContractAddress(network);
    implAddress = await upgrades.erc1967.getImplementationAddress(address);
    console.log("Old implementation address:", implAddress);
    const proposal = await hre.defender.proposeUpgrade(address, contract);
    console.log("Upgrade proposal created at:", proposal.url);

    const newImplAddress = proposal.metadata.newImplementationAddress;

    console.log("verifying new implementation: ", newImplAddress);
    await hre.run("verify:verify", {
      address: newImplAddress,
    });
  }
);
