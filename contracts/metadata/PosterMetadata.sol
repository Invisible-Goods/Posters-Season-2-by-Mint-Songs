// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract PosterMetadata {
    enum PosterKind {
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
        PosterKind kind;
    }

    // Mapping of PosterID => Poster.
    mapping(uint256 => Poster) public poster;
}
