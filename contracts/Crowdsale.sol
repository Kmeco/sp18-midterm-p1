pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
	// YOUR CODE HERE
    uint public saleStart;
    uint public saleEnd;
    Token newToken;
    address owner;
    uint totalSold;
    unit totalSupply;

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        newToken = new Token(_totalSupply);
        owner = msg.sender;
        totalSold = 0;
        saleEnd = now + _saleTime;
    }


    //Forwards all funds to owner after sale is over
    function forwardFunds() {

    }

    //Mints new tokens
    function mint() {

    }

    //burns tokens not sold
    function burn() {

    }

}
