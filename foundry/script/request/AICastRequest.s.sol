// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {AiCast} from "@ai-cast/AiCast.sol";
import {console} from "forge-std/console.sol";

contract AICastRequest is DeployLite {
    function run() public virtual {
        uint64 donHostedSecretsVersion = uint64(readUint("DonHostedSecretsVersion"));
        address aiCastAddress = readAddress("AiCast");
        console.log("run ~ aiCastAddress:", aiCastAddress);
        AiCast aiCast = AiCast(aiCastAddress);

        uint64 previousDonHostedSecretsVersion = aiCast.donHostedSecretsVersion();

        string memory javascript = vm.readFile("chainlink/source/ai-cast.js");
        string memory previousJavascript = aiCast.javascript();

        vm.startBroadcast(msg.sender);
        if (!_stringEqual(javascript, previousJavascript)) {
            console.log("run ~ previousJavascript:", previousJavascript);
            console.log("run ~ javascript:", javascript);
            aiCast.setJavascript(javascript);
        }
        if (donHostedSecretsVersion != previousDonHostedSecretsVersion) {
            console.log("run ~ previousDonHostedSecretsVersion:", previousDonHostedSecretsVersion);
            console.log("run ~ donHostedSecretsVersion:", donHostedSecretsVersion);
            aiCast.setDonHostedSecretsVersion(donHostedSecretsVersion);
        }
        aiCast.sendRequest("6*6=36?");
        vm.stopBroadcast();
    }
}
