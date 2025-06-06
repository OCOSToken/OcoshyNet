# Security.md

> _“You cannot exploit silence. You cannot patch absence.”_ — Ocoshy

---

## Philosophy of Security

OcoshyNet does not secure assets. It secures logic.
There is no financial state to attack, no ownership to hijack, and no authority to impersonate.

Security in OcoshyNet is built on:
- The absence of user accounts
- The irreversibility of entropy-based hashing
- Stateless communication with no replay memory
- Optional timestamp anchoring to an immutable external chain (Bitcoin)

---

## Attack Surface

| Vector | Risk | Mitigation |
|--------|------|------------|
| Replay of logic hashes | Low | No session or ownership, logic hashes are public by design |
| Identity correlation | Very low | SHA-256 entropy combined with per-instance salt nullifies reuse |
| Timestamp forgery | Moderate | Anchored to external BTC headers with delayed acceptance logic |
| Smart contract mutation | None | All contracts immutable, no admin, no upgrade paths |

---

## Trust Assumptions

- Nodes may lie.
- Timestamps may be faked.
- Messages may be malformed.

But none of these break the protocol, because:
- No user state is preserved
- No trust is required
- No identity is referenced

---

## Smart Contract Posture

- All `.sol` contracts are **stateless**, **event-driven**, and **non-upgradable**.
- There are **no owner-only functions**.
- There are **no roles**, **no pausing**, and **no treasury logic**.

---

## Disclosure Policy
There is no bug bounty.  
There is no security team.  
All issues are public.  
All exploits are philosophical.

If you find something wrong, make a logic hash about it.
That is how you disclose in OcoshyNet.

> _“No vault, no token, no key — no attack.”_
