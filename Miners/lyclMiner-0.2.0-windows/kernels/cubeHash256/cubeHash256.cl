// cubeHash256 kernel.
// Author: CryptoGraphics ( CrGraphics@protonmail.com )

#define SWAP(a,b) { uint u = a; a = b; b = u; }
#define SWAP2(a,b) { uint2 u = a; a = b; b = u; }

// NOTE: AMDGCN Windows compiler doesn't optimize this on GCN 1.0(Pitcairn).
// Alternatives:
// 1. amd_bitalign
// 2. implement as rotr32.
//#define ROTL32_x2(x,bits) ((x << bits) | (x >> ((uint2)(32,32) - bits)))

#define ROTL32_x2(r,v,bits) \
{ \
    r.x = amd_bitalign(v.x, v.x, (uint)(32 - bits)); \
    r.y = amd_bitalign(v.y, v.y, (uint)(32 - bits)); \
}

#define roundsX2(x) do \
{ \
    for (int r = 0; r < 8; r++) \
    { \
        x[8] = x[8] + x[0]; \
        ROTL32_x2(x[0], x[0], 7); \
        x[9] = x[9] + x[1]; \
        ROTL32_x2(x[1], x[1], 7); \
        x[10] = x[10] + x[2]; \
        ROTL32_x2(x[2], x[2], 7); \
        x[11] = x[11] + x[3]; \
        ROTL32_x2(x[3], x[3], 7); \
        x[12] = x[12] + x[ 4]; \
        ROTL32_x2(x[4], x[4], 7); \
        x[13] = x[13] + x[ 5]; \
        ROTL32_x2(x[5], x[5], 7); \
        x[14] = x[14] + x[6]; \
        ROTL32_x2(x[6], x[6], 7); \
        x[15] = x[15] + x[7]; \
        ROTL32_x2(x[7], x[7], 7); \
        SWAP2(x[ 0], x[4]); \
        x[ 0] ^= x[8]; \
        x[ 4] ^= x[12]; \
        SWAP2(x[ 1], x[5]); \
        x[ 1] ^= x[9]; \
        x[ 5] ^= x[13]; \
        SWAP2(x[ 2], x[6]); \
        x[ 2] ^= x[10]; \
        x[ 6] ^= x[14]; \
        SWAP2(x[ 3], x[7]); \
        x[ 3] ^= x[11]; \
        x[ 7] ^= x[15]; \
        SWAP2(x[8], x[9]); \
        SWAP2(x[12], x[13]); \
        SWAP2(x[10], x[11]); \
        SWAP2(x[14], x[15]); \
        x[ 8] = x[8] + x[ 0]; \
        ROTL32_x2(x[0], x[0], 11); \
        x[ 9] = x[9] + x[ 1]; \
        ROTL32_x2(x[1], x[1], 11); \
        x[10] = x[10] + x[ 2]; \
        ROTL32_x2(x[2], x[2], 11); \
        x[11] = x[11] + x[ 3]; \
        ROTL32_x2(x[3], x[3], 11); \
        x[12] = x[12] + x[ 4];  \
        ROTL32_x2(x[4], x[4], 11); \
        x[13] = x[13] + x[ 5]; \
        ROTL32_x2(x[5], x[5], 11); \
        x[14] = x[14] + x[ 6]; \
        ROTL32_x2(x[6], x[6], 11); \
        x[15] = x[15] + x[ 7]; \
        ROTL32_x2(x[7], x[7], 11); \
        SWAP2(x[ 0], x[ 2]); \
        x[ 0] ^= x[8]; \
        x[ 2] ^= x[10]; \
        SWAP2(x[ 1], x[ 3]); \
        x[ 1] ^= x[9]; \
        x[ 3] ^= x[11]; \
        SWAP2(x[ 4], x[ 6]); \
        x[4] ^= x[12]; \
        x[6] ^= x[14]; \
        SWAP2(x[ 5], x[ 7]); \
        x[5] ^= x[13]; \
        x[7] ^= x[15]; \
        SWAP(x[8].x, x[8].y); \
        SWAP(x[9].x, x[9].y); \
        SWAP(x[10].x, x[10].y); \
        SWAP(x[11].x, x[11].y); \
        SWAP(x[12].x, x[12].y); \
        SWAP(x[13].x, x[13].y); \
        SWAP(x[14].x, x[14].y); \
        SWAP(x[15].x, x[15].y); \
 \
 \
        x[8] = x[8] + x[0]; \
        ROTL32_x2(x[ 0], x[ 0], 7); \
        x[9] = x[9] + x[1]; \
        ROTL32_x2(x[1], x[1], 7); \
        x[10] = x[10] + x[2]; \
        ROTL32_x2(x[2], x[2], 7); \
        x[11] = x[11] + x[3]; \
        ROTL32_x2(x[3], x[3], 7); \
        x[12] = x[12] + x[ 4]; \
        ROTL32_x2(x[4], x[4], 7); \
        x[13] = x[13] + x[ 5]; \
        ROTL32_x2(x[5], x[5], 7); \
        x[14] = x[14] + x[6]; \
        ROTL32_x2(x[6], x[6], 7); \
        x[15] = x[15] + x[7]; \
        ROTL32_x2(x[7], x[7], 7); \
        SWAP2(x[ 0], x[4]); \
        x[ 0] ^= x[8]; \
        x[ 4] ^= x[12]; \
        SWAP2(x[ 1], x[5]); \
        x[ 1] ^= x[9]; \
        x[ 5] ^= x[13]; \
        SWAP2(x[ 2], x[6]); \
        x[ 2] ^= x[10]; \
        x[ 6] ^= x[14]; \
        SWAP2(x[ 3], x[7]); \
        x[ 3] ^= x[11]; \
        x[ 7] ^= x[15]; \
        SWAP2(x[8], x[9]); \
        SWAP2(x[12], x[13]); \
        SWAP2(x[10], x[11]); \
        SWAP2(x[14], x[15]); \
        x[ 8] = x[8] + x[ 0]; \
        ROTL32_x2(x[0], x[0], 11); \
        x[ 9] = x[9] + x[ 1]; \
        ROTL32_x2(x[1], x[1], 11); \
        x[10] = x[10] + x[ 2]; \
        ROTL32_x2(x[2], x[2], 11); \
        x[11] = x[11] + x[ 3]; \
        ROTL32_x2(x[3], x[3], 11); \
        x[12] = x[12] + x[ 4];  \
        ROTL32_x2(x[4], x[4], 11); \
        x[13] = x[13] + x[ 5]; \
        ROTL32_x2(x[5], x[5], 11); \
        x[14] = x[14] + x[ 6]; \
        ROTL32_x2(x[6], x[6], 11); \
        x[15] = x[15] + x[ 7]; \
        ROTL32_x2(x[7], x[7], 11); \
        SWAP2(x[ 0], x[ 2]); \
        x[ 0] ^= x[8]; \
        x[ 2] ^= x[10]; \
        SWAP2(x[ 1], x[ 3]); \
        x[ 1] ^= x[9]; \
        x[ 3] ^= x[11]; \
        SWAP2(x[ 4], x[ 6]); \
        x[4] ^= x[12]; \
        x[6] ^= x[14]; \
        SWAP2(x[ 5], x[ 7]); \
        x[5] ^= x[13]; \
        x[7] ^= x[15]; \
        SWAP(x[8].x, x[8].y); \
        SWAP(x[9].x, x[9].y); \
        SWAP(x[10].x, x[10].y); \
        SWAP(x[11].x, x[11].y); \
        SWAP(x[12].x, x[12].y); \
        SWAP(x[13].x, x[13].y); \
        SWAP(x[14].x, x[14].y); \
        SWAP(x[15].x, x[15].y); \
    } \
} while(0)


