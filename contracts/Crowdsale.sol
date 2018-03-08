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
    uint256 exchangeRate;
    uint256 totalSold;

    uint public startTime;
    uint public saleEnd;

    function Crowdsale(uint256 _totalSupply, uint256 _exchangeRate, uint _saleTime) public {
        owner = msg.sender;
        newToken = new Token(_totalSupply);
        exchangeRate = _exchangeRate;
        this.balance = _totalSupply * _exchangeRate;
        startTime = now;
        saleEnd = now + _saleTime;
    }


    //Forwards all funds to owner after sale is over
    function forwardFunds() private payable returns(bool) {
        if (now > saleEnd) {
            owner.transfer(this.balance);
            return true;
        }
        return false;
    }

    //Mints new tokens
    function mint() private {
        newToken.changeSupply(1, true);
    }

    //burns tokens not sold
    function burn() private {
        uint256 unsold = newToken.totalSupply() - totalSold;
        newToken.changeSupply(unsold, false);
    }

    modifier saleOpen {if (now < saleEnd) _;}

    modifier inStock {if (newToken.totalSupply > totalSold) _;}

    //buy tokens directly from the contract and as long as the sale has not ended,
    //if they are first in the queue and there is someone waiting line behind them
    //returns true if successful, false if not
    function buy() payable external saleOpen inStock returns(bool) {
        if (msg.sender == buyers.getFirst() && buyers.qsize() > 1) {
            newToken.transfer(msg.sender, msg.value * exchangeRate);
            totalSold += msg.value * exchangeRate;
            return true;
        }
        return false;
    }

    function refund() payable external saleOpen {
        require(newToken.balanceOf(msg.sender) >= msg.value);
        msg.sender.send(msg.value);
        newToken.approve(this, msg.sender, msg.value * exchangeRate);
        newToken.transferFrom(this, msg.sender, msg.value * exchangeRate);
        totalSold -= msg.value * exchangeRate;
    }

    function () payable {}
}
