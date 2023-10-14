// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19;

import {GatewayHookFactory} from "../src/GatewayHookFactory.sol";
import { BaseScript } from "./Base.s.sol";

contract Deploy is BaseScript {
    function run() public broadcaster returns (GatewayHookFactory gatewayHookFactory) {
        gatewayHookFactory = new GatewayHookFactory();
    }
}
