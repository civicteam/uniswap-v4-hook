import { PRBTest } from "@prb/test/PRBTest.sol";
import "@gateway/contracts/GatewayToken.sol";
import "@gateway/contracts/FlagsStorage.sol";
import "@gateway/contracts/library/Charge.sol";
import "@gateway/contracts/Gated.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import "./GatewayUtils.sol";

contract GatedTest is PRBTest {
    GatewayToken public gatewayToken;

    address public admin;
    address public userWithPass;
    address public userWithoutPass;
    address public gatekeeper;

    uint256 internal userWithPassPrivateKey;
    uint256 internal userWithoutPassPrivateKey;

    function setUp() public virtual {
        string memory mnemonic = "test test test test test test test test test test test junk";
        relayerPrivateKey = vm.deriveKey(mnemonic, 0);
        userWithPassPrivateKey = vm.deriveKey(mnemonic, 1);
        userWithoutPassPrivateKey = vm.deriveKey(mnemonic, 2);

        admin = vm.addr(1);
        userWithPass = vm.addr(userWithPassPrivateKey);
        userWithoutPass = vm.addr(userWithoutPassPrivateKey);
        gatekeeper = vm.addr(4);
        relayer = vm.addr(relayerPrivateKey);

        Charge memory nullCharge = makeNullCharge();

        address flagsStorageProxy = deployFlagsStorage(admin);
        address gatewayTokenProxy = deployGatewayToken(admin, flagsStorageProxy);

        gatewayToken = GatewayToken(gatewayTokenProxy);

        createGatekeeperNetwork(gatewayToken, 0, gatekeeper);

        vm.prank(gatekeeper);
        gatewayToken.mint(userWithPass, 0, 0, 0, nullCharge);
    }
}
