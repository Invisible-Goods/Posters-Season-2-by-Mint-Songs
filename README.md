# Poster Factory by Mint Songs

- deploy a custom poster on a shared ERC1155 smart contract.

## Verified Deployments

- Polygon (MATIC): [0xE44AeC494fDd1f261B1642A4352f0273fa241f84](https://polygonscan.com/address/0xE44AeC494fDd1f261B1642A4352f0273fa241f84).
- Mumbai Testnet: [0xD6b25a4DEF0E7888e1cf07d09ec83d19eE299927](https://mumbai.polygonscan.com/address/0xD6b25a4DEF0E7888e1cf07d09ec83d19eE299927).

## Getting Started

1. clone repo: `git clone git@github.com:Invisible-Goods/poster-factory.git`
2. `cd poster-factory`
3. `yarn` (learn more about [yarn here](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable))
4. `npx hardhat deploy --network {your-network}`
5. copy and paste your contract address to your `.env` file as `POSTER_FACTORY_CONTRACT_ADDRESS_{your_network}`.

## Setting up ENV variables

1. create `.env.` in root of this project.
2. add the following ENV variables:

```
CONTRACT_WEI_PER_POSTER=
CONTRACT_NAME=
CONTRACT_SYMBOL=
CONTRACT_DESCRIPTION=
CONTRACT_IMAGE_URI=
CONTRACT_EXTERNAL_URL=
CONTRACT_SELLER_FEE_BASIS_POINTS=
MUMBAI_MULTISIG_ADDRESS=
MATIC_MULTISIG_ADDRESS=
MUMBAI_TRUSTED_FORWARDER_ADDRESS=
MATIC_TRUSTED_FORWARDER_ADDRESS
TESTNET_PRIVATE_KEY=
MAINNET_PRIVATE_KEY=
RPC_MATIC=
RPC_MUMBAI=
POLYGONSCAN_API_KEY=
POSTER_SEASON_2_CONTRACT_ADDRESS_MUMBAI=
POSTER_SEASON_2_CONTRACT_ADDRESS_MATIC=
OPENZEPPELIN_DEFENDER_TEAM_API_KEY=
OPENZEPPELIN_DEFENDER_TEAM_API_SECRET_KEY=
```
