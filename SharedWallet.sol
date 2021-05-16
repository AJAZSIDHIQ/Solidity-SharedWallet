pragma solidity ^0.8.1;


contract SharedWallet {
    
    function withdrowMoney(address payable _to , uint amount) public {
        _to.transfer(amount);
        
    }
    
    receive() external payable {
        
    }
    
    
}
