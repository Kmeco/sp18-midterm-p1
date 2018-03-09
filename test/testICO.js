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
	const args = {_duration : 10000, _timeLimit : 1000, _totalSupply : 1000000, _exchangeRate : 2};
	const users = { one : "0x9b520632fbdc4a12d0c9687dea417cf5b820e8ca",
                    two : "0x2cd312b9cf1f62efbced9a0394b0d9c8b218cb22"};
	let myToken, crowdsale, queue;
	// YOUR CODE HERE

	/* Do something before every `describe` method */
	beforeEach(async function() {
		// YOUR CODE HERE/
        crowdsale = await Crowdsale.new(args._totalSupply,
										args._exchangeRate, args._duration);
        queue = await Queue.new(args._timeLimit, args._timeLimit);
	});

	/* Group test cases together 
	 * Make sure to provide descriptive strings for method arguements and
	 * assert statements
	 */
	describe('--Queue works--', function() {
		it("Returns the correct number of people waiting in line after" +
			"enqueue", async function() {
			assert.equal(await queue.empty(), true, "empty function works");
			await queue.enqueue(users.one);
            await queue.enqueue(users.two);
            assert.equal(await queue.qsize().valueOf(), 2, "enqueue and" +
			" qsize work");
            assert.equal(await queue.getFirst(), users.one, ".getFirst works" +
				" correctly");
            await queue.dequeue();
            assert.equal(await queue.getFirst(), users.two, ".dequeue works");
		});
	});

	describe('--Crowdsale works--', function() {
		// YOUR CODE HERE
		it("allows the first person in the queue to buy Tokens", async function() {
            await crowdsale.buyers.enqueue(users.one);
            await crowdsale.buyers.enqueue(users.two);
            await crowdsale.buy.call({from : users.one, value : 2});
            //assert.equal(await crowdsale.token.balanceOf(user.one), 4,
            // "Token balance is updated correctly.");
		});
	});
});
