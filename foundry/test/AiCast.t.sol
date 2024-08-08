// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {AiCast} from "../src/AiCast.sol";

contract AiCastTest is Test {
    AiCast public aicast;

    function setUp() public {
        aicast = new AiCast();
    }

    function testFuzz_SetQuestion(string calldata question) public {
        aicast.setQuestion(question);
        assertEq(aicast.question(), question);
    }
}
