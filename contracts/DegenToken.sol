// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    mapping (uint256 => uint256) rewards;
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender){
        rewards[1] = 250;
        rewards[2] = 200;
        rewards[3] = 150;
        rewards[4] = 100;
        rewards[5] = 50;
    }

        function Mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }

        function TransferTokens(address receipient, uint amount) public   {
            require(balanceOf(msg.sender) >= amount, "You dont have enough tokens to transfer");
            approve(msg.sender, amount);
            transferFrom(msg.sender, receipient, amount);
        }

        function showRewardShop() public pure returns (string memory){
            string memory list = "1. DGN NFT (250 Tokens) 2. Game item of your choice (200 Tokens), 3.  DGN Statue (150 Tokens), 4. DGN T-shirt (100 Tokens), DGN Mug (50 Tokens) ";
            return list;
        }

        function RedeemRewards(uint reward_num)public {
            require(reward_num > 0 && reward_num <=5, "Invalid choice");
            require(balanceOf(msg.sender) >= rewards[reward_num], "Not enough tokens for this reward");
            transfer(owner(), rewards[reward_num]);
        }
        
        function BurnTokens(uint amount) public {
            require(balanceOf(msg.sender) >= amount, "Amount provided is higher than balance you have in your account");
            _burn(msg.sender, amount);
        }

        function Balance() public view returns(uint256){
            return balanceOf(msg.sender);
        }
}
