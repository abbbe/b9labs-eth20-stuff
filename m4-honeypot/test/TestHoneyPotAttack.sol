pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "../contracts/HoneyPotAttack.sol";

contract TestHoneyPotAttack {
  uint constant HP_INITIAL_BALANCE = 50 ether;
  uint constant HPA_INITIAL_BALANCE = 0.5 ether;
  uint public initialBalance = HP_INITIAL_BALANCE + HPA_INITIAL_BALANCE;

  HoneyPot hp;
  HoneyPotAttack hpa;

  function testBefore() public { // how to properly simulate chai's before() function?
    hp = (new HoneyPot).value(HP_INITIAL_BALANCE)();
    hpa = (new HoneyPotAttack).value(HPA_INITIAL_BALANCE)(hp);
  }

  function testInitialBalances() public {
    Assert.equal(hp.balance, HP_INITIAL_BALANCE, "wrong HoneyPot balance");
    Assert.equal(hpa.balance, HPA_INITIAL_BALANCE, "wrong HoneyPotAttack balance");
  }

  function testHoneyPotAttack() public {
    hpa.attack();
    Assert.equal(hp.balance, 0, "HoneyPot was not emptied by attack()");
    Assert.equal(hpa.balance, HPA_INITIAL_BALANCE + HP_INITIAL_BALANCE, "wrong HoneyPotAttack balance");
  }
}
