/* Test kernel implementation.
 *
 * ==========================(LICENSE BEGIN)============================
 *
 * Copyright (c) 2016 tpruvot
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ===========================(LICENSE END)=============================
 *
 * @author tpruvot 2016
 */

#if __ENDIAN_LITTLE__
  #define SPH_LITTLE_ENDIAN 1
#else
  #define SPH_BIG_ENDIAN 1
#endif

#define SPH_UPTR sph_u64
typedef unsigned int sph_u32;
typedef int sph_s32;

#ifndef __OPENCL_VERSION__
  typedef unsigned long long sph_u64;
#else
  typedef unsigned long sph_u64;
#endif

#define SPH_64 1
#define SPH_64_TRUE 1

#define SPH_C32(x) ((sph_u32)(x ## U))
#define SPH_T32(x) (as_uint(x))
#define SPH_ROTL32(x, n) rotate(as_uint(x), as_uint(n))
#define SPH_ROTR32(x, n) SPH_ROTL32(x, (32 - (n)))

#define SPH_C64(x) ((sph_u64)(x ## UL))
#define SPH_T64(x) (as_ulong(x))
#define SPH_ROTL64(x, n) rotate(as_ulong(x), (n) & 0xFFFFFFFFFFFFFFFFUL)
#define SPH_ROTR64(x, n) SPH_ROTL64(x, (64 - (n)))

#define SPH_CUBEHASH_UNROLL 0

#include "skein.cl"
#include "cubehash.cl"
#include "fugue.cl"
#include "streebog.cl"

#define SWAP4(x) as_uint(as_uchar4(x).wzyx)
#define SWAP8(x) as_ulong(as_uchar8(x).s76543210)

#if SPH_BIG_ENDIAN
  #define DEC64LE(x) SWAP8(*(const __global sph_u64 *) (x));
#else
  #define DEC64LE(x) (*(const __global sph_u64 *) (x));
#endif

#define SHL(x, n) ((x) << (n))
#define SHR(x, n) ((x) >> (n))

typedef union {
  unsigned char h1[64];
  uint h4[16];
  ulong h8[8];
} hash_t;

#define SWAP8_OUTPUT(x)  SWAP8(x)

