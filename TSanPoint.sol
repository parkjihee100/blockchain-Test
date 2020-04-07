pragma solidity >=0.4.22 <0.7.0;

contract Point {

    /// @return total amount of tokens
    function totalSupply() constant returns (uint256 supply) {}

    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(string user) constant returns (uint256 balance) {}

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(string _from, string _to, uint256 _value) returns (bool success) {}

  
    /// @notice `msg.sender` approves `_addr` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of wei to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(string _spender, uint256 _value) returns (bool success) {}

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(string _owner, string  _spender) constant returns (uint256 remaining) {}

    event Transfer(string indexed _from, string indexed _to, uint256 _value);
    event Approval(string indexed _owner, string indexed _spender, uint256 _value);

}

contract StandardPoint is Point {

    function transfer(string _from, string _to, uint256 _value) returns (bool success) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
        //Replace the if with this one instead.
        //if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
        if (balances[_from] >= _value && _value > 0) {
            balances[_from] -= _value;
            balances[_to] += _value;
            Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }


    function balanceOf(string user) constant returns (uint256 balance) {
        return balances[user];
    }

    function approve(string _spender, uint256 _value) returns (bool success) {
        allowed["owner"][_spender] = _value;
        Approval("owner", _spender, _value);
        return true;
    }

    function allowance(string _owner, string _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (string => uint256) balances;
    mapping (string => mapping (string => uint256)) allowed;
    uint256 public totalSupply;
}

contract TSANPoint is StandardPoint { // CHANGE THIS. Update the contract name.

    string public name;                   // Point Name
    uint8 public decimals;                // How many decimals to show. To be standard complicant keep it 18
    string public symbol;                 // An identifier: eg SBX, XPR etc..
    string public version = 'T1.0'; 
    string public fundsUser;           // Where should the raised ETH go?

    // uint256 public unitsOneEthCanBuy;     // How many units of your coin can be bought by 1 ETH?
    // uint256 public totalEthInWei;         // WEI is the smallest unit of ETH (the equivalent of cent in USD or satoshi in BTC). We'll store the total ETH raised via our ICO here.  
    
    // This is a constructor function 
    // which means the following function name has to match the contract name declared above
    constructor() {
        balances["owner"] = 1000000000000000000000;               // Give the creator all initial tokens. This is set to 1000 for example. If you want your initial tokens to be X and your decimal is 5, set this value to X * 100000. (CHANGE THIS)
        totalSupply = 1000000000000000000000;                        // Update total supply (1000 for example) (CHANGE THIS)
        name = "TSanPoint";                                   // Set the name for display purposes (CHANGE THIS)
        decimals = 18;                                               // Amount of decimals for display purposes (CHANGE THIS)
        symbol = "TP";                 
        fundsUser = "owner";                                    // The owner of the contract gets ETH
    }

   
}