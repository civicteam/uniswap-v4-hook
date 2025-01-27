// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

import { IPoolManager, GatewayHook} from "./GatewayHook.sol";

contract GatewayHookFactory {
    function deploy(address owner, IPoolManager poolManager, bytes32 salt, address gatewayTokenContract, uint gatekeeperNetwork) external returns (address) {
        return address(new GatewayHook{salt: salt}(owner, poolManager, gatewayTokenContract, gatekeeperNetwork));
    }

    function getPrecomputedHookAddress(
        address owner,
        IPoolManager poolManager,
        bytes32 salt,
        address gatewayTokenContract,
        uint gatekeeperNetwork
    )
        external
        view
        returns (address)
    {
        bytes32 bytecodeHash =
            keccak256(abi.encodePacked(type(GatewayHook).creationCode, abi.encode(owner, poolManager, gatewayTokenContract, gatekeeperNetwork)));
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), salt, bytecodeHash));
        return address(uint160(uint256(hash)));
    }
}
