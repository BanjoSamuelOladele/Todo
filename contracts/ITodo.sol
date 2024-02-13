

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ITodo {
    function createTodo(string memory title, string memory description) external;
    function getNumberOfTodos() external view returns(uint);
}