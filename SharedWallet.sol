//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;


import "./Allowance.sol";


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
    
    function  renounceOwnership() public override onlyOwner {
        revert("cant do this operation");
    }
    
    receive() external payable {
        emit MoneyReceived(msg.sender , msg.value);
    }
    
}
