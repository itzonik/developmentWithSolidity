pragma solidity ^0.4.19;

contract Service {
    address owner;
    uint    lastBuy=0;
    uint    lastWithdraw=0;
    
    //payable
    function() public payable {
            }
    event confirmedPurchase (uint timestamp, uint change);
    
    // owner check
    modifier onlyOwner {
        require(msg.sender == owner);
        _;    }
    
    // Min amount for buy the service
    modifier min1ETH {
        require(this.balance >= 1 ether);
        _;    }
        
    // Minutes should between Withdraws
    modifier minMinsBetweenEvents(uint lastEvent, uint passedMinutess) {
        require(now - lastEvent > passedMinutess*60);
        _;    }
    
    // Constructor - set owner
    function Service() public {
        owner = msg.sender; }

    // buy Service for 1 ETH and return rest of money
    function buyService() public payable min1ETH minMinsBetweenEvents(lastBuy, 2) returns (uint bal) {
        if (msg.value>1 ether)  {
            bal = msg.value - 1 ether;
            msg.sender.transfer(bal);
            confirmedPurchase (now, bal); }
        else 
            confirmedPurchase (now, 0);    }
    
    // Every withdraw from owner once per hour and max 5 ETH 
    function withdrawToOwner() public onlyOwner minMinsBetweenEvents(lastWithdraw, 60) {
        owner.transfer(this.balance % 5);    }
    
    // see balance
    function getBalance() public view returns (uint) {
        return this.balance;    }   
            
}
