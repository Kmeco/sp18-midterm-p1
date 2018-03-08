'use strict';

/* Add the dependencies you're testing */
const Crowdsale = artifacts.require("./Crowdsale.sol");
const Queue = artifacts.require("./Queue.sol");
const Token = artifacts.require("./Token.sol");
// YOUR CODE HERE

contract('testICO', function(accounts) {
	/* Define your constant variables and instantiate constantly changing 
	 * ones
	 */
	const args = {_duration : 10000, _timeLimit : 1000, _totalSupply : 1000000};
	const users = {one : 0x4d4c12682a3c5cf1ba6b9ca580b5934c49124f6a, two : 0x9967389621360ed69358b3e77c28beaa0e1a815f};
	let myToken, crowdsale, queue;
	// YOUR CODE HERE

	/* Do something before every `describe` method */
	beforeEach(async function() {
		// YOUR CODE HERE
        crowdsale = await Crowdsale.new(args._totalSupply, args._duration);
        queue = await Queue.new(now, args._timeLimit)
	});

	/* Group test cases together 
	 * Make sure to provide descriptive strings for method arguements and
	 * assert statements
	 */
	describe('--Queue works--', function() {
		it("Returns the correct number of people waiting in line after" +
			"enqueue", async function() {
			assert.equal(queue.empty(), true, "empty function works")
			queue.enqueue(users.one);
            assert.equal(queue.qsize(), 1, "enqueue and qsize work");
            queue.enqueue(users.two);
            assert.equal(queue.)
		});
		// YOUR CODE HERE
	});

	describe('Your string here', function() {
		// YOUR CODE HERE
	});
});
