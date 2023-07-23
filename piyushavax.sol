// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
   
    function allowance(address owner, address spender) external view returns (uint256);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract DegenGamingToken is IERC20 {
    string private constant _name = "Degen";
    string private constant _symbol = "DGN";
    uint8 private constant _decimals = 18;
    uint256 private _totalSupply;
    address private _owner;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can call this function.");
        _;
    }

    constructor(uint256 initialSupply) {
        _owner = msg.sender;
        _totalSupply = initialSupply * 10**_decimals;
        _balances[_owner] = _totalSupply;
        emit Transfer(address(0), _owner, _totalSupply);
    }

    function name() external pure returns (string memory) {
        return _name;
    }

    function symbol() external pure returns (string memory) {
        return _symbol;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function burn(uint256 amount) external returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }

    function mint(address recipient, uint256 amount) external onlyOwner returns (bool) {
        _mint(recipient, amount);
        return true;
    }

    function redeem(uint256 amount, uint256 prizeSelection) external returns (bool) {
        require(_balances[msg.sender] >= amount, "not much balance");
        _burn(msg.sender, amount);
        string memory item = getItemFromPrizeSelection(prizeSelection);
        emit RedemptionSuccessful(msg.sender, amount, item);

        return true;
    }

    function getItemFromPrizeSelection(uint256 prizeSelection) private pure returns (string memory) {
        if (prizeSelection == 1) {
            return "Sword";
        } else if (prizeSelection == 2) {
            return "Magic";
        } else {
            return "Unknown Item";
        }
    }
    event RedemptionSuccessful(address indexed player, uint256 amount, string item);

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Transfer from zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[sender] >= amount, "Very less balance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "Approve from zero address");
        require(spender != address(0), "Approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "Burn from the zero address there");
        require(_balances[account] >= amount, "Very less balance to burn");

        _balances[account] -= amount;
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "Mint to the zero address there");
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }
} 
