const { task } = require("hardhat/config");
const { AdminClient } = require("defender-admin-client");
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
    if (contractName === "ETH_ERC721") {
      const client = new AdminClient({
        apiKey: process.env.DEFENDER_TEAM_API_KEY,
        apiSecret: process.env.DEFENDER_TEAM_API_SECRET_KEY,
      });

      const becaonUpgradeProposal = await client.createProposal({
        contract: { address: getBeaconAddress(network), network: network.name },
        title: `Upgrade beacon to ${newImplAddress.substring(0, 11)}`,
        description: `call UpgradeTo with implementation ${newImplAddress}`,
        type: "custom",
        functionInterface: {
          name: "upgradeTo",
          inputs: [{ type: "address", name: "newImplementation" }],
        }, // Function ABI
        functionInputs: [newImplAddress], // Arguments to the function
        via: getMultisigAddress(network), // Address to execute proposal
        viaType: "Gnosis Safe",
      });
      console.log(
        "Beacon upgrade proposal created at:",
        becaonUpgradeProposal.url
      );
    }

    console.log("verifying new implementation: ", newImplAddress);
    await hre.run("verify:verify", {
      address: newImplAddress,
    });
  }
);
