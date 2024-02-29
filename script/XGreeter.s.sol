// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {XGreeter} from "../src/XGreeter.sol";

contract XGreeterDeploymentScript is Script {
    address portalAddress = address(0); // Set to the appropriate portal address

    function setUp() public {}

    function run() public {
        // Define the RPC URLs for Arbitrum Goerli and Goerli Network
        string memory arbitrumGoerliRpcUrl = "<Arbitrum Goerli RPC URL>";
        string memory goerliRpcUrl = "<Goerli RPC URL>";

        // Deploy on Arbitrum Goerli
        deployOnChain(arbitrumGoerliRpcUrl, "Arbitrum Goerli");

        // Deploy on Goerli Network
        deployOnChain(goerliRpcUrl, "Goerli Network");
    }

    function deployOnChain(string memory rpcUrl, string memory networkName) internal {
        uint256 chainId = vm.createFork(rpcUrl);
        vm.selectFork(chainId);

        console.log("Deploying XGreeter on", networkName);
        XGreeter xGreeter = new XGreeter(portalAddress);
        console.log("Deployed XGreeter at:", address(xGreeter));
    }
}