typedef union {
    uint h[8];
    uint4 h4[2];
    ulong4 h8;
} hash_t;

__attribute__((reqd_work_group_size(256, 1, 1)))
__kernel void cubeHash256(__global uint* hashes)
{
    int gid = get_global_id(0);
    
    __global hash_t *hash = (__global hash_t *)(hashes + (8* (get_global_id(0))));

    uint2 x[16] = {
        (uint2)(0xEA2BD4B4U, 0xCCD6F29FU), (uint2)(0x63117E71U, 0x35481EAEU), (uint2)(0x22512D5BU, 0xE5D94E63U), (uint2)(0x7E624131U, 0xF4CC12BEU),
        (uint2)(0xC2D0B696U, 0x42AF2070U), (uint2)(0xD0720C35U, 0x3361DA8CU), (uint2)(0x28CCECA4U, 0x8EF8AD83U), (uint2)(0x4680AC00U, 0x40E5FBABU),
        (uint2)(0xD89041C3U, 0x6107FBD5U), (uint2)(0x6C859D41U, 0xF0B26679U), (uint2)(0x09392549U, 0x5FA25603U), (uint2)(0x65C892FDU, 0x93CB6285U),
        (uint2)(0x2AF2B5AEU, 0x9E4B4E60U), (uint2)(0x774ABFDDU, 0x85254725U), (uint2)(0x15815AEBU, 0x4AB6AAD6U), (uint2)(0x9CDAF8AFU, 0xD6032C0AU)
    };
    
    uint4 ss00 = (uint4)(hash->h4[0]);
    uint4 ss01 = (uint4)(hash->h4[1]);
    x[0] ^= ss00.xy;
    x[1] ^= ss00.zw;
    x[2] ^= ss01.xy;
    x[3] ^= ss01.zw;
    
    roundsX2(x);
    x[0].x ^= 0x80U;
    roundsX2(x);
    
    x[15].y ^= 1U;
    
    for (int i = 0; i < 10; ++i)
    {
        roundsX2(x);
    }
    
    hash->h4[0] = (uint4)(x[0].x, x[0].y, x[1].x, x[1].y);
    hash->h4[1] = (uint4)(x[2].x, x[2].y, x[3].x, x[3].y);
    
    barrier(CLK_LOCAL_MEM_FENCE);
}

