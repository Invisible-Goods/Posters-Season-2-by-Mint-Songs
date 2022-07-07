// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "./OnChainMetadata.sol";

contract ERC1155OnChainMetadata is ERC1155Upgradeable, OnChainMetadata {
    function uri(uint256 tokenId)
        public
        view
        override(ERC1155Upgradeable)
        returns (string memory)
    {
        return getMetadataPoster(tokenId);
    }

    function contractURI() public view virtual returns (string memory) {
        return getMetadataContract();
    }
}
