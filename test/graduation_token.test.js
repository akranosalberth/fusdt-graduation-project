const GraduationToken = artifacts.require("GraduationToken");

contract("GraduationToken", (accounts) => {
  let token;

  before(async () => {
    token = await GraduationToken.deployed();
  });

  it("uses 6 decimals and creates exactly 250,000 tokens", async () => {
    const decimals = await token.decimals();
    const totalSupply = await token.totalSupply();
    const ownerBalance = await token.balanceOf(accounts[0]);

    assert.equal(decimals.toString(), "6");
    assert.equal(totalSupply.toString(), "250000000000");
    assert.equal(ownerBalance.toString(), "250000000000");
  });

  it("transfers 1.5 tokens using six-decimal base units", async () => {
    await token.transfer(accounts[1], "1500000", { from: accounts[0] });
    const recipientBalance = await token.balanceOf(accounts[1]);

    assert.equal(recipientBalance.toString(), "1500000");
  });
});

