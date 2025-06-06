// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title zkTimeProof
/// @notice Verifies message timestamps by anchoring them to Bitcoin block headers via zk commitments
/// @dev Simulates a BTC block header anchor to validate a given timestamp hash
contract zkTimeProof {
    event TimeStamped(bytes32 indexed messageHash, uint256 btcBlockHeight, bytes32 btcBlockHash);

    struct Header {
        uint256 height;
        bytes32 blockHash;
        uint256 timestamp;
    }

    mapping(bytes32 => Header) public verifiedMessages;

    /// @notice Submit a zk-proofed message with BTC header context
    /// @param messageHash The hash of the message content
    /// @param btcBlockHeight The block height on Bitcoin
    /// @param btcBlockHash The hash of the BTC block
    /// @param timestamp The timestamp extracted from BTC block
    function submitZkProof(
        bytes32 messageHash,
        uint256 btcBlockHeight,
        bytes32 btcBlockHash,
        uint256 timestamp
    ) external {
        // Simulated check — In real ZK implementation, this would be validated on-chain via circuit
        require(timestamp <= block.timestamp, "Invalid: Future timestamp not accepted");

        Header memory hdr = Header({
            height: btcBlockHeight,
            blockHash: btcBlockHash,
            timestamp: timestamp
        });

        verifiedMessages[messageHash] = hdr;
        emit TimeStamped(messageHash, btcBlockHeight, btcBlockHash);
    }

    /// @notice Retrieve BTC header metadata for a message
    /// @param messageHash The message hash to verify
    function getHeader(bytes32 messageHash) external view returns (Header memory) {
        return verifiedMessages[messageHash];
    }
} 
