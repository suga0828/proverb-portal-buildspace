// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ProverbPortal {
    uint256 public proverbsCount = 0;

    uint256 private seed;

    event NewProverb(address indexed from, uint256 timestamp, string message);

    struct Proverb {
        address from;
        uint256 timestamp;
        string message;
    }

    Proverb[] public proverbs;

    mapping(address => uint256) public lastProverbAt;

    constructor() payable {
        console.log("ProverbPortal constructor");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function sayProverb(string memory _message) public {
        require(
            lastProverbAt[msg.sender] + 1 minutes < block.timestamp,
            "You can only say a proverb every 1 minute"
        );

        lastProverbAt[msg.sender] = block.timestamp;
        proverbsCount++;

        proverbs.push(Proverb(msg.sender, block.timestamp, _message));

        seed = (block.timestamp + block.difficulty + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has.0"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

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
