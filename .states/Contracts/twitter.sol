// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tweet {
    struct TweetInfo {
        address author;
        string content;
        uint256 timestamp;
        uint8 likes;
    }

    mapping(address => TweetInfo[]) public tweets;

    // Function to create a new tweet
    function createTweet(string memory tweet) public returns (TweetInfo memory) {
        TweetInfo memory newTweet = TweetInfo({
            author: msg.sender,
            content: tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
        return newTweet;
    }

    // Function to get a tweet by ID for a specific owner
    function getTweetById(address owner, uint256 id) public view returns (TweetInfo memory) {
        require(id < tweets[owner].length, "Tweet does not exist");
        return tweets[owner][id];
    }

    // Function to get all tweets for a specific owner
    function getTweets(address owner) public view returns (TweetInfo[] memory) {
        return tweets[owner];
    }
}
