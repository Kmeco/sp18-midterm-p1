pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
    address owner;
    Queue buyers;

    Token token;
    //amount of tokens 1 wei is worth
    uint exchangeRate;
    uint totalSold;

    uint public startTime;
    uint public saleEnd;

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        owner = msg.sender;
        token = new Token(_totalSupply);
        startTime = now;
        saleEnd = now + _saleTime;
    }


    //Forwards all funds to owner after sale is over
    function forwardFunds() private {
    }

    //Mints new tokens
    function mint() private {

    }

    //burns tokens not sold
    function burn() private {
    }

    modifier saleOpen {if (now < saleEnd) _;}

    //buy tokens directly from the contract and as long as the sale has not ended,
    //if they are first in the queue and there is someone waiting line behind them
    //returns true if successful, false if not
    function buy() payable external saleOpen returns(bool) {
        if (msg.sender == buyers.getFirst() && buyers.qsize() > 1) {
            token.transfer(msg.sender, msg.value * exchangeRate);
        }
        return false;
    }

    function refund() payable external saleOpen {

    }

    function () payable {}
}
