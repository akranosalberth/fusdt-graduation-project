// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

/**
 * @title GraduationToken
 * @notice Fixed-supply TRC-20 token prepared for an academic project.
 *         The complete supply is assigned to the deploying wallet once.
 *         There is no owner, tax, blacklist, pause, or additional mint function.
 */
contract GraduationToken {
    string public constant name = "fUSDT";
    string public constant symbol = "fUSDT";
    uint8 public constant decimals = 6;

    uint256 public constant totalSupply = 250_000 * 10 ** uint256(decimals);

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(spender != address(0), "TRC20: approve to zero address");
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        uint256 currentAllowance = allowances[sender][msg.sender];
        require(currentAllowance >= amount, "TRC20: insufficient allowance");

        unchecked {
            allowances[sender][msg.sender] = currentAllowance - amount;
        }
        emit Approval(sender, msg.sender, allowances[sender][msg.sender]);

        _transfer(sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private {
        require(sender != address(0), "TRC20: transfer from zero address");
        require(recipient != address(0), "TRC20: transfer to zero address");

        uint256 senderBalance = balances[sender];
        require(senderBalance >= amount, "TRC20: amount exceeds balance");

        unchecked {
            balances[sender] = senderBalance - amount;
        }
        balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);
    }
}
