var Story = artifacts.require("./Story.sol");

module.exports = function(deployer) {
  deployer.deploy(Story);
};
