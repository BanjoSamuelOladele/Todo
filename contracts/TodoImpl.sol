// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract TodoImpl is ITodo{

    Todo[] private todos;

    error AlreadyExistingTitle(string message);
    error TodoDoesNotExist(string message);
    event DisplayMessage(string message);

    function createTodo(string memory title, string memory description) external {
        checkIfTodoTitleExist(title);
        Todo memory todo;
        todo.title = title;
        todo.description = description;
        todo.id = todos.length + 1;
        todos.push(todo);
        emit DisplayMessage("Created successfully...");
    }

    function checkIfTodoTitleExist(string memory title) private view   {
        for (uint i = 0; i < todos.length; i++) {
            if (compareTitles(todos[i].title, title)) revert AlreadyExistingTitle("a title with this title already exist...");
        }
    }

    function compareTitles(string memory savedTitle, string memory secondTiltle) private pure returns (bool){
        return keccak256(bytes(savedTitle)) == keccak256(bytes(secondTiltle));
    }

    function getAllTodos() external view returns(Todo[] memory){
        return todos;
    }

    function findTodoById(uint id) private view  returns (Todo memory, uint){
        for (uint location = 0; location < todos.length; location++) {
            if (todos[location].id == id) return (todos[location], location);
        }
        revert TodoDoesNotExist("could not locate a Todo with the provided id...");
    }

    function isDone(uint id) external {
        (Todo memory todo, uint location) = findTodoById(id);
        todo.isDone = !todo.isDone;
        todos[location] = todo;
        emit DisplayMessage("Updated successfully...");
    }

    function getTodoById(uint id) external view returns (Todo memory){
        (Todo memory todo, ) = findTodoById(id);
        return todo;
    }

    function deleteTodoById(uint id) external {
        (, uint index) = findTodoById(id);
        todos[index] = todos[todos.length - 1];
        todos.pop();
        emit DisplayMessage("Succesfully deleted...");
    }

    function updateTodoTitleById(string memory newTitle, uint id) external {
        (Todo memory todo, uint location) = findTodoById(id);
        todo.title = newTitle;
        todos[location] = todo;
        emit DisplayMessage("Title updated successfully...");
    }

    function updateTodoDescriptionById(string memory newDescription, uint id) external {
        (Todo memory todo, uint location) = findTodoById(id);
        todo.description = newDescription;
        todos[location] = todo;
        emit DisplayMessage("Description successfully updated...");
    }
}