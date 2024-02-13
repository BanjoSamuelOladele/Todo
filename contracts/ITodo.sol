

import "./Todo.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ITodo {
    function createTodo(string memory title, string memory description) external;
    function getAllTodos() external returns(Todo[] memory);
    function isDone(uint id) external;
    function getTodoById(uint id) external view returns (Todo memory);
    function deleteTodoById(uint id) external;
    function updateTodoTitleById(string memory title, uint id) external;
    function updateTodoDescriptionById(string memory description, uint id) external; 
    function getAllNumberTodos() external view returns(uint);
}