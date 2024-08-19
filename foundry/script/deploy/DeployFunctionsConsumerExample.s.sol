// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
// import {console} from "forge-std/console.sol";

contract DeployFunctionsConsumerExample is DeployLite {
    function deployFunctionsConsumerExample() public returns (address) {
        return deployLite("FunctionsConsumerExample", abi.encode(readAddress("Router")));
    }

    function run() public virtual {
        deployFunctionsConsumerExample();
    }
}
