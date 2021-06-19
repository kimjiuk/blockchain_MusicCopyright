const DNextToken = artifacts.require("./DNextToken");
const DNextTokenSale = artifacts.require("./DNextTokenSale");
const DNextTokenWhitelist = artifacts.require("./DNextTokenWhitelist");

module.exports = function(deployer) {
  deployer.deploy(DNextToken).then(function () {
    deployer.deploy(DNextTokenWhitelist).then(function(){
      deployer.deploy(DNextTokenSale, DNextToken.address, DNextTokenWhitelist.address);
    });
  });
};
