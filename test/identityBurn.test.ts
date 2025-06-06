// identityBurn.test.ts
// Tests identity nullification logic in Rust wrapper via FFI (simulated)

import { expect } from "chai";
import { execSync } from "child_process";

describe("identity_nullifier.rs wrapper", function () {
    it("should return different nullified identities on each run", function () {
        const address = "0xF47e2F22c986bD21e4D6f8E803fB3b861C33cDd1";

        // Simulate calling the compiled Rust binary with the address as input
        const output1 = execSync(`./nullifier ${address}`).toString().trim();
        const output2 = execSync(`./nullifier ${address}`).toString().trim();

        expect(output1).to.not.equal(output2);
        expect(output1).to.match(/^[a-f0-9]{64}$/);
        expect(output2).to.match(/^[a-f0-9]{64}$/);
    });
});
