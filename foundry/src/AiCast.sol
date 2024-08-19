// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";

contract AiCast is FunctionsClient, ConfirmedOwner {
    using FunctionsRequest for FunctionsRequest.Request;

    bytes32 public s_lastRequestId;
    bytes public s_lastResponse;
    bytes public s_lastError;

    uint64 public s_subscriptionId;
    uint32 public s_gasLimit;
    bytes32 public s_donID;

    string public question;
    bool public answer;

    error UnexpectedRequestID(bytes32 requestId);

    event Response(bytes32 indexed requestId, bytes response, bytes err);

    constructor(address router, uint64 subscriptionId, uint32 gasLimit, bytes32 donID)
        FunctionsClient(router)
        ConfirmedOwner(msg.sender)
    {
        setSubscriptionId(subscriptionId);
        s_gasLimit = gasLimit;
        s_donID = donID;
    }

    function setSubscriptionId(uint64 subscriptionId) public onlyOwner {
        s_subscriptionId = subscriptionId;
    }

    function setGasLimit(uint32 gasLimit) public onlyOwner {
        s_gasLimit = gasLimit;
    }

    function setDonID(bytes32 donID) public onlyOwner {
        s_donID = donID;
    }

    function setQuestion(string calldata question_) public {
        question = question_;
    }

    /**
     * @notice Send a simple request
     * @param source JavaScript source code
     * @param arg Argument accessible from within the source code
     */
    function sendRequest(string memory source, string memory arg, uint64 donHostedSecretsVersion)
        external
        onlyOwner
        returns (bytes32)
    {
        FunctionsRequest.Request memory req;

        req.initializeRequestForInlineJavaScript(source);

        string[] memory args = new string[](1);
        args[0] = arg;
        req.setArgs(args);
        req.addDONHostedSecrets(0, donHostedSecretsVersion);

        s_lastRequestId = _sendRequest(req.encodeCBOR(), s_subscriptionId, s_gasLimit, s_donID);

        return s_lastRequestId;
    }

    /**
     * @notice Send a pre-encoded CBOR request
     * @param request CBOR-encoded request data
     * @param subscriptionId Billing ID
     * @param gasLimit The maximum amount of gas the request can consume
     * @param donID ID of the job to be invoked
     * @return requestId The ID of the sent request
     */
    function sendRequestCBOR(bytes memory request, uint64 subscriptionId, uint32 gasLimit, bytes32 donID)
        external
        onlyOwner
        returns (bytes32)
    {
        s_lastRequestId = _sendRequest(request, subscriptionId, gasLimit, donID);
        return s_lastRequestId;
    }

    /**
     * @notice Store latest result/error
     * @param requestId The request ID, returned by sendRequest()
     * @param response Aggregated response from the user code
     * @param err Aggregated error from the user code or from the execution pipeline
     * Either response or error parameter will be set, but never both
     */
    function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {
        if (s_lastRequestId != requestId) {
            revert UnexpectedRequestID(requestId);
        }
        s_lastResponse = response;
        s_lastError = err;
        emit Response(requestId, s_lastResponse, s_lastError);
    }
}
