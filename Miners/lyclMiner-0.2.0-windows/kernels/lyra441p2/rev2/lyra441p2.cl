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

#define roundLyra_sm(state) \
{ \
    Gfunc(state[0], state[1], state[2], state[3]); \
    smState[lIdx].s0 = state[1]; \
    smState[lIdx].s1 = state[2]; \
    smState[lIdx].s2 = state[3]; \
    barrier(CLK_LOCAL_MEM_FENCE); \
    state[1] = smState[gr4 + ((lIdx+1) & 3)].s0; \
    state[2] = smState[gr4 + ((lIdx+2) & 3)].s1; \
    state[3] = smState[gr4 + ((lIdx+3) & 3)].s2; \
 \
    Gfunc(state[0], state[1], state[2], state[3]); \
 \
    smState[lIdx].s0 = state[1]; \
    smState[lIdx].s1 = state[2]; \
    smState[lIdx].s2 = state[3]; \
    barrier(CLK_LOCAL_MEM_FENCE); \
    state[1] = smState[gr4 + ((lIdx+3) & 3)].s0; \
    state[2] = smState[gr4 + ((lIdx+2) & 3)].s1; \
    state[3] = smState[gr4 + ((lIdx+1) & 3)].s2; \
}

typedef union {
    uint h[32];
    ulong h2[16];
    uint4 h4[8];
    ulong4 h8[4];
} lyraState_t;

struct SharedState
{
    ulong s0;
    ulong s1;
    ulong s2;
};

#define loop3p1_iteration(st00,st01,st02, lm20,lm21,lm22) \
{ \
    t0 = state0[st00]; \
    c0 = state1[st00] + t0; \
    state[0] ^= c0; \
 \
    t0 = state0[st01]; \
    c0 = state1[st01] + t0; \
    state[1] ^= c0; \
 \
    t0 = state0[st02]; \
    c0 = state1[st02] + t0; \
    state[2] ^= c0; \
 \
    roundLyra_sm(state); \
 \
    state2[0] = state1[st00]; \
    state2[1] = state1[st01]; \
    state2[2] = state1[st02]; \
 \
    state2[0] ^= state[0]; \
    state2[1] ^= state[1]; \
    state2[2] ^= state[2]; \
 \
    lMatrix[lm20] = state2[0]; \
    lMatrix[lm21] = state2[1]; \
    lMatrix[lm22] = state2[2]; \
 \
    smState[lIdx].s0 = state[0]; \
    smState[lIdx].s1 = state[1]; \
    smState[lIdx].s2 = state[2]; \
    ulong Data0 = smState[gr4 + ((lIdx-1) & 3)].s0; \
    ulong Data1 = smState[gr4 + ((lIdx-1) & 3)].s1; \
    ulong Data2 = smState[gr4 + ((lIdx-1) & 3)].s2; \
    if((lIdx&3) == 0) \
    { \
        state0[st01] ^= Data0; \
        state0[st02] ^= Data1; \
        state0[st00] ^= Data2; \
    } \
    else \
    { \
        state0[st00] ^= Data0; \
        state0[st01] ^= Data1; \
        state0[st02] ^= Data2; \
    } \
 \
    lMatrix[st00] = state0[st00]; \
    lMatrix[st01] = state0[st01]; \
    lMatrix[st02] = state0[st02]; \
 \
    state0[st00] = state2[0]; \
    state0[st01] = state2[1]; \
    state0[st02] = state2[2]; \
}

