// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "../PosterFactory.sol";
import "./libraries/ds-test/src/test.sol";

contract PosterFactoryTest is DSTest {
    PosterFactory greeter;

    function setUp() public {}

    function testInitialize() public {
        greeter = new PosterFactory();

        assertEq(greeter.weiPerPoster(), 0);
        assertEq(greeter.name(), "");
        assertEq(greeter.symbol(), "");

        string memory name = "my smart contract";
        string memory symbol = "wagmi";

        greeter.initialize(
            100,
            name,
            symbol,
            "my dontract description",
            "ipfs://cid",
            "https://mintsongs.com",
            300,
            0xcfBf34d385EA2d5Eb947063b67eA226dcDA3DC38
        );

        assertEq(greeter.weiPerPoster(), 100);
        assertEq(greeter.name(), name);
        assertEq(greeter.symbol(), symbol);
    }
}
