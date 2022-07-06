// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract PosterMetadata {
    struct Poster {
        address creator;
        string name;
        string description;
        string imageUri;
        uint256 count;
        uint256 maxSupply;
        address royaltyRecipient;
    }

    // Mapping of PosterID => Poster.
    mapping(uint256 => Poster) public poster;
}
