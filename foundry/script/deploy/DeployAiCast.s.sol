// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";

contract DeployAiCast is DeployLite {
    address public router = 0xb83E47C2bC239B3bf370bc41e1459A34b41238D0;
    uint64 public subscriptionId = 3275;
    uint32 public gasLimit = 300000;
    bytes32 public donID = 0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000;

    function deployAiCast() public returns (address) {
        return deployLite("AiCast", abi.encode(router, subscriptionId, gasLimit, donID));
    }

    function run() public virtual {
        deployAiCast();
    }
}
