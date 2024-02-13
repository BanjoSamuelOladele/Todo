

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ITodo.sol";
import "./Todo.sol";


contract TodoImpl is ITodo {

    Todo[] private todos;

    function createTodo(string memory title, string memory description) external override {
        Todo memory todo;
        todo.description = description;
        todo.title = title;
        todos.push(todo);
    }

    function getNumberOfTodos() external view override returns (uint) {
        return todos.length;
    }
}