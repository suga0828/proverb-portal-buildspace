// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ProverbPortal {
  uint public proverbs = 0;
  mapping (address => uint256) public persons;

  function sayProverb() public {
    proverbs++;
    persons[msg.sender]++;
    console.log("%s has say an proverb!", msg.sender);
  }

  function getTotalproverbs() public view returns (uint256) {
    console.log("We have %d total proverbs!", proverbs);
    return proverbs;
  }
}