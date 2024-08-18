// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DeployLite} from "@forge-deploy-lite/DeployLite.s.sol";
import {FunctionsConsumerExample} from "../src/FunctionsConsumerExample.sol";
import {console} from "forge-std/console.sol";

contract SendRequest is DeployLite {
    function run() public virtual {
        require(block.chainid == 11155111, "Script dedicated to Sepolia!");

        FunctionsConsumerExample functionsConsumerExample =
            FunctionsConsumerExample(readAddress("FunctionsConsumerExample"));

        bytes[] memory bm = new bytes[](0);
        string[] memory sm = new string[](1);
        sm[0] = "44";

        vm.startBroadcast(msg.sender);
        functionsConsumerExample.sendRequest(
            "return Functions.encodeUint256(Number(args[0]));",
            "",
            0,
            0,
            sm,
            bm,
            3275,
            300000,
            0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000
        );
        vm.stopBroadcast();
    }
}
