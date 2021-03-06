// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/Base64Upgradeable.sol";
import "./PosterMetadata.sol";

abstract contract OnChainMetadata is PosterMetadata {
    // Name of Smart Contract.
    string public name;
    // Symbol of Smart Contract.
    string public symbol;
    // Description of Smart Contract.
    string public contract_description;
    // Image of Smart Contract.
    string public contract_image;
    // External Link of Smart Contract.
    string public contract_external_link;
    // Seller Fee Basis Points of Smart Contract.
    uint256 public contract_seller_fee_basis_points;
    // Fee Recipient of Smart Contract.
    address public contract_fee_recipient;

    /// Generate poster metadata from storage information as base64-json blob
    /// @param tokenId id of token
    function getMetadataPoster(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        bytes memory json = getPosterMetadataJSON(tokenId);
        return encodeMetadataJSON(json);
    }

    /// Generate contract metadata from storage information as base64-json blob
    function getMetadataContract() public view returns (string memory) {
        bytes memory json = getContractMetadataJSON();
        return encodeMetadataJSON(json);
    }

    /// Function to create the metadata json string for the nft edition
    /// @param tokenId id of token
    function getPosterMetadataJSON(uint256 tokenId)
        public
        view
        returns (bytes memory)
    {
        return
            abi.encodePacked(
                '{"name": "',
                poster[tokenId].name,
                '", "',
                'description": "',
                poster[tokenId].description,
                '", "',
                'url": "',
                poster[tokenId].imageUri,
                '"}'
            );
    }

    /// Function to create the metadata json string for the smart contract
    function getContractMetadataJSON() public view returns (bytes memory) {
        return
            abi.encodePacked(
                '{"name": "',
                name,
                '", "',
                'description": "',
                contract_description,
                '", "',
                'image": "',
                contract_image,
                '", "',
                'external_link": "',
                contract_external_link,
                '", "',
                'seller_fee_basis_points": "',
                StringsUpgradeable.toString(contract_seller_fee_basis_points),
                '", "',
                'fee_recipient": "',
                StringsUpgradeable.toHexString(
                    uint256(uint160(contract_fee_recipient)),
                    20
                ),
                '"}'
            );
    }

    /// Encodes the argument json bytes into base64-data uri format
    /// @param json Raw json to base64 and turn into a data-uri
    function encodeMetadataJSON(bytes memory json)
        public
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64Upgradeable.encode(json)
                )
            );
    }
}
