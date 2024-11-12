// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract owners{
address public owner;
string public token_name;
string public ticker;
bool public paused;
mapping(address=>uint)public balance;
    constructor(){
owner=msg.sender;
token_name="Btc highs";
ticker="BTH";
paused=false;
balance[owner]=1000;
    }



 modifier checkOwner(){

    require(msg.sender==owner,"you are not the owner");
    _;
    
 }
modifier pause(){
    require(paused==false,"contract is paused");
    _;
}

function pauseContract() public checkOwner{
    paused=true;
}

function unpauseContract() public checkOwner{
    paused=false;
}



 function newOwner(address addy)public checkOwner {
    
owner=addy;

 }

 function transaction(address from,address to,uint amountvalue) public pause{
    require(balance[from] >= amountvalue, "Insufficient balance"); // Check if sender has enough balance
        require(to != address(0), "Cannot transfer to the zero address");
balance[from]-=amountvalue;
balance[to]+=amountvalue;

 }

function gettingBalance(address user) public view returns (uint) {
        return balance[user];
    }

 


}