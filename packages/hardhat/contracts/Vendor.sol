pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    YourToken public yourToken;

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

    // ToDo: create a payable buyTokens() function:
    uint256 public constant tokensPerEth = 100;
    
    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
    function buyTokens() public payable {
        yourToken.transfer(msg.sender, msg.value * tokensPerEth);
        emit BuyTokens(msg.sender, msg.value, msg.value * tokensPerEth);
    }

    // ToDo: create a withdraw() function that lets the owner withdraw ETH
    function withdraw() public {
        require(msg.sender == owner(), "Can't Withdraw, You are not owner!");
        address payable to = payable(msg.sender);
        to.transfer(address(this).balance);
    }

    // ToDo: create a sellTokens(uint256 _amount) function:
    event SellTokens(address buyer, uint256 amountOfTokens, uint256 amountOfETH);
    function sellTokens(uint256 _amount) public {
        yourToken.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(_amount/100);
        emit SellTokens(msg.sender, _amount, _amount/100);

    }
}
