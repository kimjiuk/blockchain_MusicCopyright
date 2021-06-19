//토큰 계약 작성
pragma solidity ^0.4.24;
import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
struct Song{
    bytes32 title;
    bytes32 name;
    bytes32 Id;
}

contract DNextToken is StandardToken {

    uint public INITIAL_SUPPLY = 21000000;
    string public name = 'DNextToken';
    string public symbol = 'DNX';
    uint8 public decimals = 8;
    address owner;
    bool public released = false;

    function DNextToken() public {
        totalSupply_ = INITIAL_SUPPLY * 10 ** uint(decimals);
        balances[msg.sender] = INITIAL_SUPPLY;
        owner = msg.sender;
    }

    function release() public {
        require(owner == msg.sender);
        require(!released);
        released = true;
    }

    modifier onlyReleased() {
        require(released);
        _;
    }

    function transfer(address to, uint256 value) public onlyReleased returns (bool) {
        super.transfer(to, value);
    }

    function allowance(address owner, address spender) public onlyReleased view returns (uint256) {
        super.allowance(owner, spender);
    }

    function transferFrom(address from, address to, uint256 value) public onlyReleased returns (bool) {
        super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value) public onlyReleased returns (bool) {
        super.approve(spender, value);
    }
}