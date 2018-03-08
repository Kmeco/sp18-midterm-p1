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

    Token newToken;
    //amount of tokens 1 wei is worth
    uint exchangeRate;
    uint totalSold;

    uint public startTime;
    uint public saleEnd;

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        owner = msg.sender;
        newToken = new Token(_totalSupply);
        startTime = now;
        saleEnd = now + _saleTime;
    }


    //Forwards all funds to owner after sale is over
    function forwardFunds() private payable {
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
    function buy() external payable saleOpen {

    }

    function refund() external payable saleOpen {

    }

    function () payable {}
}
