pragma solidity ^0.4.2;

contract Story {

    
    struct storyLine
    {
        string line;
        uint voteCount;
    }
    
    storyLine[11] public arrayOfLines; // keep track of status of lines in each round
    string[100]public  finalStory;     // final lines in story
    uint public lineCount = 0;         // final story line count
    string public lineselected;
    uint public start; 
    mapping( address => uint[]) votedInThisRound;
    mapping(uint => string[]) suggestedThisRound;
    mapping(uint => uint) numberOfSuggestions;
    uint public Round;
 

    // Constructor
    constructor() public
    {
        // arrayOfLines[0].line = "Line 0 "; 
        // arrayOfLines[0].voteCount = 0;
        // arrayOfLines[1].line = "Line 1 "; 
        // arrayOfLines[1].voteCount = 0; 
        // arrayOfLines[2].line = "Line 2 "; 
        // arrayOfLines[2].voteCount = 0;
        // arrayOfLines[3].line = "Line 3 "; 
        // arrayOfLines[3].voteCount = 0;
        // arrayOfLines[4].line = "Line 4 "; 
        // arrayOfLines[4].voteCount = 0;
        start = now ;
        Round = 0;
    }

    // modifier notVoted()
    // {
    //     require( votedInThisRound[msg.sender]<1 , " Already proposed line ");
    // }

    function incrementRound()
    public
    {
        Round++;
    }

    function lol()
    public view
    returns (uint)
    {
        return numberOfSuggestions[Round];
    }

    function casteVote(uint idx) 
    public
    
    {
        // require(votedInThisRound[msg.sender] < 1," Already proposed line ");
        // uint Round = (uint)((now - start)/roundTimer);
        for (uint i = 0;i<votedInThisRound[msg.sender].length;i++) {
            require(votedInThisRound[msg.sender][i] != Round, "Already voted in this round");
        }
        votedInThisRound[msg.sender].push(Round);
        arrayOfLines[idx].voteCount += 1;
    }

    function addStoryLine() // add line to story and reset count to zero
    public
    {
        // uint Round = (uint)((now - start)/roundTimer);
        uint roundPropose = 0;
        uint flag = 0;
        for (uint i = 0;i<numberOfSuggestions[Round];i++)
        {
            if(arrayOfLines[i].voteCount > arrayOfLines[roundPropose].voteCount)
            {
                roundPropose = i;
            }
            if(arrayOfLines[roundPropose].voteCount > 0){
                flag = 1;
            }
            arrayOfLines[i].voteCount = 0;
        }
        if(flag==1){
            finalStory[lineCount] = arrayOfLines[roundPropose].line;
            lineCount ++;
            lineselected = arrayOfLines[roundPropose].line;   
        }
    }

    function addNew(string _newExtension) 
    public
    {
        // uint Round = (uint)((now - start)/roundTimer);
        suggestedThisRound[Round].push(_newExtension);
        arrayOfLines[numberOfSuggestions[Round]].line = _newExtension;
        arrayOfLines[numberOfSuggestions[Round]].voteCount = 0;
        numberOfSuggestions[Round]++;
    }

}
