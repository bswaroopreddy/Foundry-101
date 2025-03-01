// Fund money to users
// Withdraw 
// Set minimum amount to transfer


// 8,40,456 gas
    // 8,17,004 gas - after MINIMUM_USD to constanat
    // 790387 gas - after making owner to immutable
    

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

import {PriceConverter} from "./PriceConverter.sol";


error noOwner();

// constant, immutability

contract FundMe {

    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    
    // constant and immutable variables store directly into the bytecode instead of storage
    uint256 public constant MINIMUM_USD = 5 * 1000000000000000000;
    // 347 - constant
    // 2446 - non-constant

    address public immutable i_owner;
    // 439 gas - immutable
    //  2574 gas - non-immutable

    AggregatorV3Interface private s_priceFeed;
    
    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    // Allow function to sent value (payable) in native cryptocurrency
    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) {
            revert noOwner();
        }
        _;
    }

     function withdraw() public onlyOwner {
        // require(msg.sender == owner, "must be owner");
        
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    function getVersion() public view returns(uint){
        return s_priceFeed.version();
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
     }
}
