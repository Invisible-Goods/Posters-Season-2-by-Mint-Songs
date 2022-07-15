// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0;

import "../src/test.sol";

contract DemoTest is DSTest {
    function test_this() public pure {
        require(true);
    }

    function test_logs() public {
        emit log("-- log(string)");
        emit log("a string");

        emit log("-- log_named_uint(string, uint)");
        emit log_named_uint("uint", 512);

        emit log("-- log_named_int(string, int)");
        emit log_named_int("int", -512);

        emit log("-- log_named_address(string, address)");
        emit log_named_address("address", address(this));

        emit log("-- log_named_bytes32(string, bytes32)");
        emit log_named_bytes32("bytes32", "a string");

        emit log("-- log_named_bytes(string, bytes)");
        emit log_named_bytes("bytes", hex"cafefe");

        emit log("-- log_named_string(string, string)");
        emit log_named_string("string", "a string");

        emit log("-- log_named_decimal_uint(string, uint, uint)");
        emit log_named_decimal_uint("decimal uint", 1.0e18, 18);

        emit log("-- log_named_decimal_int(string, int, uint)");
        emit log_named_decimal_int("decimal int", -1.0e18, 18);
    }

    event log_old_named_uint(bytes32, uint256);

    function test_old_logs() public {
        emit log_old_named_uint("key", 500);
        emit log_named_bytes32("bkey", "val");
    }

    function test_trace() public view {
        this.echo("string 1", "string 2");
    }

    function test_multiline() public {
        emit log("a multiline\\nstring");
        emit log("a multiline string");
        emit log_bytes("a string");
        emit log_bytes("a multiline\nstring");
        emit log_bytes("a multiline\\nstring");
        emit logs(hex"0000");
        emit log_named_bytes("0x0000", hex"0000");
        emit logs(hex"ff");
    }

    function echo(string memory s1, string memory s2)
        public
        pure
        returns (string memory, string memory)
    {
        return (s1, s2);
    }

    function prove_this(uint256 x) public {
        emit log_named_uint("sym x", x);
        assertGt(x + 1, 0);
    }

    function test_logn() public {
        assembly {
            log0(0x01, 0x02)
            log1(0x01, 0x02, 0x03)
            log2(0x01, 0x02, 0x03, 0x04)
            log3(0x01, 0x02, 0x03, 0x04, 0x05)
        }
    }

    event MyEvent(uint256, uint256 indexed, uint256, uint256 indexed);

    function test_events() public {
        emit MyEvent(1, 2, 3, 4);
    }
}

contract DemoTestWithSetUp {
    function setUp() public {}

    function test_pass() public pure {}
}