#define loop3p2_iteration(st00,st01,st02, st10,st11,st12, lm30,lm31,lm32, lm10,lm11,lm12) \
{ \
    t0 = state1[st00]; \
    c0 = state0[st10] + t0; \
    state[0] ^= c0; \
 \
    t0 = state1[st01]; \
    c0 = state0[st11] + t0; \
    state[1] ^= c0; \
 \
    t0 = state1[st02]; \
    c0 = state0[st12] + t0; \
    state[2] ^= c0; \
 \
    roundLyra_sm(state); \
 \
    state0[st10] ^= state[0]; \
    state0[st11] ^= state[1]; \
    state0[st12] ^= state[2]; \
 \
    lMatrix[lm30] = state0[st10]; \
    lMatrix[lm31] = state0[st11]; \
    lMatrix[lm32] = state0[st12]; \
 \
    smState[lIdx].s0 = state[0]; \
    smState[lIdx].s1 = state[1]; \
    smState[lIdx].s2 = state[2]; \
    ulong Data0 = smState[gr4 + ((lIdx-1) & 3)].s0; \
    ulong Data1 = smState[gr4 + ((lIdx-1) & 3)].s1; \
    ulong Data2 = smState[gr4 + ((lIdx-1) & 3)].s2; \
    if((lIdx&3) == 0) \
    { \
        state1[st01] ^= Data0; \
        state1[st02] ^= Data1; \
        state1[st00] ^= Data2; \
    } \
    else \
    { \
        state1[st00] ^= Data0; \
        state1[st01] ^= Data1; \
        state1[st02] ^= Data2; \
    } \
 \
    lMatrix[lm10] = state1[st00]; \
    lMatrix[lm11] = state1[st01]; \
    lMatrix[lm12] = state1[st02]; \
}


#define wanderIteration_orig(prv00,prv01,prv02, rng00,rng01,rng02, rng10,rng11,rng12, rng20,rng21,rng22, rng30,rng31,rng32, rou00,rou01,rou02) \
{ \
    a_state1_0 = lMatrix[prv00]; \
    a_state1_1 = lMatrix[prv01]; \
    a_state1_2 = lMatrix[prv02]; \
 \
    b0 = (rowa < 2)? lMatrix[rng00]: lMatrix[rng20]; \
    b1 = (rowa < 2)? lMatrix[rng10]: lMatrix[rng30]; \
    a_state2_0 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
 \
    b0 = (rowa < 2)? lMatrix[rng01]: lMatrix[rng21]; \
    b1 = (rowa < 2)? lMatrix[rng11]: lMatrix[rng31]; \
    a_state2_1 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
 \
    b0 = (rowa < 2)? lMatrix[rng02]: lMatrix[rng22]; \
    b1 = (rowa < 2)? lMatrix[rng12]: lMatrix[rng32]; \
    a_state2_2 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
    t0 = a_state1_0; \
    c0 = a_state2_0 + t0; \
    state[0] ^= c0; \
 \
    t0 = a_state1_1; \
    c0 = a_state2_1 + t0; \
    state[1] ^= c0; \
 \
    t0 = a_state1_2; \
    c0 = a_state2_2 + t0; \
    state[2] ^= c0; \
 \
    roundLyra_sm(state); \
 \
    smState[lIdx].s0 = state[0]; \
    smState[lIdx].s1 = state[1]; \
    smState[lIdx].s2 = state[2]; \
 \
    a_state1_0 = smState[gr4 + ((lIdx-1) & 3)].s0; \
    a_state1_1 = smState[gr4 + ((lIdx-1) & 3)].s1; \
    a_state1_2 = smState[gr4 + ((lIdx-1) & 3)].s2; \
    if((lIdx&3) == 0) \
    { \
        a_state2_1 ^= a_state1_0; \
        a_state2_2 ^= a_state1_1; \
        a_state2_0 ^= a_state1_2; \
    } \
    else \
    { \
        a_state2_0 ^= a_state1_0; \
        a_state2_1 ^= a_state1_1; \
        a_state2_2 ^= a_state1_2; \
    } \
 \
    if(rowa == 0) \
    { \
        lMatrix[rng00] = a_state2_0; \
        lMatrix[rng01] = a_state2_1; \
        lMatrix[rng02] = a_state2_2; \
    } \
    if(rowa == 1) \
    { \
        lMatrix[rng10] = a_state2_0; \
        lMatrix[rng11] = a_state2_1; \
        lMatrix[rng12] = a_state2_2; \
    } \
    if(rowa == 2) \
    { \
        lMatrix[rng20] = a_state2_0; \
        lMatrix[rng21] = a_state2_1; \
        lMatrix[rng22] = a_state2_2; \
    } \
    if(rowa == 3) \
    { \
        lMatrix[rng30] = a_state2_0; \
        lMatrix[rng31] = a_state2_1; \
        lMatrix[rng32] = a_state2_2; \
    } \
 \
    lMatrix[rou00] ^= state[0]; \
    lMatrix[rou01] ^= state[1]; \
    lMatrix[rou02] ^= state[2]; \
}


