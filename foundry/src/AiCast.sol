// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";

contract AiCast is FunctionsClient, ConfirmedOwner {
    using FunctionsRequest for FunctionsRequest.Request;

    string private _javascript;

    bytes32 public lastRequestId;
    string public lastResponse;
    bytes public lastError;
    string public lastUserPrompt;

    uint64 private _subscriptionId;
    uint32 private _gasLimit;
    bytes32 private _donID;
    uint64 public donHostedSecretsVersion;

    error UnexpectedRequestID(bytes32 requestId);

    event Javascript(string javascript);
    event Request(bytes32 indexed requestId, string request);
    event Response(bytes32 indexed requestId, string response, bytes err);

    constructor(
        address router,
        string memory javascript_,
        uint64 subscriptionId_,
        uint32 gasLimit_,
        bytes32 donID_,
        uint64 donHostedSecretsVersion_
    ) FunctionsClient(router) ConfirmedOwner(msg.sender) {
        _javascript = javascript_;
        _subscriptionId = subscriptionId_;
        _gasLimit = gasLimit_;
        _donID = donID_;
        donHostedSecretsVersion = donHostedSecretsVersion_;
    }

    function setJavascript(string memory javascript_) external onlyOwner {
        _javascript = javascript_;
        emit Javascript(javascript_);
    }

    function setSubscriptionId(uint64 subscriptionId_) external onlyOwner {
        _subscriptionId = subscriptionId_;
    }

    function setGasLimit(uint32 gasLimit_) external onlyOwner {
        _gasLimit = gasLimit_;
    }

    function setDonID(bytes32 donID_) external onlyOwner {
        _donID = donID_;
    }

    function setDonHostedSecretsVersion(uint64 donHostedSecretsVersion_) external onlyOwner {
        donHostedSecretsVersion = donHostedSecretsVersion_;
    }

    function sendRequest(string memory userPrompt) external onlyOwner returns (bytes32) {
        lastUserPrompt = userPrompt;
        lastRequestId = "";
        lastResponse = "";
        lastError = "";

        FunctionsRequest.Request memory req;

        req.initializeRequestForInlineJavaScript(_javascript);

        string[] memory args = new string[](1);
        args[0] = userPrompt;

        req.setArgs(args);
        req.addDONHostedSecrets(0, donHostedSecretsVersion);

        lastRequestId = _sendRequest(req.encodeCBOR(), _subscriptionId, _gasLimit, _donID);

        emit Request(lastRequestId, userPrompt);
        return lastRequestId;
    }

    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {
        if (lastRequestId != requestId) {
            revert UnexpectedRequestID(requestId);
        }
        lastResponse = string(response);
        lastError = err;
        emit Response(requestId, lastResponse, lastError);
    }
}
