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
    Queue public buyers;
    Token token;
    //amount of tokens 1 wei is worth
    uint256 exchangeRate;
    uint256 totalSold;

    uint public startTime;
    uint public saleEnd;

    function Crowdsale(uint256 _totalSupply, uint256 _exchangeRate, uint _saleTime) public {
        owner = msg.sender;
        token = new Token(_totalSupply);
        buyers = new Queue(now, 1000);
        exchangeRate = _exchangeRate;
        startTime = now;
        saleEnd = now + _saleTime;
    }

    function getInLine(); 

    /* 	Consider implementing this modifier
		and applying it to the reduceBid function
		you fill in below. */
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    //Forwards all funds to owner after sale is over
    function forwardFunds() isOwner returns(bool) {
        if (now > saleEnd) {
            owner.transfer(this.balance);
            return true;
        }
        return false;
    }

    //Mints new tokens
    function mint() isOwner private {
        token.changeSupply(1, true);
    }

    //burns tokens not sold
    function burn() isOwner private {
        uint256 unsold = token.totalSupply() - totalSold;
        token.changeSupply(unsold, false);
    }

    modifier saleOpen {if (now < saleEnd) _;}

    modifier inStock {if (token.totalSupply() > totalSold) _;}

    //buy tokens directly from the contract and as long as the sale has not ended,
    //if they are first in the queue and there is someone waiting line behind them
    //returns true if successful, false if not
    function buy() payable external saleOpen inStock returns(bool) {
        if (msg.sender == buyers.getFirst() && buyers.qsize() > 1) {
            buyers.dequeue();
            token.transfer(msg.sender, msg.value * exchangeRate);
            totalSold += msg.value * exchangeRate;
            return true;
        }
        return false;
    }

    function refund() payable external saleOpen {
        require(token.balanceOf(msg.sender) >= msg.value);
        uint256 refundAmount = token.balanceOf(msg.sender);
        msg.sender.transfer(refundAmount / exchangeRate);
        token.refund(msg.sender, refundAmount);
        totalSold -= refundAmount;
    }

    function () payable {
        revert();
    }
}
