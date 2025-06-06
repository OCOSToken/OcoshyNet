// zkProof.test.js
// Unit test for zk_time_proof.sol

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("zkTimeProof", function () {
    let zkTimeProof;

    beforeEach(async function () {
        const ZK = await ethers.getContractFactory("zkTimeProof");
        zkTimeProof = await ZK.deploy();
        await zkTimeProof.deployed();
    });

    it("should accept valid BTC timestamped proof", async function () {
        const message = ethers.utils.formatBytes32String("truth-is-timed");
        const btcBlockHeight = 835000;
        const btcBlockHash = ethers.utils.formatBytes32String("btc-block-hash");
        const timestamp = Math.floor(Date.now() / 1000) - 3600;

        await expect(
            zkTimeProof.submitZkProof(message, btcBlockHeight, btcBlockHash, timestamp)
        ).to.emit(zkTimeProof, "TimeStamped");

        const header = await zkTimeProof.getHeader(message);
        expect(header.height).to.equal(btcBlockHeight);
        expect(header.blockHash).to.equal(btcBlockHash);
    });

    it("should reject future timestamps", async function () {
        const message = ethers.utils.formatBytes32String("invalid-future-proof");
        const futureTimestamp = Math.floor(Date.now() / 1000) + 3600;

        await expect(
            zkTimeProof.submitZkProof(
                message,
                850000,
                ethers.utils.formatBytes32String("future-block"),
                futureTimestamp
            )
        ).to.be.revertedWith("Invalid: Future timestamp not accepted");
    });
});
