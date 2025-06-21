// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSend {
    // Function to distribute Ether equally to all provided addresses
    function distribute(address[] calldata recipients) external payable {
        uint total = recipients.length;
        require(total > 0, "Recipient list is empty");
        require(msg.value > 0, "No Ether sent");

        uint amountPerAddress = msg.value / total;

        for (uint i = 0; i < total; i++) {
            (bool success, ) = recipients[i].call{value: amountPerAddress}("");
            require(success, "Transfer failed to one of the addresses");
        }
    }

    // Function to check contract balance (for testing)
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
