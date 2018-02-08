pragma solidity ^0.4.6;

contract Campaign {
    
    address public owner;
    uint public deadline;
    uint public goal;
    uint public fundsRaised;
    
    struct FunderStruct {
        address funder;
        uint amount;
    }
    
    FunderStruct[] public funderStructs;
    
    event LogContribute(address sender, uint amount);
    event LogRefundSent(address funder, uint amount);
    event LogWithdrawal(address beneficiary, uint amount);
    
    function Campaign (uint campaignDuration, uint campaignGoal){
        owner = msg.sender;
        deadline = block.number + campaignDuration;
        goal = campaignGoal;
    }
    
    function isSuccess()
        public
        constant 
        returns (bool isIndeed)
        {
            return (fundsRaised >= goal);
        }
    
    function hasFailed()
        public
        constant
        returns (bool hasIndeed)
        {
            return (fundsRaised < goal && block.number > deadline);
        }
        
    function contribute() 
        public 
        payable
        returns (bool success) {
        if(msg.value==0) revert();
        fundsRaised += msg.value;
        FunderStruct memory newFunder;
        newFunder.funder = msg.sender;
        newFunder.amount = msg.value;
        funderStructs.push(newFunder);
        LogContribute(msg.sender, msg.value);
        return true;
    }
    
    function withdrawFunds() 
        public
        returns (bool success) {
        if(msg.sender!=owner) revert();
        if(!isSuccess()) revert();
        uint amount = this.balance;
        if(!owner.send(amount)) revert();
        LogWithdrawal(owner, amount);
        return true;
    }
    
    function sendReFunds()
        public
        returns (bool success) {
        if(msg.sender != owner) revert();
        if(!hasFailed()) revert();
        uint funderCount = funderStructs.length;
        for(uint i=0; i<funderCount;i++){
            if(!funderStructs[i].funder.send(funderStructs[i].amount)){
                //to do : deal with the send failure case
            }
            LogRefundSent(funderStructs[i].funder, funderStructs[i].amount);
        }
        return true;
    }
}