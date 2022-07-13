// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "../PostersSeason2ByMintSongs.sol";
import "./libraries/ERC1155/ERC1155Receiver.sol";
import "./libraries/ds-test/src/test.sol";

contract PosterFactoryInitialize is DSTest, ERC1155Receiver {
    PostersSeason2ByMintSongs poster;
    string name = "my smart contract";
    string symbol = "wagmi";
    uint256 weiPerPoster = 100;

    function setUp() public {
        poster = new PostersSeason2ByMintSongs();

        poster.initialize(
            weiPerPoster,
            name,
            symbol,
            "my dontract description",
            "ipfs://cid",
            "https://mintsongs.com",
            300,
            0xcfBf34d385EA2d5Eb947063b67eA226dcDA3DC38,
            0x9399BB24DBB5C4b782C70c2969F58716Ebbd6a3b
        );
    }

    function testInitialized() public {
        assertEq(poster.weiPerPoster(), weiPerPoster);
        assertEq(poster.name(), name);
        assertEq(poster.symbol(), symbol);
        assertEq(
            poster.contractURI(),
            "data:application/json;base64,eyJuYW1lIjogIm15IHNtYXJ0IGNvbnRyYWN0IiwgImRlc2NyaXB0aW9uIjogIm15IGRvbnRyYWN0IGRlc2NyaXB0aW9uIiwgImltYWdlIjogImlwZnM6Ly9jaWQiLCAiZXh0ZXJuYWxfbGluayI6ICJodHRwczovL21pbnRzb25ncy5jb20iLCAic2VsbGVyX2ZlZV9iYXNpc19wb2ludHMiOiAiMzAwIiwgImZlZV9yZWNpcGllbnQiOiAiMHhjZmJmMzRkMzg1ZWEyZDVlYjk0NzA2M2I2N2VhMjI2ZGNkYTNkYzM4In0="
        );
    }

    function testCreatePoster() public {
        poster.createPoster{value: 10000}(
            "Sweet Poster",
            "My Sweet Poster",
            "ipfs://cid",
            PosterMetadata.PosterMediaType.IMAGE,
            0xcfBf34d385EA2d5Eb947063b67eA226dcDA3DC38,
            100
        );
        assertEq(
            poster.uri(1),
            "data:application/json;base64,eyJuYW1lIjogIlN3ZWV0IFBvc3RlciIsICJkZXNjcmlwdGlvbiI6ICJNeSBTd2VldCBQb3N0ZXIiLCAidXJsIjogImlwZnM6Ly9jaWQifQ=="
        );
        assertEq(
            poster.uri(2),
            "data:application/json;base64,eyJuYW1lIjogIiIsICJkZXNjcmlwdGlvbiI6ICIiLCAidXJsIjogIiJ9"
        );
    }
}
