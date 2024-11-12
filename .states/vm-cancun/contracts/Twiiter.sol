// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter{
    struct Tweets{
        address author;
        string content;
        uint256 timestamp;
        uint8 likes;
    }

    mapping(address=>Tweets[]) public tweets;

function createTweet(string memory tweet)public returns(Tweets memory){
Tweets memory newTweet=Tweets({
    author:msg.sender,
    content:tweet,
    timestamp:block.timestamp,
    likes:0
});

tweets[msg.sender].push(newTweet);
return newTweet;

}

function getTweetbyId(address owner,uint8 id)public view returns(Tweets memory){
    return tweets[owner][id];
}
function getTweets(address owner)public view returns(Tweets[] memory){
    return tweets[owner];
}
}