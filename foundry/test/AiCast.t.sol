// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {AiCast} from "@ai-cast/AiCast.sol";
import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";

contract AiCastTest is Test, DeployLite {
    uint64 public subscriptionId = 3275;
    uint32 public gasLimit = 300000;
    address public router = readAddress("Router");
    bytes32 public donID = 0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000;
    uint64 public donHostedSecretsVersion = 1724155422;

    string javascript = vm.readFile("chainlink/source/ai-cast.js");

    AiCast public aicast;

    function setUp() public {
        aicast = new AiCast(router, javascript, subscriptionId, gasLimit, donID, donHostedSecretsVersion);
    }

    function testFuzz_SetDonHostedSecretsVersion(uint64 donHostedSecretsVersion_) public {
        aicast.setDonHostedSecretsVersion(donHostedSecretsVersion_);
        assertEq(aicast.donHostedSecretsVersion(), donHostedSecretsVersion_);
    }
}
