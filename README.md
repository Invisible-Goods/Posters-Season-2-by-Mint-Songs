# Poster Factory by Mint Songs

- deploy a custom poster on a shared ERC1155 smart contract.

## Verified Deployments

- Polygon (MATIC): TBD.
- Mumbai Testnet: [0xd31448bcfa8d962839eb0bcf23f41e81368ebbeb](https://mumbai.polygonscan.com/address/0xd31448bcfa8d962839eb0bcf23f41e81368ebbeb).

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
OPENZEPPELIN_DEFENDER_TEAM_API_KEY=
OPENZEPPELIN_DEFENDER_TEAM_API_SECRET_KEY=
TESTNET_PRIVATE_KEY=
MAINNET_PRIVATE_KEY=
RPC_ETHEREUM=
RPC_RINKEBY=
RPC_GOERLI=
RPC_MATIC=
RPC_MUMBAI=
ETHERSCAN_API_KEY=
POLYGONSCAN_API_KEY=
POSTER_FACTORY_CONTRACT_ADDRESS_MUMBAI=
```
