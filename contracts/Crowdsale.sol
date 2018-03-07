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
    uint public saleEnd;
    uint public saleStart;
    Token newToken;
    address owner;
    uint totalSold;

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        newToken = new Token(_totalSupply);
        owner = msg.sender;
        totalSold = 0;
        saleEnd = now + _saleTime;
    }


}