#define wanderIteration(prv00,prv01,prv02, rng00,rng01,rng02, rng10,rng11,rng12, rng20,rng21,rng22, rng30,rng31,rng32, rou00,rou01,rou02) \
{ \
    a_state1_0 = lMatrix[prv00]; \
    a_state1_1 = lMatrix[prv01]; \
    a_state1_2 = lMatrix[prv02]; \
 \
    b0 = (rowa < 2)? lMatrix[rng00]: lMatrix[rng20]; \
    b1 = (rowa < 2)? lMatrix[rng10]: lMatrix[rng30]; \
    a_state2_0 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
    b0 = (rowa < 2)? lMatrix[rng01]: lMatrix[rng21]; \
    b1 = (rowa < 2)? lMatrix[rng11]: lMatrix[rng31]; \
    a_state2_1 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
    b0 = (rowa < 2)? lMatrix[rng02]: lMatrix[rng22]; \
    b1 = (rowa < 2)? lMatrix[rng12]: lMatrix[rng32]; \
    a_state2_2 = ((rowa & 0x1U) < 1)? b0: b1; \
 \
    t0 = a_state1_0; \
    c0 = a_state2_0 + t0; \
    state[0] ^= c0; \
 \
    t0 = a_state1_1; \
    c0 = a_state2_1 + t0; \
    state[1] ^= c0; \
 \
    t0 = a_state1_2; \
    c0 = a_state2_2 + t0; \
    state[2] ^= c0; \
 \
    roundLyra_sm(state); \
    smState[lIdx].s0 = state[0]; \
    smState[lIdx].s1 = state[1]; \
    smState[lIdx].s2 = state[2]; \
    barrier(CLK_LOCAL_MEM_FENCE); \
    a_state1_0 = smState[gr4 + ((lIdx-1) & 3)].s0; \
    a_state1_1 = smState[gr4 + ((lIdx-1) & 3)].s1; \
    a_state1_2 = smState[gr4 + ((lIdx-1) & 3)].s2; \
 \
    if(rowa == 0) \
    { \
        lMatrix[rng00] = a_state2_0; \
        lMatrix[rng01] = a_state2_1; \
        lMatrix[rng02] = a_state2_2; \
        lMatrix[rng00] ^=((lIdx&3) == 0)?a_state1_2:a_state1_0; \
        lMatrix[rng01] ^=((lIdx&3) == 0)?a_state1_0:a_state1_1; \
        lMatrix[rng02]^=((lIdx&3) == 0)?a_state1_1:a_state1_2; \
    } \
    if(rowa == 1) \
    { \
        lMatrix[rng10] = a_state2_0; \
        lMatrix[rng11] = a_state2_1; \
        lMatrix[rng12] = a_state2_2; \
        lMatrix[rng10] ^=((lIdx&3) == 0)?a_state1_2:a_state1_0; \
        lMatrix[rng11] ^=((lIdx&3) == 0)?a_state1_0:a_state1_1; \
        lMatrix[rng12]^=((lIdx&3) == 0)?a_state1_1:a_state1_2; \
    } \
    if(rowa == 2) \
    { \
        lMatrix[rng20] = a_state2_0; \
        lMatrix[rng21] = a_state2_1; \
        lMatrix[rng22] = a_state2_2; \
        lMatrix[rng20] ^=((lIdx&3) == 0)?a_state1_2:a_state1_0; \
        lMatrix[rng21] ^=((lIdx&3) == 0)?a_state1_0:a_state1_1; \
        lMatrix[rng22]^=((lIdx&3) == 0)?a_state1_1:a_state1_2; \
    } \
    if(rowa == 3) \
    { \
        lMatrix[rng30] = a_state2_0; \
        lMatrix[rng31] = a_state2_1; \
        lMatrix[rng32] = a_state2_2; \
        lMatrix[rng30] ^=((lIdx&3) == 0)?a_state1_2:a_state1_0; \
        lMatrix[rng31] ^=((lIdx&3) == 0)?a_state1_0:a_state1_1; \
        lMatrix[rng32]^=((lIdx&3) == 0)?a_state1_1:a_state1_2; \
    } \
 \
    lMatrix[rou00] ^= state[0]; \
    lMatrix[rou01] ^= state[1]; \
    lMatrix[rou02] ^= state[2]; \
}


