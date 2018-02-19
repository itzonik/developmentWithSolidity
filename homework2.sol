pragma solidity ^0.4.18;

contract ServiceContract{
    address owner;
    uint servicePrice;
    uint withdrawLimit;
    uint timeOfServiceBought;
    uint hourofWithdraw;
    
     modifier onlyOwner {
         require( owner == msg.sender);
          _;    }
    
    modifier canBuyService {
         require( now - timeOfServiceBought > 2 minutes);
          _;    }
    
    modifier canWithdraw {
         require( now/1 hours > hourofWithdraw);
          _;    }
    
    event ServiceBought (uint  time, address indexed _addressSent);
    
    event AmountWithdrawn (uint indexed amount);
    
    function ServiceContract() public { 
        owner               = msg.sender;
        servicePrice        = 1 ether;
        withdrawLimit       = 5 ether;
        hourofWithdraw      = 0;
        timeOfServiceBought = 0;    }
        
    function buyService () public payable canBuyService {
        uint balance = this.balance;
        uint amount = msg.value;
        if(amount >= servicePrice) {
            // return to payable
            ServiceBought(now,msg.sender);
            timeOfServiceBought = now;
            msg.sender.transfer(amount - servicePrice);
            assert(balance + (servicePrice - amount) == this.balance);       } 
		else {
            //nothing to return
            msg.sender.transfer(amount);
            assert(balance - amount == this.balance);        }    }
    
    function withdrawFunds (uint withdrawAmount) public onlyOwner canWithdraw {
        uint balance = this.balance;
        uint amountWei = withdrawAmount*1 wei;
        require(amountWei <= withdrawLimit);
        owner.transfer(amountWei);
        assert(balance - amountWei == this.balance);
        hourofWithdraw = now/1 hours;
        AmountWithdrawn(amountWei);    }
    
    function () public payable{    }
    
}