__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search(__global unsigned char* block, __global hash_t* hashes)
{
  uint gid = get_global_id(0);
  __global hash_t *hash = &(hashes[gid-get_global_offset(0)]);

  // input skein 80

  sph_u64 M0, M1, M2, M3, M4, M5, M6, M7;
  sph_u64 M8, M9;

  M0 = DEC64LE(block + 0);
  M1 = DEC64LE(block + 8);
  M2 = DEC64LE(block + 16);
  M3 = DEC64LE(block + 24);
  M4 = DEC64LE(block + 32);
  M5 = DEC64LE(block + 40);
  M6 = DEC64LE(block + 48);
  M7 = DEC64LE(block + 56);
  M8 = DEC64LE(block + 64);
  M9 = DEC64LE(block + 72);
  ((uint*)&M9)[1] = SWAP4(gid);

  //if (!gid) printf("M0 %02x..%02x\n", (uint) ((uchar*)&M0)[0], (uint) ((uchar*)&M0)[7]);

  sph_u64 h0 = SPH_C64(0x4903ADFF749C51CE);
  sph_u64 h1 = SPH_C64(0x0D95DE399746DF03);
  sph_u64 h2 = SPH_C64(0x8FD1934127C79BCE);
  sph_u64 h3 = SPH_C64(0x9A255629FF352CB1);
  sph_u64 h4 = SPH_C64(0x5DB62599DF6CA7B0);
  sph_u64 h5 = SPH_C64(0xEABE394CA9D5C3F4);
  sph_u64 h6 = SPH_C64(0x991112C71A75B523);
  sph_u64 h7 = SPH_C64(0xAE18A40B660FCC33);

  // h8 = h0 ^ h1 ^ h2 ^ h3 ^ h4 ^ h5 ^ h6 ^ h7 ^ SPH_C64(0x1BD11BDAA9FC1A22);
  sph_u64 h8 = SPH_C64(0xcab2076d98173ec4);

  sph_u64 t0 = 64;
  sph_u64 t1 = SPH_C64(0x7000000000000000);
  sph_u64 t2 = SPH_C64(0x7000000000000040); // t0 ^ t1;

  sph_u64 p0 = M0;
  sph_u64 p1 = M1;
  sph_u64 p2 = M2;
  sph_u64 p3 = M3;
  sph_u64 p4 = M4;
  sph_u64 p5 = M5;
  sph_u64 p6 = M6;
  sph_u64 p7 = M7;

  TFBIG_4e(0);
  TFBIG_4o(1);
  TFBIG_4e(2);
  TFBIG_4o(3);
  TFBIG_4e(4);
  TFBIG_4o(5);
  TFBIG_4e(6);
  TFBIG_4o(7);
  TFBIG_4e(8);
  TFBIG_4o(9);
  TFBIG_4e(10);
  TFBIG_4o(11);
  TFBIG_4e(12);
  TFBIG_4o(13);
  TFBIG_4e(14);
  TFBIG_4o(15);
  TFBIG_4e(16);
  TFBIG_4o(17);
  TFBIG_ADDKEY(p0, p1, p2, p3, p4, p5, p6, p7, h, t, 18);

  h0 = M0 ^ p0;
  h1 = M1 ^ p1;
  h2 = M2 ^ p2;
  h3 = M3 ^ p3;
  h4 = M4 ^ p4;
  h5 = M5 ^ p5;
  h6 = M6 ^ p6;
  h7 = M7 ^ p7;

  // second part with nonce
  p0 = M8;
  p1 = M9;
  p2 = p3 = p4 = p5 = p6 = p7 = 0;
  t0 = 80;
  t1 = SPH_C64(0xB000000000000000);
  t2 = SPH_C64(0xB000000000000050); // t0 ^ t1;
  h8 = h0 ^ h1 ^ h2 ^ h3 ^ h4 ^ h5 ^ h6 ^ h7 ^ SPH_C64(0x1BD11BDAA9FC1A22);

  TFBIG_4e(0);
  TFBIG_4o(1);
  TFBIG_4e(2);
  TFBIG_4o(3);
  TFBIG_4e(4);
  TFBIG_4o(5);
  TFBIG_4e(6);
  TFBIG_4o(7);
  TFBIG_4e(8);
  TFBIG_4o(9);
  TFBIG_4e(10);
  TFBIG_4o(11);
  TFBIG_4e(12);
  TFBIG_4o(13);
  TFBIG_4e(14);
  TFBIG_4o(15);
  TFBIG_4e(16);
  TFBIG_4o(17);
  TFBIG_ADDKEY(p0, p1, p2, p3, p4, p5, p6, p7, h, t, 18);
  h0 = p0 ^ M8;
  h1 = p1 ^ M9;
  h2 = p2;
  h3 = p3;
  h4 = p4;
  h5 = p5;
  h6 = p6;
  h7 = p7;

  // close
  t0 = 8;
  t1 = SPH_C64(0xFF00000000000000);
  t2 = SPH_C64(0xFF00000000000008); // t0 ^ t1;
  h8 = h0 ^ h1 ^ h2 ^ h3 ^ h4 ^ h5 ^ h6 ^ h7 ^ SPH_C64(0x1BD11BDAA9FC1A22);

  p0 = p1 = p2 = p3 = p4 = p5 = p6 = p7 = 0;

  TFBIG_4e(0);
  TFBIG_4o(1);
  TFBIG_4e(2);
  TFBIG_4o(3);
  TFBIG_4e(4);
  TFBIG_4o(5);
  TFBIG_4e(6);
  TFBIG_4o(7);
  TFBIG_4e(8);
  TFBIG_4o(9);
  TFBIG_4e(10);
  TFBIG_4o(11);
  TFBIG_4e(12);
  TFBIG_4o(13);
  TFBIG_4e(14);
  TFBIG_4o(15);
  TFBIG_4e(16);
  TFBIG_4o(17);
  TFBIG_ADDKEY(p0, p1, p2, p3, p4, p5, p6, p7, h, t, 18);

  hash->h8[0] = p0;
  hash->h8[1] = p1;
  hash->h8[2] = p2;
  hash->h8[3] = p3;
  hash->h8[4] = p4;
  hash->h8[5] = p5;
  hash->h8[6] = p6;
  hash->h8[7] = p7;

  //if (!gid) printf("SK80 %02x..%02x\n", (uint) ((uchar*)&p0)[0], (uint) ((uchar*)&p7)[7]);

  barrier(CLK_GLOBAL_MEM_FENCE);
}

