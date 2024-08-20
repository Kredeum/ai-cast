// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";

import {DeployAiCast} from "./DeployAiCast.s.sol";

contract DeployAll is DeployAiCast {
    function run() public override(DeployAiCast) {
        console.log("chainId %s  msg.sender @%s", block.chainid, msg.sender);

        deployAiCast();
    }
}
