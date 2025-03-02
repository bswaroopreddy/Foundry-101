
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
 import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
 import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
// Test 

contract Interactions is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_VALUE = 10 ether;
    uint256 constant GAS_PRICE = 1;
   

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();

        fundMe = deploy.run();
        vm.deal(USER, STARTING_VALUE);

    }

    // function testUserCanFundInteractions() external {
    //     FundFundMe fundFundMe = new FundFundMe();
    //     vm.prank(USER);
    //     vm.deal(USER, 1e18);
    //     fundFundMe.fundFundMe(address(fundMe));

    //     address funder = fundMe.getFunder(0);

    //     assertEq(USER, funder);

    // }

    function testUserCanFundInteractions() external {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withDrawFundMe = new WithdrawFundMe();
        withDrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);

    }
}