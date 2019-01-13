// blake32 kernel.
// Author: CryptoGraphics ( CrGraphics@protonmail.com )

#define rotr32(a, w, c) \
{ \
    a = ( w >> c ) | ( w << ( 32 - c ) ); \
}

#define blake32GS(a, b, c, d, x, y, mx, my) \
{ \
    v[a] += (mx ^ c_u256[y]) + v[b]; \
    v[d] ^= v[a]; \
    rotr32(v[d], v[d], 16U); \
    v[c] += v[d]; \
    v[b] ^= v[c]; \
    rotr32(v[b], v[b], 12U); \
 \
    v[a] += (my ^ c_u256[x]) + v[b]; \
    v[d] ^= v[a]; \
    rotr32(v[d], v[d], 8U); \
    v[c] += v[d]; \
    v[b] ^= v[c]; \
    rotr32(v[b], v[b], 7U); \
}

#define byteSwapU32(ret, val) \
{ \
    val = ((val << 8U) & 0xFF00FF00U ) | ((val >> 8U) & 0xFF00FFU ); \
    ret = (val << 16U) | (val >> 16U); \
}

typedef union {
  uint4 h4[2];
  ulong4 h8;
} hash_t;

__attribute__((reqd_work_group_size(256, 1, 1)))
__kernel void blake32(__global uint* hashes,
                      const uint uH0, const uint uH1, const uint uH2, const uint uH3,
                      const uint uH4, const uint uH5, const uint uH6, const uint uH7,
                      const uint in16, const uint in17, const uint in18, const uint firstNonce)
{
    int gid = get_global_id(0);
    
    __global hash_t *hash = (__global hash_t *)(hashes + (8* (get_global_id(0))));
    uint nonce = firstNonce + (uint)gid;
    
    
    const uint c_u256[16] = {
        0x243F6A88U, 0x85A308D3U,
        0x13198A2EU, 0x03707344U,
        0xA4093822U, 0x299F31D0U,
        0x082EFA98U, 0xEC4E6C89U,
        0x452821E6U, 0x38D01377U,
        0xBE5466CFU, 0x34E90C6CU,
        0xC0AC29B7U, 0xC97C50DDU,
        0x3F84D5B5U, 0xB5470917U
    };

    uint h[8];
    uint v[16];
    
    h[0]=uH0;
    h[1]=uH1;
    h[2]=uH2;
    h[3]=uH3;
    h[4]=uH4;
    h[5]=uH5;
    h[6]=uH6;
    h[7]=uH7;    
        
    for (int i = 0; i < 8; ++i)
        v[i] = h[i];
    
    v[8] =  0x243F6A88U;
    v[9] =  0x85A308D3U;
    v[10] = 0x13198A2EU;
    v[11] = 0x03707344U;
    v[12] = 0xA4093822U ^ 640U;
    v[13] = 0x299F31D0U ^ 640U;
    v[14] = 0x082EFA98U;
    v[15] = 0xEC4E6C89U;

    //  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
    blake32GS(0, 4, 0x8, 0xC, 0, 1,     in16, in17);
    blake32GS(1, 5, 0x9, 0xD, 2, 3,     in18, nonce);
    blake32GS(2, 6, 0xA, 0xE, 4, 5,     0x80000000U, 0U);
    blake32GS(3, 7, 0xB, 0xF, 6, 7,     0U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 8, 9,     0U, 0U);
    blake32GS(1, 6, 0xB, 0xC, 10, 11,   0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 12, 13,   0U, 1U);
    blake32GS(3, 4, 0x9, 0xE, 14, 15,   0U, 640U);

    //  { 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 },
    blake32GS(0, 4, 0x8, 0xC, 14, 10,   0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 4, 8,     0x80000000, 0U);
    blake32GS(2, 6, 0xA, 0xE, 9, 15,    0U, 640U);
    blake32GS(3, 7, 0xB, 0xF, 13, 6,    1U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 1, 12,    in17, 0U);
    blake32GS(1, 6, 0xB, 0xC, 0, 2,     in16, in18);
    blake32GS(2, 7, 0x8, 0xD, 11, 7,    0U, 0U);
    blake32GS(3, 4, 0x9, 0xE, 5, 3,     0U, nonce);

    //  { 11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4 },
    blake32GS(0, 4, 0x8, 0xC, 11, 8,    0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 12, 0,    0U, in16);
    blake32GS(2, 6, 0xA, 0xE, 5, 2,     0U, in18);
    blake32GS(3, 7, 0xB, 0xF, 15, 13,   640U, 1U);
    blake32GS(0, 5, 0xA, 0xF, 10, 14,   0U, 0U);
    blake32GS(1, 6, 0xB, 0xC, 3, 6,     nonce, 0U);
    blake32GS(2, 7, 0x8, 0xD, 7, 1,     0U, in17);
    blake32GS(3, 4, 0x9, 0xE, 9, 4,     0U, 0x80000000U);
    
    //  { 7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8 },
    blake32GS(0, 4, 0x8, 0xC, 7, 9,     0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 3, 1,     nonce, in17);
    blake32GS(2, 6, 0xA, 0xE, 13, 12,   1U, 0U);
    blake32GS(3, 7, 0xB, 0xF, 11, 14,   0U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 2, 6,     in18, 0U);
    blake32GS(1, 6, 0xB, 0xC, 5, 10,    0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 4, 0,     0x80000000U, in16);
    blake32GS(3, 4, 0x9, 0xE, 15, 8,    640U, 0U);

    //  { 9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13 },
    blake32GS(0, 4, 0x8, 0xC, 9, 0,     0U, in16);
    blake32GS(1, 5, 0x9, 0xD, 5, 7,     0U, 0U);
    blake32GS(2, 6, 0xA, 0xE, 2, 4,     in18, 0x80000000U);
    blake32GS(3, 7, 0xB, 0xF, 10, 15,   0U, 640U);
    blake32GS(0, 5, 0xA, 0xF, 14, 1,    0U, in17);
    blake32GS(1, 6, 0xB, 0xC, 11, 12,   0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 6, 8,     0U, 0U);
    blake32GS(3, 4, 0x9, 0xE, 3, 13,    nonce, 1U);
    
    //  { 2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9 },
    blake32GS(0, 4, 0x8, 0xC, 2, 12,    in18, 0U);
    blake32GS(1, 5, 0x9, 0xD, 6, 10,    0U, 0U);
    blake32GS(2, 6, 0xA, 0xE, 0, 11,    in16, 0U);
    blake32GS(3, 7, 0xB, 0xF, 8, 3,     0U, nonce);
    blake32GS(0, 5, 0xA, 0xF, 4, 13,    0x80000000U, 1U);
    blake32GS(1, 6, 0xB, 0xC, 7, 5,     0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 15, 14,   640U, 0U);
    blake32GS(3, 4, 0x9, 0xE, 1, 9,     in17, 0U);

    //  { 12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11 },
    blake32GS(0, 4, 0x8, 0xC, 12, 5,    0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 1, 15,    in17, 640U);
    blake32GS(2, 6, 0xA, 0xE, 14, 13,   0U, 1U);
    blake32GS(3, 7, 0xB, 0xF, 4, 10,    0x80000000U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 0, 7,     in16, 0U);
    blake32GS(1, 6, 0xB, 0xC, 6, 3,     0U, nonce);
    blake32GS(2, 7, 0x8, 0xD, 9, 2,     0U, in18);
    blake32GS(3, 4, 0x9, 0xE, 8, 11,    0U, 0U);

    //  { 13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10 },
    blake32GS(0, 4, 0x8, 0xC, 13, 11,   1U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 7, 14,    0U, 0U);
    blake32GS(2, 6, 0xA, 0xE, 12, 1,    0U, in17);
    blake32GS(3, 7, 0xB, 0xF, 3, 9,     nonce, 0U);
    blake32GS(0, 5, 0xA, 0xF, 5, 0,     0U, in16);
    blake32GS(1, 6, 0xB, 0xC, 15, 4,    640U, 0x80000000U);
    blake32GS(2, 7, 0x8, 0xD, 8, 6,     0U, 0U);
    blake32GS(3, 4, 0x9, 0xE, 2, 10,    in18, 0U);
  
    //  { 6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5 },
    blake32GS(0, 4, 0x8, 0xC, 6, 15,    0U, 640U);
    blake32GS(1, 5, 0x9, 0xD, 14, 9,    0U, 0U);
    blake32GS(2, 6, 0xA, 0xE, 11, 3,    0U, nonce);
    blake32GS(3, 7, 0xB, 0xF, 0, 8,     in16, 0U);
    blake32GS(0, 5, 0xA, 0xF, 12, 2,    0U, in18);
    blake32GS(1, 6, 0xB, 0xC, 13, 7,    1U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 1, 4,     in17, 0x80000000U);
    blake32GS(3, 4, 0x9, 0xE, 10, 5,    0U, 0U);
    
    //  { 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0 },
    blake32GS(0, 4, 0x8, 0xC, 10, 2,    0U, in18);
    blake32GS(1, 5, 0x9, 0xD, 8, 4,     0U, 0x80000000U);
    blake32GS(2, 6, 0xA, 0xE, 7, 6,     0U, 0U);
    blake32GS(3, 7, 0xB, 0xF, 1, 5,     in17, 0U);
    blake32GS(0, 5, 0xA, 0xF, 15, 11,   640U, 0U);
    blake32GS(1, 6, 0xB, 0xC, 9, 14,    0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 3, 12,    nonce, 0U);
    blake32GS(3, 4, 0x9, 0xE, 13, 0,    1U, in16);
    
        
    //  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
    blake32GS(0, 4, 0x8, 0xC, 0, 1,     in16, in17);
    blake32GS(1, 5, 0x9, 0xD, 2, 3,     in18, nonce);
    blake32GS(2, 6, 0xA, 0xE, 4, 5,     0x80000000U, 0U);
    blake32GS(3, 7, 0xB, 0xF, 6, 7,     0U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 8, 9,     0U, 0U);
    blake32GS(1, 6, 0xB, 0xC, 10, 11,   0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 12, 13,   0U, 1U);
    blake32GS(3, 4, 0x9, 0xE, 14, 15,   0U, 640U);

    //  { 14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3 },
    blake32GS(0, 4, 0x8, 0xC, 14, 10,   0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 4, 8,     0x80000000, 0U);
    blake32GS(2, 6, 0xA, 0xE, 9, 15,    0U, 640U);
    blake32GS(3, 7, 0xB, 0xF, 13, 6,    1U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 1, 12,    in17, 0U);
    blake32GS(1, 6, 0xB, 0xC, 0, 2,     in16, in18);
    blake32GS(2, 7, 0x8, 0xD, 11, 7,    0U, 0U);
    blake32GS(3, 4, 0x9, 0xE, 5, 3,     0U, nonce);

    //  { 11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4 },
    blake32GS(0, 4, 0x8, 0xC, 11, 8,    0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 12, 0,    0U, in16);
    blake32GS(2, 6, 0xA, 0xE, 5, 2,     0U, in18);
    blake32GS(3, 7, 0xB, 0xF, 15, 13,   640U, 1U);
    blake32GS(0, 5, 0xA, 0xF, 10, 14,   0U, 0U);
    blake32GS(1, 6, 0xB, 0xC, 3, 6,     nonce, 0U);
    blake32GS(2, 7, 0x8, 0xD, 7, 1,     0U, in17);
    blake32GS(3, 4, 0x9, 0xE, 9, 4,     0U, 0x80000000U);
    
    //  { 7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8 },
    blake32GS(0, 4, 0x8, 0xC, 7, 9,     0U, 0U);
    blake32GS(1, 5, 0x9, 0xD, 3, 1,     nonce, in17);
    blake32GS(2, 6, 0xA, 0xE, 13, 12,   1U, 0U);
    blake32GS(3, 7, 0xB, 0xF, 11, 14,   0U, 0U);
    blake32GS(0, 5, 0xA, 0xF, 2, 6,     in18, 0U);
    blake32GS(1, 6, 0xB, 0xC, 5, 10,    0U, 0U);
    blake32GS(2, 7, 0x8, 0xD, 4, 0,     0x80000000U, in16);
    blake32GS(3, 4, 0x9, 0xE, 15, 8,    640U, 0U);


    h[0] ^= v[0] ^ v[8];
    h[1] ^= v[1] ^ v[9];
    h[2] ^= v[2] ^ v[10];
    h[3] ^= v[3] ^ v[11];
    h[4] ^= v[4] ^ v[12];
    h[5] ^= v[5] ^ v[13];
    h[6] ^= v[6] ^ v[14];
    h[7] ^= v[7] ^ v[15];
    
    for (int i = 0; i < 8; ++i)
    {
        byteSwapU32(h[i], h[i]);
    }
    
    hash->h4[0] = (uint4)(h[0], h[1], h[2], h[3]);
    hash->h4[1] = (uint4)(h[4], h[5], h[6], h[7]);
    
    barrier(CLK_LOCAL_MEM_FENCE);
}