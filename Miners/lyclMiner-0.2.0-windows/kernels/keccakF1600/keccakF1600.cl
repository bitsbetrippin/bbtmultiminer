// keccak-f1600 kernel.
// Based on the keccak-f1600 kernel by C. Buchner.
// AMDGCN specific optimizations were done by CryptoGraphics ( CrGraphics@protonmail.com )

#define rotr64(x, n) ((n) < 32 ? (amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n)) | ((ulong)amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n)) << 32)) : (amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n) - 32) | ((ulong)amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n) - 32) << 32)))

typedef union {
    uint h[8];
    ulong h2[4];
    uint4 h4[2];
    ulong4 h8;
} hash_t;

#define keccakF1600Iteration(index) \
{ \
	v = s00 ^ s05 ^ s10 ^ s15 ^ s20; \
	u2 = s01 ^ s06 ^ s11 ^ s16 ^ s21; \
	u3 = s02 ^ s07 ^ s12 ^ s17 ^ s22; \
	u4 = s03 ^ s08 ^ s13 ^ s18 ^ s23; \
	w = s04 ^ s09 ^ s14 ^ s19 ^ s24; \
 \
    ttr = rotr64(u2, 63); \
	u0 = w ^ ttr; \
    ttr = rotr64(u3, 63); \
	u1 = v ^ ttr; \
 \
    ttr = rotr64(u4, 63); \
	u2 ^= ttr; \
    ttr = rotr64(w, 63); \
	u3 ^= ttr; \
    ttr = rotr64(v, 63); \
	u4 ^= ttr; \
 \
	s00 ^= u0; s05 ^= u0; s10 ^= u0; s15 ^= u0; s20 ^= u0; \
	s01 ^= u1; s06 ^= u1; s11 ^= u1; s16 ^= u1; s21 ^= u1; \
	s02 ^= u2; s07 ^= u2; s12 ^= u2; s17 ^= u2; s22 ^= u2; \
	s03 ^= u3; s08 ^= u3; s13 ^= u3; s18 ^= u3; s23 ^= u3; \
	s04 ^= u4; s09 ^= u4; s14 ^= u4; s19 ^= u4; s24 ^= u4; \
 \
	v = s01; \
	s01 = rotr64(s06, 20); \
	s06 = rotr64(s09, 44); \
	s09 = rotr64(s22, 3); \
	s22 = rotr64(s14, 25); \
	s14 = rotr64(s20, 46); \
	s20 = rotr64(s02, 2); \
	s02 = rotr64(s12, 21); \
	s12 = rotr64(s13, 39); \
	s13 = rotr64(s19, 56); \
	s19 = rotr64(s23, 8); \
	s23 = rotr64(s15, 23); \
	s15 = rotr64(s04, 37); \
	s04 = rotr64(s24, 50); \
	s24 = rotr64(s21, 62); \
	s21 = rotr64(s08, 9); \
	s08 = rotr64(s16, 19); \
	s16 = rotr64(s05, 28); \
	s05 = rotr64(s03, 36); \
	s03 = rotr64(s18, 43); \
	s18 = rotr64(s17, 49); \
	s17 = rotr64(s11, 54); \
	s11 = rotr64(s07, 58); \
	s07 = rotr64(s10, 61); \
	s10 = rotr64(v, 63); \
 \
    v = s00; w = s01; s00 = bitselect(s00 ^ s02, s00, s01); s01 = bitselect(s01 ^ s03, s01, s02); s02 = bitselect(s02 ^ s04, s02, s03); s03 = bitselect(s03 ^ v, s03, s04); s04 = bitselect(s04 ^ w, s04, v); \
    v = s05; w = s06; s05 = bitselect(s05 ^ s07, s05, s06); s06 = bitselect(s06 ^ s08, s06, s07); s07 = bitselect(s07 ^ s09, s07, s08); s08 = bitselect(s08 ^ v, s08, s09); s09 = bitselect(s09 ^ w, s09, v); \
    v = s10; w = s11; s10 = bitselect(s10 ^ s12, s10, s11); s11 = bitselect(s11 ^ s13, s11, s12); s12 = bitselect(s12 ^ s14, s12, s13); s13 = bitselect(s13 ^ v, s13, s14); s14 = bitselect(s14 ^ w, s14, v); \
    v = s15; w = s16; s15 = bitselect(s15 ^ s17, s15, s16); s16 = bitselect(s16 ^ s18, s16, s17); s17 = bitselect(s17 ^ s19, s17, s18); s18 = bitselect(s18 ^ v, s18, s19); s19 = bitselect(s19 ^ w, s19, v); \
    v = s20; w = s21; s20 = bitselect(s20 ^ s22, s20, s21); s21 = bitselect(s21 ^ s23, s21, s22); s22 = bitselect(s22 ^ s24, s22, s23); s23 = bitselect(s23 ^ v, s23, s24); s24 = bitselect(s24 ^ w, s24, v); \
 \
	s00 ^= RC[index]; \
}

