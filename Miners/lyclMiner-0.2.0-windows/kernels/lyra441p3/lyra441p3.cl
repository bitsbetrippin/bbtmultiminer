// lyra441p2 kernel.
// Author: CryptoGraphics ( CrGraphics@protonmail.com )

#define rotr64(x, n) ((n) < 32 ? (amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n)) | ((ulong)amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n)) << 32)) : (amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n) - 32) | ((ulong)amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n) - 32) << 32)))

#define Gfunc(a,b,c,d) \
{ \
    a += b;  \
    d ^= a; \
    ttr = rotr64(d, 32); \
    d = ttr; \
 \
    c += d;  \
    b ^= c; \
    ttr = rotr64(b, 24); \
    b = ttr; \
 \
    a += b;  \
    d ^= a; \
    ttr = rotr64(d, 16); \
    d = ttr; \
 \
    c += d; \
    b ^= c; \
    ttr = rotr64(b, 63); \
    b = ttr; \
}

#define roundLyra(state) \
{ \
     Gfunc(state[0].x, state[2].x, state[4].x, state[6].x); \
     Gfunc(state[0].y, state[2].y, state[4].y, state[6].y); \
     Gfunc(state[1].x, state[3].x, state[5].x, state[7].x); \
     Gfunc(state[1].y, state[3].y, state[5].y, state[7].y); \
 \
     Gfunc(state[0].x, state[2].y, state[5].x, state[7].y); \
     Gfunc(state[0].y, state[3].x, state[5].y, state[6].x); \
     Gfunc(state[1].x, state[3].y, state[4].x, state[6].y); \
     Gfunc(state[1].y, state[2].x, state[4].y, state[7].x); \
}

typedef union {
    uint h[8];
    uint4 h4[2];
    ulong2 hl4[2];
    ulong4 h8;
} hash_t;

typedef union {
    uint h[32];
    ulong2 hl4[8];
    uint4 h4[8];
    ulong4 h8[4];
} lyraState_t;

__attribute__((reqd_work_group_size(256, 1, 1)))
__kernel void lyra441p3(__global uint* hashes, __global uint* lyraStates)
{
    int gid = get_global_id(0);

    __global hash_t *hash = (__global hash_t *)(hashes + (8* (get_global_id(0))));
    __global lyraState_t *lyraState = (__global lyraState_t *)(lyraStates + (32* (get_global_id(0))));

    ulong ttr;

    ulong2 state[8];
    // 1. load lyra State
    state[0] = lyraState->hl4[0];
    state[1] = lyraState->hl4[1];
    state[2] = lyraState->hl4[2];
    state[3] = lyraState->hl4[3];
    state[4] = lyraState->hl4[4];
    state[5] = lyraState->hl4[5];
    state[6] = lyraState->hl4[6];
    state[7] = lyraState->hl4[7];

    // 2. rounds
    for (int i = 0; i < 12; ++i)
    {
        roundLyra(state);
    }

    // 3. store result
    hash->hl4[0] = state[0];
    hash->hl4[1] = state[1];
    
    barrier(CLK_LOCAL_MEM_FENCE);
}
