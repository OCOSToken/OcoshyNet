// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title DAO Proof Commit Protocol
/// @notice Implements commitment-based DAO decision tracking without explicit voting
/// @dev No ownership, no admin, no tallying — only irreversible commitments
contract DAOProofCommit {
    struct Commitment {
        bytes32 proposalHash;
        bytes32 commitmentHash;
        uint256 timestamp;
    }

    mapping(address => Commitment[]) public commitments;

    event Committed(address indexed committer, bytes32 indexed proposalHash, bytes32 commitmentHash, uint256 timestamp);

    /// @notice Commit to a proposal via double-hash without revealing decision
    /// @param proposalHash Hash of the proposal content
    /// @param commitmentHash Keccak256(user-secret || proposalHash)
    function commit(bytes32 proposalHash, bytes32 commitmentHash) external {
        commitments[msg.sender].push(Commitment({
            proposalHash: proposalHash,
            commitmentHash: commitmentHash,
            timestamp: block.timestamp
        }));

        emit Committed(msg.sender, proposalHash, commitmentHash, block.timestamp);
    }

    /// @notice View commitment count by address
    /// @param committer Address that submitted commitments
    function countCommits(address committer) external view returns (uint256) {
        return commitments[committer].length;
    }

    /// @notice Retrieve a specific commitment
    /// @param committer Address that submitted
    /// @param index Index of commitment
    function getCommit(address committer, uint256 index) external view returns (Commitment memory) {
        return commitments[committer][index];
    }
}