#define wanderIterationP2(rin00,rin01,rin02, rng00,rng01,rng02, rng10,rng11,rng12, rng20,rng21,rng22, rng30,rng31,rng32) \
{ \
    t0 = lMatrix[rin00]; \
    b0 = (rowa < 2)? lMatrix[rng00]: lMatrix[rng20]; \
    b1 = (rowa < 2)? lMatrix[rng10]: lMatrix[rng30]; \
    c0 = ((rowa & 0x1U) < 1)? b0: b1; \
    t0+=c0; \
    state[0] ^= t0; \
 \
    t0 = lMatrix[rin01]; \
    b0 = (rowa < 2)? lMatrix[rng01]: lMatrix[rng21]; \
    b1 = (rowa < 2)? lMatrix[rng11]: lMatrix[rng31]; \
    c0 = ((rowa & 0x1U) < 1)? b0: b1; \
    t0+=c0; \
    state[1] ^= t0; \
 \
    t0 = lMatrix[rin02]; \
    b0 = (rowa < 2)? lMatrix[rng02]: lMatrix[rng22]; \
    b1 = (rowa < 2)? lMatrix[rng12]: lMatrix[rng32]; \
    c0 = ((rowa & 0x1U) < 1)? b0: b1; \
    t0+=c0; \
    state[2] ^= t0; \
 \
    roundLyra_sm(state); \
}


