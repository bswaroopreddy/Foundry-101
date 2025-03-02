
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
 import {DeployFundMe} from "../script/DeployFundMe.s.sol";
// Test
contract FundMeTest is Test {
    // uint256 number = 1;
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_VALUE = 10 ether;
   
    function setUp() external {
       // number = 2;
      // fundMe  = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);

      DeployFundMe deployFundMe = new DeployFundMe();
      fundMe = deployFundMe.run();
      vm.deal(USER, STARTING_VALUE);
    }

    // function testDemo() public {
    //     console.log(number);
    //     console.log('Hi Mom');
    //     assertEq(number, 2);
    // }

    function testMinimumUSDIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        //assertEq(fundMe.i_owner(), address(this));
       assertEq(fundMe.i_owner(), msg.sender);
    }

    function testGetVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();    // send a 0 value
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amtFunded = fundMe.getAddressToAmountFunded(USER);

        assertEq(amtFunded, SEND_VALUE);
    }
}
