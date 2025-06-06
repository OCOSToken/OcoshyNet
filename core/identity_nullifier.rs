// identity_nullifier.rs
// Purpose: Scramble any user-provided ID or wallet key into non-reversible pseudonym

use sha2::{Sha256, Digest};
use rand::{thread_rng, RngCore};

/// Nullifies identity using SHA-256 combined with randomness
/// to break persistent correlation between sessions
pub fn nullify_identity(input: &str) -> String {
    let mut hasher = Sha256::new();
    let mut salt = [0u8; 32];
    thread_rng().fill_bytes(&mut salt);

    hasher.update(salt);
    hasher.update(input.as_bytes());
    let result = hasher.finalize();

    hex::encode(result)
}

/// Example usage
fn main() {
    let original_id = "0x6F42a1c8DfeF33C8181A3F8Ab5C29Fb2196F6b3B";
    let nullified = nullify_identity(original_id);
    println!("Original: {}\nNullified: {}", original_id, nullified);
}
