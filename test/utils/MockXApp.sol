// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {XApp} from "omni-network/omni/contracts/src/pkg/XApp.sol";

contract MockXApp is XApp {
    // Event to emit whenever xcall is called for tracking
    event XCallInvoked(uint64 destChainId, address to, bytes data);

    constructor(address portal) XApp(portal) {}

    // Override xcall to emit an event instead of performing actual cross-chain call
    function xcall(uint64 destChainId, address to, bytes calldata data) public override {
        emit XCallInvoked(destChainId, to, data);
    }
}
