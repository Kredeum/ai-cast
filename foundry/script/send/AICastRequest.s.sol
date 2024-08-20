// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {AiCast} from "@ai-cast/AiCast.sol";
// import {console} from "forge-std/console.sol";

contract AICastRequest is DeployLite {
    function run() public virtual {
        require(block.chainid == 11155111, "Script dedicated to Sepolia!");

        AiCast aiCast = AiCast(readAddress("AiCast"));
        string memory prompt = vm.readFile("chainlink/source/ai-cast.js");

        vm.startBroadcast(msg.sender);
        aiCast.sendRequest(prompt, "Combien font 6*7 ?", 1724093110);
        vm.stopBroadcast();
    }
}
