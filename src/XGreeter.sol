// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import {XApp} from "omni-network/omni/contracts/src/pkg/XApp.sol";

/*
 * @title XGreeter
 * @notice A cross chain greeter
 */
contract XGreeter is XApp {
    /// @dev Emitted when someone greets the ether
    event Greetings(address indexed from, uint64 indexed fromChainId, string greeting);

    constructor(address portal) XApp(portal) {}

    /// @dev Greet on another chain
    ///      `xcall` is a method inherited from `XApp`
    function xgreet(uint64 destChainId, address to, string calldata greeting) external {
        xcall(destChainId, to, abi.encodeWithSignature("greet(string)", greeting));
    }

    /// @dev Greet on this chain
    ///      The `xrecv` modifier reads the current xmsg into `xmsg` storage
    function greet(string calldata greeting) external xrecv {
        require(isXCall(), "XGreeter: only xcall");
        emit Greetings(xmsg.sender, xmsg.sourceChainId, greeting);
    }
}
