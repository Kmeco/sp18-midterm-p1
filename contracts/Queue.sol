pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
    address[] line;
	address[] newLine;
    uint256 numWaiting;
    uint startTime;
    uint timeLimit;

	/* Add events */
	// YOUR CODE HERE


    function Queue(uint _startTime, uint _timeLimit) {
        numWaiting = 0;
        startTime = _startTime;
        timeLimit = _timeLimit;
    }

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint256) {
		return numWaiting;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
	  return numWaiting == 0;
	}

	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
	  return line[0];
	}

	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint8) {
		for (uint8 i = 0; i < numWaiting; i++) {
		    if (msg.sender == line[i]) {
		        return i + 1;
		    }
		}
	}

	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
        if (now > startTime + timeLimit) {
            dequeue();
        }
	}

	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
        for (uint8 i = 1; i < numWaiting; i++) {
            newLine.push(line[i]);
        }
        line = newLine;
		startTime = now;
        numWaiting--;
	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
        if (numWaiting < size) {
		    numWaiting = line.push(addr);
		}
	}

    function () {}
}