__attribute__((reqd_work_group_size(64, 1, 1)))
__kernel void lyra441p2(__global uint* lyraStates)
{
     __local struct SharedState smState[64];

    int gid = get_global_id(0) >> 2;
    __global lyraState_t *lyraState = (__global lyraState_t *)(lyraStates + (32* (gid)));

    ulong state[4];
    ulong ttr;
    ulong tmpRes;
    
    uint2 st2;

    uint lIdx = (uint)get_local_id(0);
    uint gr4 = ((lIdx >> 2) << 2);
    
    //-------------------------------------
    // Load Lyra state
    state[0] = (ulong)(lyraState->h2[(lIdx & 3)]);
    state[1] = (ulong)(lyraState->h2[(lIdx & 3)+4]);
    state[2] = (ulong)(lyraState->h2[(lIdx & 3)+8]);
    state[3] = (ulong)(lyraState->h2[(lIdx & 3)+12]);

    //-------------------------------------
    ulong lMatrix[48];
    ulong state0[12];
    ulong state1[12];
    
    // loop 1
    {
        state0[ 9] = state[0];
        state0[10] = state[1];
        state0[11] = state[2];
        
        roundLyra_sm(state);
        
        state0[6] = state[0];
        state0[7] = state[1];
        state0[8] = state[2];
        
        roundLyra_sm(state);
        
        state0[3] = state[0];
        state0[4] = state[1];
        state0[5] = state[2];
        
        roundLyra_sm(state);
        
        state0[0] = state[0];
        state0[1] = state[1];
        state0[2] = state[2];
        
        roundLyra_sm(state);
    }
    // loop 2
    {
        state[0] ^= state0[0];
        state[1] ^= state0[1];
        state[2] ^= state0[2];
        roundLyra_sm(state);
        state1[ 9] = state0[0] ^ state[0];
        state1[10] = state0[1] ^ state[1];
        state1[11] = state0[2] ^ state[2];
        
        
        state[0] ^= state0[3];
        state[1] ^= state0[4];
        state[2] ^= state0[5];
        roundLyra_sm(state);
        state1[6] = state0[3] ^ state[0];
        state1[7] = state0[4] ^ state[1];
        state1[8] = state0[5] ^ state[2];
        
        
        state[0] ^= state0[6];
        state[1] ^= state0[7];
        state[2] ^= state0[8];
        roundLyra_sm(state);
        state1[3] = state0[6] ^ state[0];
        state1[4] = state0[7] ^ state[1];
        state1[5] = state0[8] ^ state[2];
        
        
        state[0] ^= state0[ 9];
        state[1] ^= state0[10];
        state[2] ^= state0[11];
        roundLyra_sm(state);
        state1[0] = state0[ 9] ^ state[0];
        state1[1] = state0[10] ^ state[1];
        state1[2] = state0[11] ^ state[2];
    }
    
    // 0,1,2 : 3,4,5 : 6,7,8 : 9,10,11
    // 12,13,14 : 15,16,17 : 18,19,20 : 21,22,23
    // 24,25,26 : 27,28,29 : 30,31,32 : 33,34,35
    // 36,37,38 : 39,40,41 : 42,43,44 : 45,46,47
    
    ulong state2[3];
    ulong t0,c0;
    loop3p1_iteration(0, 1, 2, 33,34,35);
    loop3p1_iteration(3, 4, 5, 30,31,32);
    loop3p1_iteration(6, 7, 8, 27,28,29);
    loop3p1_iteration(9,10,11, 24,25,26);

    loop3p2_iteration(0, 1, 2, 9,10,11, 45,46,47, 12,13,14);
    loop3p2_iteration(3, 4, 5, 6, 7, 8, 42,43,44, 15,16,17);
    loop3p2_iteration(6, 7, 8, 3, 4, 5, 39,40,41, 18,19,20);
    loop3p2_iteration(9,10,11, 0, 1, 2, 36,37,38, 21,22,23);

    ulong a_state1_0, a_state1_1, a_state1_2;
    ulong a_state2_0, a_state2_1, a_state2_2;
    ulong b0,b1;

    smState[lIdx].s0 = state[0];
    barrier(CLK_LOCAL_MEM_FENCE);
    uint rowa = (uint)smState[gr4].s0 & 3;
    wanderIteration(36,37,38, 0, 1, 2, 12,13,14, 24,25,26, 36,37,38, 0, 1, 2);
    wanderIteration(39,40,41, 3, 4, 5, 15,16,17, 27,28,29, 39,40,41, 3, 4, 5);
    wanderIteration(42,43,44, 6, 7, 8, 18,19,20, 30,31,32, 42,43,44, 6, 7, 8);
    wanderIteration(45,46,47, 9,10,11, 21,22,23, 33,34,35, 45,46,47, 9,10,11);

    smState[lIdx].s0 = state[0];
    barrier(CLK_LOCAL_MEM_FENCE);
    rowa = (uint)smState[gr4].s0 & 3;
    wanderIteration(0, 1, 2, 0, 1, 2, 12,13,14, 24,25,26, 36,37,38, 12,13,14);
    wanderIteration(3, 4, 5, 3, 4, 5, 15,16,17, 27,28,29, 39,40,41, 15,16,17);
    wanderIteration(6, 7, 8, 6, 7, 8, 18,19,20, 30,31,32, 42,43,44, 18,19,20);
    wanderIteration(9,10,11, 9,10,11, 21,22,23, 33,34,35, 45,46,47, 21,22,23);

    smState[lIdx].s0 = state[0];
    barrier(CLK_LOCAL_MEM_FENCE);
    rowa = (uint)smState[gr4].s0 & 3;
    wanderIteration(12,13,14, 0, 1, 2, 12,13,14, 24,25,26, 36,37,38, 24,25,26);
    wanderIteration(15,16,17, 3, 4, 5, 15,16,17, 27,28,29, 39,40,41, 27,28,29);
    wanderIteration(18,19,20, 6, 7, 8, 18,19,20, 30,31,32, 42,43,44, 30,31,32);
    wanderIteration(21,22,23, 9,10,11, 21,22,23, 33,34,35, 45,46,47, 33,34,35);
    

    //------------------------------------
    // Wandering phase part2 (last iteration)
    smState[lIdx].s0 = state[0];
    barrier(CLK_LOCAL_MEM_FENCE);
    rowa = (uint)smState[gr4].s0 & 3;

    int i, j;
    ulong last[3];

    b0 = (rowa < 2)? lMatrix[0]: lMatrix[24];
    b1 = (rowa < 2)? lMatrix[12]: lMatrix[36];
    last[0] = ((rowa & 0x1U) < 1)? b0: b1;

    // st1
    b0 = (rowa < 2)? lMatrix[1]: lMatrix[25];
    b1 = (rowa < 2)? lMatrix[13]: lMatrix[37];
    last[1] = ((rowa & 0x1U) < 1)? b0: b1;

    // st2
    b0 = (rowa < 2)? lMatrix[2]: lMatrix[26];
    b1 = (rowa < 2)? lMatrix[14]: lMatrix[38];
    last[2] = ((rowa & 0x1U) < 1)? b0: b1;


    t0 = lMatrix[24];
    c0 = last[0] + t0;
    state[0] ^= c0;
    
    t0 = lMatrix[25];
    c0 = last[1] + t0;
    state[1] ^= c0;
    
    t0 = lMatrix[26];
    c0 = last[2] + t0;
    state[2] ^= c0;

    roundLyra_sm(state);
   
    smState[lIdx].s0 = state[0];
    smState[lIdx].s1 = state[1];
    smState[lIdx].s2 = state[2];
    barrier(CLK_LOCAL_MEM_FENCE);
    ulong Data0 = smState[gr4 + ((lIdx-1) & 3)].s0;
    ulong Data1 = smState[gr4 + ((lIdx-1) & 3)].s1;
    ulong Data2 = smState[gr4 + ((lIdx-1) & 3)].s2;  
    if((lIdx&3) == 0)
    {
        last[1] ^= Data0;
        last[2] ^= Data1;
        last[0] ^= Data2;
    }
    else
    {
        last[0] ^= Data0;
        last[1] ^= Data1;
        last[2] ^= Data2;
    }

    if(rowa == 3)
    {
        last[0] ^= state[0];
        last[1] ^= state[1];
        last[2] ^= state[2];
    }

    // 0,1,2 : 3,4,5 : 6,7,8 : 9,10,11
    // 12,13,14 : 15,16,17 : 18,19,20 : 21,22,23
    // 24,25,26 : 27,28,29 : 30,31,32 : 33,34,35
    // 36,37,38 : 39,40,41 : 42,43,44 : 45,46,47
    wanderIterationP2(27,28,29, 3, 4, 5, 15,16,17, 27,28,29, 39,40,41);
    wanderIterationP2(30,31,32, 6, 7, 8, 18,19,20, 30,31,32, 42,43,44);
    wanderIterationP2(33,34,35, 9,10,11, 21,22,23, 33,34,35, 45,46,47);

    state[0] ^= last[0];
    state[1] ^= last[1];
    state[2] ^= last[2];

    //-------------------------------------
    // save lyra state    
    lyraState->h2[(lIdx & 3)] = state[0];
    lyraState->h2[(lIdx & 3)+4] = state[1];
    lyraState->h2[(lIdx & 3)+8] = state[2];
    lyraState->h2[(lIdx & 3)+12] = state[3];
    
    barrier(CLK_LOCAL_MEM_FENCE);
}
