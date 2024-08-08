// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";

import {DeployCounter} from "./DeployCounter.s.sol";
import {DeployAiCast} from "./DeployAiCast.s.sol";
import {DeployFunctionsConsumerExample} from "./DeployFunctionsConsumerExample.s.sol";

contract DeployAll is DeployCounter, DeployAiCast, DeployFunctionsConsumerExample {
    function run() public override(DeployCounter, DeployAiCast, DeployFunctionsConsumerExample) {
        console.log("chainId %s  msg.sender @%s", block.chainid, msg.sender);

        deployCounter();
        deployAiCast();
        deployFunctionsConsumerExample();
    }
}
