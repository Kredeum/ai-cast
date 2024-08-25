// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";

contract DeployAiCast is DeployLite {
    function deployAiCast() public returns (address aiCast) {
        uint32 gasLimit = 300000;
        string memory javascript = vm.readFile("chainlink/source/ai-cast.js");

        address router = readAddress("Router");
        bytes32 donID = readBytes32("DonID");
        uint64 donHostedSecretsVersion = uint64(readUint("DonHostedSecretsVersion"));
        uint64 subscriptionId = uint64(readUint("SubscriptionId"));

        aiCast = deployLite(
            "AiCast", abi.encode(router, javascript, subscriptionId, gasLimit, donID, donHostedSecretsVersion)
        );
    }

    function run() public virtual {
        deployAiCast();
    }
}
