/* Skein2 kernel implementation.
 *
 * ==========================(LICENSE BEGIN)============================
 *
 * Copyright (c) 2016 tpruvot
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

#include "skein.cl"

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
  unsigned short h2[32];
  uint h4[16];
  ulong h8[8];
} hash_t;

#define SWAP8_INPUT(x)   x
#define SWAP8_USELESS(x) x

__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search(__global unsigned char* block, __global hash_t* hashes)
{
  uint gid = get_global_id(0);
  __global hash_t *hash = &(hashes[gid-get_global_offset(0)]);

  // input skein 80

  sph_u64 M0, M1, M2, M3, M4, M5, M6, M7;
  sph_u64 M8, M9;

  M0 = SWAP8_INPUT(DEC64LE(block + 0));
  M1 = SWAP8_INPUT(DEC64LE(block + 8));
  M2 = SWAP8_INPUT(DEC64LE(block + 16));
  M3 = SWAP8_INPUT(DEC64LE(block + 24));
  M4 = SWAP8_INPUT(DEC64LE(block + 32));
  M5 = SWAP8_INPUT(DEC64LE(block + 40));
  M6 = SWAP8_INPUT(DEC64LE(block + 48));
  M7 = SWAP8_INPUT(DEC64LE(block + 56));
  M8 = SWAP8_INPUT(DEC64LE(block + 64));
  M9 = SWAP8_INPUT(DEC64LE(block + 72));
  ((uint*)&M9)[1] = SWAP4(gid);

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

  hash->h8[0] = SWAP8_USELESS(p0);
  hash->h8[1] = SWAP8_USELESS(p1);
  hash->h8[2] = SWAP8_USELESS(p2);
  hash->h8[3] = SWAP8_USELESS(p3);
  hash->h8[4] = SWAP8_USELESS(p4);
  hash->h8[5] = SWAP8_USELESS(p5);
  hash->h8[6] = SWAP8_USELESS(p6);
  hash->h8[7] = SWAP8_USELESS(p7);

  barrier(CLK_GLOBAL_MEM_FENCE);
}

__attribute__((reqd_work_group_size(WORKSIZE, 1, 1)))
__kernel void search1(__global hash_t* hashes, __global uint* output, const ulong target)
{
  uint gid = get_global_id(0);
  __global hash_t *hash = &(hashes[gid-get_global_offset(0)]);

  // skein 64

  sph_u64 h0 = SPH_C64(0x4903ADFF749C51CE);
  sph_u64 h1 = SPH_C64(0x0D95DE399746DF03);
  sph_u64 h2 = SPH_C64(0x8FD1934127C79BCE);
  sph_u64 h3 = SPH_C64(0x9A255629FF352CB1);
  sph_u64 h4 = SPH_C64(0x5DB62599DF6CA7B0);
  sph_u64 h5 = SPH_C64(0xEABE394CA9D5C3F4);
  sph_u64 h6 = SPH_C64(0x991112C71A75B523);
  sph_u64 h7 = SPH_C64(0xAE18A40B660FCC33);

  sph_u64 m0, m1, m2, m3, m4, m5, m6, m7;
  sph_u64 bcount = 0;

  m0 = SWAP8_USELESS(hash->h8[0]);
  m1 = SWAP8_USELESS(hash->h8[1]);
  m2 = SWAP8_USELESS(hash->h8[2]);
  m3 = SWAP8_USELESS(hash->h8[3]);
  m4 = SWAP8_USELESS(hash->h8[4]);
  m5 = SWAP8_USELESS(hash->h8[5]);
  m6 = SWAP8_USELESS(hash->h8[6]);
  m7 = SWAP8_USELESS(hash->h8[7]);

  UBI_BIG(480, 64);

  bcount = 0;
  m0 = m1 = m2 = m3 = m4 = m5 = m6 = m7 = 0;

  UBI_BIG(510, 8);

  if (h3 <= target)
    output[atomic_inc(output+0xFF)] = gid;
}

