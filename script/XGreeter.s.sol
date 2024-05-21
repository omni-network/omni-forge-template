// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {XGreeter} from "../src/XGreeter.sol";

contract DeployXGreeter is Script {
    address public portalAddress = address(0xb835Dc695C6bFC8373c0d56973B5d9E9B083E97b); // CLI devnet portal address, use desired network

    function run() external {
        vm.startBroadcast();

        XGreeter xGreeter = new XGreeter(portalAddress);
        console.log("Deployed XGreeter at:", address(xGreeter));

        vm.stopBroadcast();
    }
}
