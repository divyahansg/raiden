/*
This implements ONLY the standard functions and NOTHING else.
For a token like you would want to deploy in something like Mist, see HumanStandardToken.sol.

If you deploy this, you won't have anything useful.

Implements ERC 20 Token standard: https://github.com/ethereum/EIPs/issues/20
.*/
pragma solidity ^0.4.19;

interface Token{
  function totalSupply() public constant returns (uint256 supply);
  function balanceOf(address _owner) public constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
  function approve(address _spender, uint256 _value) public returns (bool success);
  function allowance(address _owner, address _spender) public constant returns (uint256 remaining);
}

contract StandardToken is Token{
  string public name = "TOK";
  string public symbol = "TKN";
  uint8 public decimals = 18;

  function StandardToken() public{
    balances[0x8c0Ef1Cf87ffb7A964a47bFCad9f00f6E84A8FE5] = 10001000000000000000000;
    balances[0x004ec07d2329997267ec62b4166639513386f32e] = 10002000000000000000000;
    _total_supply = 10001 + 10002;
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  uint256 internal _total_supply;
  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;

  function transfer(address _to, uint256 _value) public returns (bool success) {
      //Default assumes totalSupply can't be over max (2^256 - 1).
      //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
      //Replace the if with this one instead.
      //if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
      if (balances[msg.sender] >= _value && _value > 0) {
          balances[msg.sender] -= _value;
          balances[_to] += _value;
          Transfer(msg.sender, _to, _value);
          return true;
      } else { return false; }
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
      //same as above. Replace this line with the following if you want to protect against wrapping uints.
      //if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
      if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
          balances[_to] += _value;
          balances[_from] -= _value;
          allowed[_from][msg.sender] -= _value;
          Transfer(_from, _to, _value);
          return true;
      } else { return false; }
  }

  function balanceOf(address _owner) public constant returns (uint256 balance) {
      return balances[_owner];
  }

  function approve(address _spender, uint256 _value) public returns (bool success) {
      allowed[msg.sender][_spender] = _value;
      Approval(msg.sender, _spender, _value);
      return true;
  }

  function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  function totalSupply() public constant returns (uint256 supply) {
      return _total_supply;
  }
}