__constant static const ulong RC[24] = {
  0x0000000000000001, 0x0000000000008082,
  0x800000000000808A, 0x8000000080008000,
  0x000000000000808B, 0x0000000080000001,
  0x8000000080008081, 0x8000000000008009,
  0x000000000000008A, 0x0000000000000088,
  0x0000000080008009, 0x000000008000000A,
  0x000000008000808B, 0x800000000000008B,
  0x8000000000008089, 0x8000000000008003,
  0x8000000000008002, 0x8000000000000080,
  0x000000000000800A, 0x800000008000000A,
  0x8000000080008081, 0x8000000000008080,
  0x0000000080000001, 0x8000000080008008
};

__attribute__((reqd_work_group_size(256, 1, 1)))
__kernel void keccakF1600(__global uint* hashes)
{
    int gid = get_global_id(0);
    
    __global hash_t *hash = (__global hash_t *)(hashes + (8* (get_global_id(0))));

//-----------------------------------------------------------------------------
// keccak-f1600
    ulong s00 = hash->h2[0];
	ulong s01 = hash->h2[1];
	ulong s02 = hash->h2[2];
	ulong s03 = hash->h2[3];

//-------------------------------------
    // keccak block
	ulong u0, u1, u2, u3, u4, v, w;
	ulong s04, s05, s06, s07, s08, s09, s10;
	ulong s11, s12, s13, s14, s15, s16, s17;
	ulong s18, s19, s20, s21, s22, s23, s24;
    ulong ttr;
	u2 = s01 ^ 0x8000000000000000UL;

    ttr = rotr64(u2, 63);
	u0 = 0x0000000000000001UL ^ ttr;
    
    ttr = rotr64(s02, 63);
	u1 = s00 ^ ttr;
    
    ttr = rotr64(s03, 63);
	u2 ^= ttr;
	
    u3 = s02 ^ 0x0000000000000002UL;
    
    ttr = rotr64(s00, 63);
	u4 = s03 ^ ttr;

	s00 ^= u0;
	s01 ^= u1; s16 = 0x8000000000000000UL ^ u1;
	s02 ^= u2;
	s03 ^= u3;
	s04 = 0x0000000000000001UL ^ u4;

	v = s01;
	s01 = rotr64(u1, 20);
    s06 = rotr64(u4, 44);
	s09 = rotr64(u2, 3);
	s22 = rotr64(u4, 25);
	s14 = rotr64(u0, 46);
	s20 = rotr64(s02, 2);
	s02 = rotr64(u2, 21);
	s12 = rotr64(u3, 39);
	s13 = rotr64(u4, 56);
	s19 = rotr64(u3, 8);
	s23 = rotr64(u0, 23);
	s15 = rotr64(s04, 37);
	s04 = rotr64(u4, 50);
	s24 = rotr64(u1, 62);
	s21 = rotr64(u3, 9);
	s08 = rotr64(s16, 19);
	s16 = rotr64(u0, 28);
	s05 = rotr64(s03, 36);
	s03 = rotr64(u3, 43);
	s18 = rotr64(u2, 49);
	s17 = rotr64(u1, 54);
	s11 = rotr64(u2, 58);
	s07 = rotr64(u0, 61);
	s10 = rotr64(v, 63);
    
    v = s00; w = s01; s00 = bitselect(s00 ^ s02, s00, s01); s01 = bitselect(s01 ^ s03, s01, s02); s02 = bitselect(s02 ^ s04, s02, s03); s03 = bitselect(s03 ^ v, s03, s04); s04 = bitselect(s04 ^ w, s04, v); \
    v = s05; w = s06; s05 = bitselect(s05 ^ s07, s05, s06); s06 = bitselect(s06 ^ s08, s06, s07); s07 = bitselect(s07 ^ s09, s07, s08); s08 = bitselect(s08 ^ v, s08, s09); s09 = bitselect(s09 ^ w, s09, v); \
    v = s10; w = s11; s10 = bitselect(s10 ^ s12, s10, s11); s11 = bitselect(s11 ^ s13, s11, s12); s12 = bitselect(s12 ^ s14, s12, s13); s13 = bitselect(s13 ^ v, s13, s14); s14 = bitselect(s14 ^ w, s14, v); \
    v = s15; w = s16; s15 = bitselect(s15 ^ s17, s15, s16); s16 = bitselect(s16 ^ s18, s16, s17); s17 = bitselect(s17 ^ s19, s17, s18); s18 = bitselect(s18 ^ v, s18, s19); s19 = bitselect(s19 ^ w, s19, v); \
    v = s20; w = s21; s20 = bitselect(s20 ^ s22, s20, s21); s21 = bitselect(s21 ^ s23, s21, s22); s22 = bitselect(s22 ^ s24, s22, s23); s23 = bitselect(s23 ^ v, s23, s24); s24 = bitselect(s24 ^ w, s24, v); \

	s00 ^= RC[0];

    keccakF1600Iteration(1);
    keccakF1600Iteration(2);
    keccakF1600Iteration(3);
    keccakF1600Iteration(4);
    keccakF1600Iteration(5);
    keccakF1600Iteration(6);
    keccakF1600Iteration(7);
    keccakF1600Iteration(8);
    keccakF1600Iteration(9);
    keccakF1600Iteration(10);
    keccakF1600Iteration(11);
    keccakF1600Iteration(12);
    keccakF1600Iteration(13);
    keccakF1600Iteration(14);
    keccakF1600Iteration(15);
    keccakF1600Iteration(16);
    keccakF1600Iteration(17);
    keccakF1600Iteration(18);
    keccakF1600Iteration(19);
    keccakF1600Iteration(20);
    keccakF1600Iteration(21);
    keccakF1600Iteration(22);

	v = s00 ^ s05 ^ s10 ^ s15 ^ s20;
	u2 = s01 ^ s06 ^ s11 ^ s16 ^ s21;
	u3 = s02 ^ s07 ^ s12 ^ s17 ^ s22;
	u4 = s03 ^ s08 ^ s13 ^ s18 ^ s23;
	w = s04 ^ s09 ^ s14 ^ s19 ^ s24;

    ttr = rotr64(u2, 63);
	u0 = w ^ ttr;
    ttr = rotr64(u3, 63);
	u1 = v ^ ttr;
    ttr = rotr64(u4, 63);
	u2 ^= ttr;
    ttr = rotr64(w, 63);
	u3 ^= ttr;
    ttr = rotr64(v, 63);
	u4 ^= ttr;

	s00 ^= u0;
    ttr = s06 ^ u1;
	s01 = rotr64(ttr, 20);
    ttr = s12 ^ u2;
	s02 = rotr64(ttr, 21);
    ttr = s18 ^ u3;
	s03 = rotr64(ttr, 43);
    ttr = s24 ^ u4;
	s04 = rotr64(ttr, 50);

    v = s00; w = s01; s00 = bitselect(s00 ^ s02, s00, s01); s01 = bitselect(s01 ^ s03, s01, s02); s02 = bitselect(s02 ^ s04, s02, s03); s03 = bitselect(s03 ^ v, s03, s04); s04 = bitselect(s04 ^ w, s04, v);

	s00 ^= RC[23];
//-------------------------------------
    hash->h2[0] = s00;
	hash->h2[1] = s01;
	hash->h2[2] = s02;
	hash->h2[3] = s03;
    
    barrier(CLK_LOCAL_MEM_FENCE);
}
