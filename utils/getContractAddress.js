const getContractAddress = (network) => {
  if (network.name == "matic") {
    return process.env.POSTER_SEASON_2_CONTRACT_ADDRESS_MATIC;
  }
  if (network.name === "mumbai") {
    return process.env.POSTER_SEASON_2_CONTRACT_ADDRESS_MUMBAI;
  }
};

const getMultisigAddress = (network) => {
  if (network.name == "matic") {
    return process.env.MATIC_MULTISIG_ADDRESS;
  } else if (network.name === "mumbai") {
    return process.env.MUMBAI_MULTISIG_ADDRESS;
  }
};

const getTrustedForwarderAddress = (network) => {
  if (network.name == "matic") {
    return process.env.MATIC_TRUSTED_FORWARDER_ADDRESS;
  } else if (network.name === "mumbai") {
    return process.env.MUMBAI_TRUSTED_FORWARDER_ADDRESS;
  }
};

module.exports = {
  getContractAddress,
  getMultisigAddress,
  getTrustedForwarderAddress,
};
