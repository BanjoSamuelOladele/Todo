import { ethers } from "hardhat";
import {assert, expect} from "chai";
import{anyValue} from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import {loadFixture} from "@nomicfoundation/hardhat-toolbox/network-helpers";

describe("Test Todo", function(){
    async function deployTodo(){
        const TodoImpl = await ethers.getContractFactory("TodoImpl");
        const todoImpl = await TodoImpl.deploy();

        const {createTodo, getAllTodos, getTodoById, getAllNumberTodos, updateTodoTitleById, isDone, deleteTodoById, updateTodoDescriptionById } = await ethers.getContractAt("ITodo", todoImpl);
        return {createTodo, getAllTodos, getTodoById, getAllNumberTodos, updateTodoTitleById, isDone, deleteTodoById, updateTodoDescriptionById};
    }
    describe("test create Todo", function(){
        it("when i create one todo i should get 1 when i try to get the number of the Todos", async function(){
            const{createTodo, getAllNumberTodos} = await loadFixture(deployTodo);
            await createTodo("Jump", "i am jumping");
            const result = await getAllNumberTodos();
            expect(result).is.equal(1);
        }),

        it("when i create more than one Todo i get my result to be more than 1", async function(){
            const{createTodo, getAllNumberTodos} = await loadFixture(deployTodo);
            await createTodo("Jump", "i am jumping");
            await createTodo("Run", "i am running");
            const result = await getAllNumberTodos();
            expect(result).is.equal(2);
        }),

        it("assert that when creating a todo, no duplicate title is allowed", async function(){
            const {createTodo, getAllNumberTodos} = await loadFixture(deployTodo);
            await createTodo("Jump", "i am jumping");
            try{
            await createTodo("Jump", "I am humming");
            }catch(error){
                expect(error.message).to.include("a title with this title already exist...");
            }
            const result = await getAllNumberTodos();
            expect(result).is.equal(1);
        })
    }),
    describe("get Todo by Id", function(){
        it("when i create the Todo and i pass the id, i should get a response not null", async function(){
            const {createTodo, getTodoById} = await loadFixture(deployTodo);
            await createTodo("String", "Stringing");
            const result = await getTodoById(1);
            assert.equal(result.title, "String");
        })
        it("when i create the Todo and i pass the id, i should get a response not null", async function(){
            const {createTodo, getTodoById} = await loadFixture(deployTodo);
            await createTodo("String", "Stringing");
            await createTodo("Jump", "Jumping");
            const result = await getTodoById(2);
            assert.equal(result.description, "Jumping");
        })
    }),
    describe("Update Todo by id", function(){
        it("update title by id", async function (){
            const {createTodo, getTodoById, updateTodoTitleById} = await loadFixture(deployTodo);
            await createTodo("Sleep", "I want to take a nap");
            await updateTodoTitleById("Nap", 1);
            const result = await getTodoById(1);

            assert.equal(result.title, "Nap");
        })
        it("update description by id", async function (){
            const {createTodo, getTodoById, updateTodoDescriptionById} = await loadFixture(deployTodo);
            await createTodo("Sleep", "I want to take a nap");
            await updateTodoDescriptionById("fast asleep", 1);
            const result = await getTodoById(1);

            assert.equal(result.description, "fast asleep");
        })
    })
})