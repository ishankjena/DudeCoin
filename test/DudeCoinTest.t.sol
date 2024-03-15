// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DudeCoin} from "../src/DudeCoin.sol";
import {DeployDudeCoin} from "../script/DeployDudeCoin.s.sol";
import {Test} from "forge-std/Test.sol";

contract DudeCoinTest is Test {

	DudeCoin public coin;
	DeployDudeCoin public deployer;
	address public deployerAddress;
	address bob;
	address alice;
	uint256 constant INITIAL_AMOUNT = 100 ether;

	function setUp() public {
		deployer = new DeployDudeCoin();
		coin = deployer.run();

		bob = makeAddr("bob");
		alice = makeAddr("alice");
		
		deployerAddress = vm.addr(deployer.deployerKey());
		vm.prank(deployerAddress);
		coin.transfer(bob, INITIAL_AMOUNT);
	}
	
	function testAllowances() public {
		uint256 permittedAllowance = 1000;
		
		vm.prank(bob);
		coin.approve(alice, permittedAllowance);
		uint256 transferAmount = 420;

		vm.prank(alice);
		coin.transferFrom(bob, alice, transferAmount);

		assert(coin.balanceOf(alice) == transferAmount);
		assert(coin.balanceOf(bob) == INITIAL_AMOUNT-transferAmount);	
	}
	
}