__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search1(__global hash_t* hashes)
{
  uint gid = get_global_id(0);
  __global hash_t *hash = &(hashes[gid-get_global_offset(0)]);



  // cubehash.h1

  sph_u32 x0 = SPH_C32(0x2AEA2A61), x1 = SPH_C32(0x50F494D4), x2 = SPH_C32(0x2D538B8B), x3 = SPH_C32(0x4167D83E);
  sph_u32 x4 = SPH_C32(0x3FEE2313), x5 = SPH_C32(0xC701CF8C), x6 = SPH_C32(0xCC39968E), x7 = SPH_C32(0x50AC5695);
  sph_u32 x8 = SPH_C32(0x4D42C787), x9 = SPH_C32(0xA647A8B3), xa = SPH_C32(0x97CF0BEF), xb = SPH_C32(0x825B4537);
  sph_u32 xc = SPH_C32(0xEEF864D2), xd = SPH_C32(0xF22090C4), xe = SPH_C32(0xD0E5CD33), xf = SPH_C32(0xA23911AE);
  sph_u32 xg = SPH_C32(0xFCD398D9), xh = SPH_C32(0x148FE485), xi = SPH_C32(0x1B017BEF), xj = SPH_C32(0xB6444532);
  sph_u32 xk = SPH_C32(0x6A536159), xl = SPH_C32(0x2FF5781C), xm = SPH_C32(0x91FA7934), xn = SPH_C32(0x0DBADEA9);
  sph_u32 xo = SPH_C32(0xD65C8A2B), xp = SPH_C32(0xA5A70E75), xq = SPH_C32(0xB1C62456), xr = SPH_C32(0xBC796576);
  sph_u32 xs = SPH_C32(0x1921C8F7), xt = SPH_C32(0xE7989AF1), xu = SPH_C32(0x7795D246), xv = SPH_C32(0xD43E3B44);

  x0 ^= hash->h4[0];
  x1 ^= hash->h4[1];
  x2 ^= hash->h4[2];
  x3 ^= hash->h4[3];
  x4 ^= hash->h4[4];
  x5 ^= hash->h4[5];
  x6 ^= hash->h4[6];
  x7 ^= hash->h4[7];

  for (int i = 0; i < 13; i ++)
  {
    SIXTEEN_ROUNDS;

    if (i == 0)
    {
      x0 ^= hash->h4[8];
      x1 ^= hash->h4[9];
      x2 ^= hash->h4[10];
      x3 ^= hash->h4[11];
      x4 ^= hash->h4[12];
      x5 ^= hash->h4[13];
      x6 ^= hash->h4[14];
      x7 ^= hash->h4[15];
    }
    else if(i == 1)
      x0 ^= 0x80;
    else if (i == 2)
      xv ^= SPH_C32(1);
  }

  hash->h4[0] = x0;
  hash->h4[1] = x1;
  hash->h4[2] = x2;
  hash->h4[3] = x3;
  hash->h4[4] = x4;
  hash->h4[5] = x5;
  hash->h4[6] = x6;
  hash->h4[7] = x7;
  hash->h4[8] = x8;
  hash->h4[9] = x9;
  hash->h4[10] = xa;
  hash->h4[11] = xb;
  hash->h4[12] = xc;
  hash->h4[13] = xd;
  hash->h4[14] = xe;
  hash->h4[15] = xf;
  //if (!gid) printf("CU %02x..%02x\n", (uint) ((uchar*)&x0)[0], (uint) ((uchar*)&xf)[7]);
  barrier(CLK_GLOBAL_MEM_FENCE);
}

