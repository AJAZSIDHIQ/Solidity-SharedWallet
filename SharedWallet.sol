pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SharedWallet is Ownable {
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _address , uint amount) public onlyOwner{
        allowance[_address] = amount;
    }
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    modifier ownerOrAllowed(uint amount) {
        require(isOwner() || allowance[msg.sender] >= amount , "you are not allowed");
        _;
    }
    
    function withdrowMoney(address payable _to , uint amount) public ownerOrAllowed(amount){
        _to.transfer(amount);
        
    }
    
    receive() external payable {
        
    }
    
}
