// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {AiCast} from "@ai-cast/AiCast.sol";
import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";

contract AiCastTest is Test, DeployLite {
    address public router = 0xb83E47C2bC239B3bf370bc41e1459A34b41238D0;
    uint64 public subscriptionId = 3275;
    uint32 public gasLimit = 300000;
    bytes32 public donID = 0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000;

    AiCast public aicast;

    function setUp() public {
        aicast = new AiCast(router, subscriptionId, gasLimit, donID);
    }

    function testFuzz_SetQuestion(string calldata question) public {
        aicast.setQuestion(question);
        assertEq(aicast.question(), question);
    }
}
