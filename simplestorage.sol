// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // Declaring the variable
    int public storedValue;

    // Constructor (optional): set initial value
    constructor() {
        storedValue = 0;
    }

    // Function to increment the value
    function increment() public {
        storedValue += 1;
    }

    // Function to decrement the value
    function decrement() public {
        storedValue -= 1;
    }

    // Optional: View function (if variable wasn't public)
    function getValue() public view returns (int) {
        return storedValue;
    }
}
