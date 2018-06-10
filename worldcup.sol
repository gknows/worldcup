pragma solidity ^0.4.18;
/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }
  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    require(msg.sender == owner);
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

  /**
  * 
  */
contract team {

      struct Team {
      uint id;
      bool isKnockout;
      bool isChampion;
      uint supports;
  }
  Team[] public teams;
  function team() public{
      for (var i = 0; i <= 32; i++) {
        teams.push(Team({
          id:i,
          isKnockout:0,
          isChampion:0,
          supports:0
        }));
      }
  }
}



contract WorldCup is Ownable{
  using SafeMath for uint256;
  uint256 public count_of_fans;
  uint256 public value_tick;
  uint256 public balance;
  struct Fan{
    uint256 fan_id;
    uint256 inited;

  }
  struct Fan_detail{
    uint256 support_team_id;
    uint256 ticks;
  }
  mapping(address => Fan) public fan;
  mapping(uint256 => Fan_detail) public fan_detail;

  function WorldCup() public{
    count_of_fans = 0;
    balance = 0;
    value_tick = 100000000000000;
  }
  function init_fan() public{
    require(fan[msg.sender],inited == 0);
    fan[msg.sender].fan_id = count_of_fans;
    fan_detail[fan[msg.sender].fan_id].support_team_id = 0;
    fan_detail[fan[msg.sender].fan_id].ticks = 0;
    fan[msg.sender].inited = 1;
  }

  function support_team(uint256 support_team) public{
    uint256 _value;
    require(msg.value >= value_tick);
    require(fan[msg.sender].inited == 1)
    fan_detail[fan[msg.sender].fan_id].support_team_id = support_team;
    transfer(msg.sender, owner, msg.value);
    balance = balance + msg.value;
    _value = msg.value;
    fan_detail[fan[msg.sender].fan_id].ticks = _value.div(value_tick);
  }

  function ref_result() {
    require(msg.sender == owner)
  }
  function get_reward(){
    
  }



}


