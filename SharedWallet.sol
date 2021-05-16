pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SharedWallet is Ownable {
    
    function withdrowMoney(address payable _to , uint amount) public onlyOwner{
        _to.transfer(amount);
        
    }
    
    receive() external payable {
        
    }
    
}
