

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ITodo.sol";


contract TodoImpl is ITodo {
    uint number = 1;
    function createTodo(
        string memory title,
        string memory description
    ) external override {}

    function getNumberOfTodos() external view override returns (uint) {
        return number;
    }
}