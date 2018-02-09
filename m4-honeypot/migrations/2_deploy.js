var Migrations = artifacts.require("./Migrations.sol");
var HoneyPot = artifacts.require("./HoneyPot.sol");
var HoneyPotAttack = artifacts.require("./HoneyPotAttack.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(HoneyPot).then(() =>
    deployer.deploy(HoneyPotAttack,  HoneyPot.address)
  );
};
