// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PollingSystem {
    struct Poll {
        string title;
        string[] options;
        uint endTime;
        mapping(uint => uint) voteCount;
        mapping(address => bool) hasVoted;
        bool created;
    }

    mapping(uint => Poll) private polls;
    uint public pollIdCounter;

    // Create a new poll
    function createPoll(string memory _title, string[] memory _options, uint _durationInMinutes) public {
        require(_options.length >= 2, "Need at least two options");

        Poll storage p = polls[pollIdCounter];
        p.title = _title;
        p.options = _options;
        p.endTime = block.timestamp + (_durationInMinutes * 1 minutes);
        p.created = true;

        pollIdCounter++;
    }

    // Vote for an option by index
    function vote(uint pollId, uint optionIndex) public {
        Poll storage p = polls[pollId];
        require(p.created, "Poll does not exist");
        require(block.timestamp < p.endTime, "Poll has ended");
        require(!p.hasVoted[msg.sender], "Already voted");
        require(optionIndex < p.options.length, "Invalid option");

        p.voteCount[optionIndex]++;
        p.hasVoted[msg.sender] = true;
    }

    // Get poll options
    function getPollOptions(uint pollId) public view returns (string[] memory) {
        require(polls[pollId].created, "Poll does not exist");
        return polls[pollId].options;
    }

    // Get winning option
    function getWinningOption(uint pollId) public view returns (string memory) {
        Poll storage p = polls[pollId];
        require(block.timestamp >= p.endTime, "Poll is still active");

        uint highestVotes = 0;
        uint winningIndex = 0;

        for (uint i = 0; i < p.options.length; i++) {
            if (p.voteCount[i] > highestVotes) {
                highestVotes = p.voteCount[i];
                winningIndex = i;
            }
        }

        return p.options[winningIndex];
    }
}
