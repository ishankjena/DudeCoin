// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DudeCoin} from "../src/DudeCoin.sol";

contract DeployDudeCoin is Script {

	// config
	uint256 public constant DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
	uint256 public deployerKey;
	uint256 public constant INITIAL_SUPPLY = 1_000_000 ether;

	function run() external returns (DudeCoin) {

		// network config
		if(block.chainid==31337){
			deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
		}else{
			deployerKey = vm.envUint("PRIVATE_KEY");
		}

		vm.startBroadcast(deployerKey);
		DudeCoin coin = new DudeCoin(INITIAL_SUPPLY);
		vm.stopBroadcast();

		return coin;
	}
	
}

