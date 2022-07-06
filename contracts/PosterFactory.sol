//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./metadata/ERC1155OnChainMetadata.sol";

contract PosterFactory is ERC1155OnChainMetadata {
    string private greeting;

    function initialize(string memory uri_) external initializer {
        __ERC1155_init(uri_);
        greeting = uri_;
    }
}
