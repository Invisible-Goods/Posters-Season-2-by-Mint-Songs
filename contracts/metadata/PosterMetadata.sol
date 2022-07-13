// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract PosterMetadata {
    enum PosterMediaType {
        IMAGE,
        VIDEO
    }

    struct Poster {
        address creator;
        string name;
        string description;
        string imageUri;
        uint256 count;
        uint256 maxSupply;
        address royaltyRecipient;
        PosterMediaType media_type;
    }

    // Mapping of PosterID => Poster.
    mapping(uint256 => Poster) public poster;
}
