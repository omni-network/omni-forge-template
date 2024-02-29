// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";
import {XGreeter} from "../src/XGreeter.sol";
import {MockXApp} from "./utils/MockXApp.sol";

contract XGreeterTest is Test {
    XGreeter public xGreeter;
    MockXApp public mockXApp;

    address public constant portal = address(0x1234); // Example portal address

    function setUp() public {
        mockXApp = new MockXApp(portal); // The mockXApp is initialized with the portal address
        xGreeter = new XGreeter(address(mockXApp));
    }

    // Test the xgreet function by checking the XCallInvoked event from MockXApp
    function test_XGreet() public {
        string memory testGreeting = "Hello, blockchain!";
        uint64 destChainId = 1; // Example destination chain ID
        address to = address(0xdead); // Example destination address

        // Expect the XCallInvoked event to be emitted by mockXApp when xgreet is called
        vm.expectEmit(true, true, true, true, address(mockXApp));
        emit mockXApp.XCallInvoked(destChainId, to, abi.encodeWithSignature("greet(string)", testGreeting));

        xGreeter.xgreet(destChainId, to, testGreeting);
    }

    // Test direct call to greet function should revert
    function test_Greet_DirectCallReverts() public {
        string memory testGreeting = "Direct call should fail";

        // Expecting a revert with a specific error message
        vm.expectRevert("XGreeter: only xcall");
        xGreeter.greet(testGreeting);
    }

    // Add more tests to cover various scenarios and edge cases here ...
}
