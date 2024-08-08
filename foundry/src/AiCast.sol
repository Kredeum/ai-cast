// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract AiCast {
    string public question;
    bool public answer;

    function setQuestion(string calldata question_) public {
        question = question_;
    }
}
