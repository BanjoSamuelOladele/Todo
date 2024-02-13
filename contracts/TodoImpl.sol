

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ITodo.sol";
import "./Todo.sol";


contract TodoImpl is ITodo {
    

    Todo[] private todos;
    error AlreadyExistingTitle(string message);

    function createTodo(string memory title, string memory description) external override {
        checkIfTodoTitleExist(title);
        Todo memory todo;
        todo.description = description;
        todo.title = title;
        todos.push(todo);
    }
    function checkIfTodoTitleExist(string memory title) private view   {
        for (uint i = 0; i < todos.length; i++) {
            if (compareTitles(todos[i].title, title)) revert AlreadyExistingTitle("a title with this title already exist...");
        }
    }
    function compareTitles(string memory savedTitle, string memory secondTiltle) private pure returns (bool){
        return keccak256(bytes(savedTitle)) == keccak256(bytes(secondTiltle));
    }

    function getNumberOfTodos() external view override returns (uint) {
        return todos.length;
    }
}