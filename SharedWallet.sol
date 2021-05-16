pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract Allowance is Ownable {
    
    using SafeMath for uint;
    
    event AllowanceChanged(address indexed _who , address indexed _fromWhom , uint _oldamount , uint _newamount);
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _address , uint amount) public onlyOwner{
        emit AllowanceChanged(_address , msg.sender , allowance[_address] , amount);
        allowance[_address] = amount;
    }
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    modifier ownerOrAllowed(uint amount) {
        require(isOwner() || allowance[msg.sender] >= amount , "you are not allowed");
        _;
    }
    
    function reduceAllowance(address _address , uint amount ) internal ownerOrAllowed(amount){
        emit AllowanceChanged(_address , msg.sender , allowance[_address] ,  allowance[_address].sub(amount));
        allowance[_address] = allowance[_address].sub(amount);
    }
    
}


contract SharedWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    
    function withdrowMoney(address payable _to , uint amount) public ownerOrAllowed(amount){
        require(amount <= address(this).balance ,  "Contract doesn't own enough money");
        if(!isOwner()){
            reduceAllowance(_to , amount);
        }
        emit MoneySent(_to , amount);
        _to.transfer(amount);
        
    }
    
    receive() external payable {
        emit MoneyReceived(msg.sender , msg.value);
    }
    
}
