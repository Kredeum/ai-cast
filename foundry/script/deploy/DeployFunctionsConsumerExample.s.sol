// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {FunctionsConsumerExample} from "src/FunctionsConsumerExample.sol";
// import {console} from "forge-std/console.sol";

contract DeployFunctionsConsumerExample is DeployLite {
    function deployFunctionsConsumerExample() public returns (address) {
        return deployLiteImmutable("FunctionsConsumerExample", abi.encode(readAddress("Router")));
    }

    function run() public virtual {
        deployFunctionsConsumerExample();
    }
}
