// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {AiCast} from "src/AiCast.sol";

contract DeployAiCast is DeployLite {
    function deployAiCast() public returns (address) {
        return deployLite("AiCast");
    }

    function run() public virtual {
        deployAiCast();
    }
}
