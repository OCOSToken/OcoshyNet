// whispernet.c
// Minimalist P2P whisper communication layer for Ocoshy Protocol
// No identities, no handshake, only raw propagation

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_MSG_SIZE 256

typedef struct WhisperPacket {
    char message[MAX_MSG_SIZE];
    time_t timestamp;
    unsigned int entropy; // pseudo-random delay component
} WhisperPacket;

/// @brief Generate a whisper packet with embedded delay entropy
WhisperPacket create_packet(const char* msg) {
    WhisperPacket packet;
    strncpy(packet.message, msg, MAX_MSG_SIZE);
    packet.timestamp = time(NULL);
    packet.entropy = rand() % 1000 + 1; // delay jitter
    return packet;
}

/// @brief Simulate whisper propagation
void propagate_packet(WhisperPacket packet) {
    printf("[WHISPER] ~ %s\n", packet.message);
    printf("[TIMESTAMP] %ld\n", packet.timestamp);
    printf("[ENTROPY DELAY] %ums\n", packet.entropy);
    // In real deployment, this would broadcast to mesh network peers
}

int main() {
    srand(time(NULL));
    const char* logic = "0xL001: trustless initiation";
    WhisperPacket packet = create_packet(logic);
    propagate_packet(packet);
    return 0;
}
