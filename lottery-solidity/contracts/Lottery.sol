pragma solidity ^0.4.19;

contract Lottery {
  address public manager;
  address[] public players;
  
  constructor() public {
    manager = msg.sender;
  }
  
  // function Lottery() public {
  //     manager = msg.sender;
  // }
  
  function enter() public payable {
    require(msg.value > .01 ether);
      
    players.push(msg.sender);
  }
  
  function random() private view returns (uint) {
    return uint(keccak256(block.difficulty, now, players));
  }
  
  function pickWinner() public restricted {
    uint index = random() % players.length;
    players[index].transfer(address(this).balance); // 0x1232bcd31
    players = new address[](0); // reset array to length zero
  }
  
  modifier restricted() {
    require(msg.sender == manager);
    _;
  }
  
  function getPlayers() public view returns (address[]) {
    return players;
  }

}