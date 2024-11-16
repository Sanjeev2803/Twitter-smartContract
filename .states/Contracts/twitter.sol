// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Tweet {
    struct TweetInfo {
        uint16 id;               // Unique ID for each tweet of a user
        address author;          // Address of the tweet's author
        string content;          // Tweet content
        uint256 timestamp;       // Creation timestamp
        uint8 likes;             // Number of likes
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }
event TweetCreated(address indexed author, uint16 tweetId, string content, uint256 timestamp);
    event TweetLiked(address indexed liker, address indexed tweetAuthor, uint16 tweetId);
    event TweetUnliked(address indexed unliker, address indexed tweetAuthor, uint16 tweetId);
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);
    modifier isOwner() {
        require(owner == msg.sender, "You are not the owner!");
        _;
    }

    modifier hasLikes(address tweetOfUser, uint16 tweetId) {
        require(tweetId < tweets[tweetOfUser].length, "Tweet does not exist");
        require(tweets[tweetOfUser][tweetId].likes > 0, "No likes to remove");
        _;
    }

    function changeOwner(address newOwner) public isOwner {
        owner = newOwner;
        emit OwnerChanged(msg.sender, newOwner);
    }

    // Mapping each user address to an array of their tweets
    mapping(address => TweetInfo[]) public tweets;

    // Function to create a new tweet
    function createTweet(string memory tweet) public returns (TweetInfo memory) {
        uint16 tweetId = uint16(tweets[msg.sender].length); // Unique ID for the tweet within the user's tweets
        TweetInfo memory newTweet = TweetInfo({
            id: tweetId,
            author: msg.sender,
            content: tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);// Push the new tweet to the user's tweet array
        emit TweetCreated(msg.sender, tweetId, tweet, block.timestamp); 
        return newTweet;
    }

    // Function to like a specific tweet by a user
    function likeTweet(address tweetOfUser, uint16 tweetId) external {
        require(tweetId < tweets[tweetOfUser].length, "Tweet does not exist");
        tweets[tweetOfUser][tweetId].likes += 1; // Increment the likes for the tweet
        emit TweetLiked(msg.sender, tweetOfUser, tweetId);
    }

    // Function to unlike a specific tweet by a user using the hasLikes modifier
    function unlikeTweet(address tweetOfUser, uint16 tweetId) external hasLikes(tweetOfUser, tweetId) {
        tweets[tweetOfUser][tweetId].likes -= 1; // Decrement the likes for the tweet
        emit TweetUnliked(msg.sender, tweetOfUser, tweetId);
    }

    // Function to get a tweet by ID for a specific user
    function getTweetById(address particularUser, uint256 id) public view returns (TweetInfo memory) {
        require(id < tweets[particularUser].length, "Tweet does not exist");
        
        return tweets[particularUser][id]; // Access the specific tweet by its ID
    }

    // Function to get all tweets for a specific user
    function getTweets(address user) public view returns (TweetInfo[] memory) {
        return tweets[user]; // Return all tweets for the user
    }
}
