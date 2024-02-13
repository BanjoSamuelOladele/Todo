import { ethers } from "hardhat";
import {assert, expect} from "chai";
import {loadFixture} from "@nomicfoundation/hardhat-toolbox/network-helpers";

describe("Test Todo", function(){
    async function deployTodo(){
        const TodoImpl = await ethers.getContractFactory("TodoImpl");
        const todoImpl = await TodoImpl.deploy();

        const todo = await ethers.getContractAt("ITodo", todoImpl);
        return {todo};
    }

    describe("test deployed", function(){
        it("", async function(){
            const{todo} = await loadFixture(deployTodo);
            assert.isNotNull(todo);
        })
    })

    
});