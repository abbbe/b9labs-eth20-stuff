pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HoneyPot.sol";
// import "../contracts/HoneyPotAttack.sol";

contract TestHoneyPotAttack {
  uint public initialBalance = 51 ether;
  HoneyPot hp = HoneyPot(DeployedAddresses.HoneyPotAttack());
  // HoneyPotAttack hpa;

  function testHoneyPot_CreateAndPut() public {
    hp.put.value(50 ether)();
    Assert.equal(hp.balance, 50 ether, "wrong HoneyPot balance");
  }

  // HoneyPotAttack hpa = HoneyPotAttack(hp);
}