__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search2(__global hash_t* hashes)
{
  uint gid = get_global_id(0);
  uint offset = get_global_offset(0);
  __global hash_t *hash = &(hashes[gid-offset]);

  //mixtab
  __local sph_u32 mixtab0[256], mixtab1[256], mixtab2[256], mixtab3[256];
  int init = get_local_id(0);
  int step = get_local_size(0);
  for (int i = init; i < 256; i += step)
  {
    mixtab0[i] = mixtab0_c[i];
    mixtab1[i] = mixtab1_c[i];
    mixtab2[i] = mixtab2_c[i];
    mixtab3[i] = mixtab3_c[i];
  }
  barrier(CLK_GLOBAL_MEM_FENCE);

  // fugue
  sph_u32 S00, S01, S02, S03, S04, S05, S06, S07, S08, S09;
  sph_u32 S10, S11, S12, S13, S14, S15, S16, S17, S18, S19;
  sph_u32 S20, S21, S22, S23, S24, S25, S26, S27, S28, S29;
  sph_u32 S30, S31, S32, S33, S34, S35;

  ulong fc_bit_count = (sph_u64) 0x200;

  S00 = S01 = S02 = S03 = S04 = S05 = S06 = S07 = S08 = S09 = S10 = S11 = S12 = S13 = S14 = S15 = S16 = S17 = S18 = S19 = 0;
  S20 = SPH_C32(0x8807a57e); S21 = SPH_C32(0xe616af75); S22 = SPH_C32(0xc5d3e4db); S23 = SPH_C32(0xac9ab027);
  S24 = SPH_C32(0xd915f117); S25 = SPH_C32(0xb6eecc54); S26 = SPH_C32(0x06e8020b); S27 = SPH_C32(0x4a92efd1);
  S28 = SPH_C32(0xaac6e2c9); S29 = SPH_C32(0xddb21398); S30 = SPH_C32(0xcae65838); S31 = SPH_C32(0x437f203f);
  S32 = SPH_C32(0x25ea78e7); S33 = SPH_C32(0x951fddd6); S34 = SPH_C32(0xda6ed11d); S35 = SPH_C32(0xe13e3567);

  FUGUE512_3(SWAP4(hash->h4[0x0]), SWAP4(hash->h4[0x1]), SWAP4(hash->h4[0x2]));
  FUGUE512_3(SWAP4(hash->h4[0x3]), SWAP4(hash->h4[0x4]), SWAP4(hash->h4[0x5]));
  FUGUE512_3(SWAP4(hash->h4[0x6]), SWAP4(hash->h4[0x7]), SWAP4(hash->h4[0x8]));
  FUGUE512_3(SWAP4(hash->h4[0x9]), SWAP4(hash->h4[0xA]), SWAP4(hash->h4[0xB]));
  FUGUE512_3(SWAP4(hash->h4[0xC]), SWAP4(hash->h4[0xD]), SWAP4(hash->h4[0xE]));
  FUGUE512_3(SWAP4(hash->h4[0xF]), as_uint2(fc_bit_count).y, as_uint2(fc_bit_count).x);

  // apply round shift if necessary
  int i;

  for (i = 0; i < 32; i ++)
  {
    ROR3;
    CMIX36(S00, S01, S02, S04, S05, S06, S18, S19, S20);
    SMIX(S00, S01, S02, S03);
  }

  for (i = 0; i < 13; i ++)
  {
    S04 ^= S00;
    S09 ^= S00;
    S18 ^= S00;
    S27 ^= S00;
    ROR9;
    SMIX(S00, S01, S02, S03);
    S04 ^= S00;
    S10 ^= S00;
    S18 ^= S00;
    S27 ^= S00;
    ROR9;
    SMIX(S00, S01, S02, S03);
    S04 ^= S00;
    S10 ^= S00;
    S19 ^= S00;
    S27 ^= S00;
    ROR9;
    SMIX(S00, S01, S02, S03);
    S04 ^= S00;
    S10 ^= S00;
    S19 ^= S00;
    S28 ^= S00;
    ROR8;
    SMIX(S00, S01, S02, S03);
  }
  S04 ^= S00;
  S09 ^= S00;
  S18 ^= S00;
  S27 ^= S00;

  hash->h4[0] = SWAP4(S01);
  hash->h4[1] = SWAP4(S02);
  hash->h4[2] = SWAP4(S03);
  hash->h4[3] = SWAP4(S04);
  hash->h4[4] = SWAP4(S09);
  hash->h4[5] = SWAP4(S10);
  hash->h4[6] = SWAP4(S11);
  hash->h4[7] = SWAP4(S12);
  hash->h4[8] = SWAP4(S18);
  hash->h4[9] = SWAP4(S19);
  hash->h4[10] = SWAP4(S20);
  hash->h4[11] = SWAP4(S21);
  hash->h4[12] = SWAP4(S27);
  hash->h4[13] = SWAP4(S28);
  hash->h4[14] = SWAP4(S29);
  hash->h4[15] = SWAP4(S30);

  //if (!gid) printf("FU %02x..%02x\n", (uint) ((uchar*)&S01)[7], (uint) ((uchar*)&S30)[0]);
  barrier(CLK_GLOBAL_MEM_FENCE);
}
__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search3(__global hash_t* hashes, __global uint* output, const ulong target)
{
  uint gid = get_global_id(0);
  __global hash_t *hash = &(hashes[gid-get_global_offset(0)]);

  // Streebog

  __local sph_u64 lT[8][256];

  for(int i=0; i<8; i++) {
    for(int j=0; j<256; j++) lT[i][j] = T[i][j];
  }

  __local unsigned char lCC[12][64];
  __local void*    vCC[12];
  __local sph_u64* sCC[12];

  for(int i=0; i<12; i++) {
    for(int j=0; j<64; j++) lCC[i][j] = CC[i][j];
  }

  for(int i=0; i<12; i++) {
    vCC[i] = lCC[i];
  }
  for(int i=0; i<12; i++) {
    sCC[i] = vCC[i];
  }

  sph_u64 message[8];
  message[0] = (hash->h8[0]);
  message[1] = (hash->h8[1]);
  message[2] = (hash->h8[2]);
  message[3] = (hash->h8[3]);
  message[4] = (hash->h8[4]);
  message[5] = (hash->h8[5]);
  message[6] = (hash->h8[6]);
  message[7] = (hash->h8[7]);

  sph_u64 out[8];
  sph_u64 len = 512;
  GOST_HASH_512(message, len, out);

#if 0
  hash->h8[0] = SWAP8_OUTPUT(out[0]);
  hash->h8[1] = SWAP8_OUTPUT(out[1]);
  hash->h8[2] = SWAP8_OUTPUT(out[2]);
  hash->h8[3] = SWAP8_OUTPUT(out[3]);
  hash->h8[4] = SWAP8_OUTPUT(out[4]);
  hash->h8[5] = SWAP8_OUTPUT(out[5]);
  hash->h8[6] = SWAP8_OUTPUT(out[6]);
  hash->h8[7] = SWAP8_OUTPUT(out[7]);
  //if (!gid) printf("ST %02x..%02x\n", (uint) hash->h1[0], (uint) hash->h1[31]);
#endif

  //if (!gid) printf("ST %02x..%02x\n", (uint) ((uchar*)out)[0], (uint) ((uchar*)out)[31]);

  if (out[3] <= target)
    output[atomic_inc(output+0xFF)] = gid;
}