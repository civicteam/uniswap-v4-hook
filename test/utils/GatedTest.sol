// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import { PRBTest } from "@prb/test/PRBTest.sol";
import "@gateway/contracts/GatewayToken.sol";
import "@gateway/contracts/FlagsStorage.sol";
import "@gateway/contracts/library/Charge.sol";
import "@gateway/contracts/Gated.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import "./GatewayUtils.sol";

contract GatedTest is PRBTest, GatewayUtils {
    uint public constant GATEKEEPER_NETWORK_SLOT_ID = 0;
    GatewayToken public gatewayToken;

    address public admin;
    address public userWithPass;
    address public userWithoutPass;
    address public gatekeeper;

    uint256 internal userWithPassPrivateKey;
    uint256 internal userWithoutPassPrivateKey;

    Charge public nullCharge;

    function setUp() public virtual {
        string memory mnemonic = "test test test test test test test test test test test junk";
        userWithPassPrivateKey = vm.deriveKey(mnemonic, 0);
        userWithoutPassPrivateKey = vm.deriveKey(mnemonic, 1);

        admin = vm.addr(1);
        userWithPass = vm.addr(userWithPassPrivateKey);
        userWithoutPass = vm.addr(userWithoutPassPrivateKey);
        gatekeeper = vm.addr(4);

        nullCharge = makeNullCharge();

        address flagsStorageProxy = deployFlagsStorage(admin);
        address gatewayTokenProxy = deployGatewayToken(admin, flagsStorageProxy);

        gatewayToken = GatewayToken(gatewayTokenProxy);

        createGatekeeperNetwork(gatewayToken, GATEKEEPER_NETWORK_SLOT_ID, gatekeeper);
    }
}
