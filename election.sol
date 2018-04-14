pragma solidity ^0.4.0;

//选举出认证人

contract election {

    //定义会员
    struct Voter{
        uint weight;//权重
        bool voted;//true代表该会员已投票
        address delegate;//被委托人
        uint vote;//提案id
    }

    //定义提案类型
    struct Proposal{
        bytes32 name;//提案名称
        uint voteCount;//得票数
    }

    address public chairperson;

    mapping(address => Voter) public voters;

    Proposal[] public proposals;

    //为每一个提案创建一个表决
    function election(bytes32 proposalNames) public {
        chairperson = msg.sender();

        voters.weight = 1;//赋予投票权

        for(uint i ; i <= proposalNames.length;i++){
            proposals.push(Proposal({name:proposalNames[i],
                                    voteCount:0}));
        }
    }

    //授予投票权
    function getRightToVote(address voter) public{
        require(
            (msg.sender == chairperson) &&
            !voters[voter].voted &&
            (voters[voter].weight == 0)
        );
        voters[voter].weight = 1;
    }

    //你的投票可以委托给某个组织或者个人 to
    function delegate(address to) public {
        Voter storage sender =  voters[msg.sender];
        require(!sender.voted);
        require(to == msg.sender);

        //委托传递
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // 不允许闭环委托
            require(to != msg.sender);
        }

        sender.voted = true;
        sender.delegate = to;

        Voter delegate_ = voters[to];

        if(delegate_.voted){
            proposals[delegate_.vote].voteCount += sender.weight;
        }else{
            delegate_.weight += sender.weight;
        }

    }

    //投票给提案
    function vote(uint proposalId) public {
        Voter storage sender = voters[msg.sender];
        sender.vote = proposalId;
        proposals[proposalId].voteCount += sender.weight;


    }

    //计算胜出的提案
    function winningProposal (uint) public view returns(uint winningProposal_){
        uint winningVoteCount = 0;

        for(uint p = 0;p < proposals.length;p++){
            if(proposals[p].voteCount > winningVoteCount){
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winningName (uint winningProposal) public view returns(uint winningName_){
        winningName_ = proposals[winningProposal()].name;
    }

}
