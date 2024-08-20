// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {AiCast} from "@ai-cast/AiCast.sol";

contract AICastRequest is DeployLite {
    uint64 public donHostedSecretsVersion = 1724155422;

    function run() public virtual {
        require(block.chainid == 11155111, "Script dedicated to Sepolia!");

        AiCast aiCast = AiCast(readAddress("AiCast"));
        uint64 previousDonHostedSecretsVersion = aiCast.donHostedSecretsVersion();

        vm.startBroadcast(msg.sender);
        if (previousDonHostedSecretsVersion != donHostedSecretsVersion) {
            aiCast.setDonHostedSecretsVersion(donHostedSecretsVersion);
        }
        aiCast.sendRequest("6*6=36?");
        vm.stopBroadcast();
    }
}
