// SPDX-Licence-Identifier: MIT

// Fund money to users
// Withdraw 
// Set minimum amount to transfer


pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface _priceFeed) internal view returns(uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI 
        AggregatorV3Interface priceFeed = _priceFeed;

        // (uint80 roundId, int256 price, uint256 startedAt, uint256 timestamp, uint80 answeredInRound)  = priceFeed.latestRoundData();

        (, int256 price,,, )  = priceFeed.latestRoundData();

        return uint256(price * 10000000000);
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns(uint256){
        // 1 ETH
        // 3000_000000000000000000
        uint256 ethPrice = getPrice(priceFeed);
        // (3000_000000000000000000 * 1_000000000000000000) / 1e18;
        // 3000$
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;

        return ethAmountInUsd;
    }

}
