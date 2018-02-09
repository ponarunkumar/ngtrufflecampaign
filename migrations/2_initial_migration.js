var Campaign = artifacts.require("./Campaign.sol");

module.exports = function(deployer) {
  deployer.deploy(Campaign, 10000, web3.toWei(1));
};
