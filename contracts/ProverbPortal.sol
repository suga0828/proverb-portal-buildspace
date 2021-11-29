// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ProverbPortal {
    uint256 public proverbsCount = 0;
    mapping(address => uint256) public persons;

    event NewProverb(address indexed from, uint256 timestamp, string message);

    struct Proverb {
        address from;
        uint256 timestamp;
        string message;
    }

    Proverb[] public proverbs;

    function sayProverb(string memory _message) public {
        proverbsCount++;
        persons[msg.sender]++;

        proverbs.push(Proverb(msg.sender, block.timestamp, _message));

        emit NewProverb(msg.sender, block.timestamp, _message);
    }

    function getProverbs() public view returns (Proverb[] memory) {
        return proverbs;
    }

    function getTotalProverbs() public view returns (uint256) {
        console.log("We have %d total proverbs!", proverbsCount);
        return proverbsCount;
    }
}
