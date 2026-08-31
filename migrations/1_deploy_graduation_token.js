const GraduationToken = artifacts.require("GraduationToken");

module.exports = function (deployer) {
  deployer.deploy(GraduationToken);
};

