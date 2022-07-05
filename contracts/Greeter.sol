//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./metadata/ERC1155OnChainMetadata.sol";

contract Greeter is ERC1155OnChainMetadata {
    string private greeting;

    function initialize(string memory uri_) external initializer {
        __ERC1155_init(uri_);
        console.log("Deploying a Greeter with greeting:", uri_);
        greeting = uri_;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
