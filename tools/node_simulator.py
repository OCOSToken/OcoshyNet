# node_simulator.py
# Simulates pseudonymous node behavior for OcoshyNet

import time
import random
import hashlib

class OcoshyNode:
    def __init__(self):
        self.entropy = random.getrandbits(256)

    def generate_logic_hash(self, message: str) -> str:
        base = f"{message}|{self.entropy}|{int(time.time())}"
        return hashlib.sha256(base.encode()).hexdigest()

    def emit_logic(self, message: str):
        logic_hash = self.generate_logic_hash(message)
        print("[Ocoshy Node Emitted]:", logic_hash)
        return logic_hash

    def wait_random_delay(self):
        delay = random.uniform(0.3, 3.0)
        time.sleep(delay)
        return delay

if __name__ == "__main__":
    node = OcoshyNode()
    messages = ["trustless-initiation", "logic-ping", "timestamp-signed-thought"]

    for msg in messages:
        node.wait_random_delay()
        node.emit_logic(msg)
