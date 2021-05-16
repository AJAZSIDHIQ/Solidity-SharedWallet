pragma solidity ^0.8.1;


contract SharedWallet {
    
    address owner ;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner , "you are not thw owner");
        _;
    }
    
    function withdrowMoney(address payable _to , uint amount) public onlyOwner{
        _to.transfer(amount);
        
    }
    
    receive() external payable {
        
    }
    
    
}
