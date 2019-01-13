// skein256 kernel
// Based on cuda implementation from the ccminer project(Provos Alexis, Tanguy Pruvot and others).
// OpenCL port and AMDGCN specific optimizations were done by CryptoGraphics ( CrGraphics@protonmail.com ).

#define ROTR64(x, n) ((n) < 32 ? (amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n)) | ((ulong)amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n)) << 32)) : (amd_bitalign((uint)(x), (uint)((x) >> 32), (uint)(n) - 32) | ((ulong)amd_bitalign((uint)((x) >> 32), (uint)(x), (uint)(n) - 32) << 32)))

#define TFBIGMIX8e(){\
        p0+=p1;p2+=p3;p4+=p5;p6+=p7;p1=ROTR64(p1,18) ^ p0;p3=ROTR64(p3,28) ^ p2;p5=ROTR64(p5,45) ^ p4;p7=ROTR64(p7,27) ^ p6;\
        p2+=p1;p4+=p7;p6+=p5;p0+=p3;p1=ROTR64(p1,31) ^ p2;p7=ROTR64(p7,37) ^ p4;p5=ROTR64(p5,50) ^ p6;p3=ROTR64(p3,22) ^ p0;\
        p4+=p1;p6+=p3;p0+=p5;p2+=p7;p1=ROTR64(p1,47) ^ p4;p3=ROTR64(p3,15) ^ p6;p5=ROTR64(p5,28) ^ p0;p7=ROTR64(p7,25) ^ p2;\
        p6+=p1;p0+=p7;p2+=p5;p4+=p3;p1=ROTR64(p1,20) ^ p6;p7=ROTR64(p7,55) ^ p0;p5=ROTR64(p5,10) ^ p2;p3=ROTR64(p3,8) ^ p4;\
}

#define TFBIGMIX8o(){\
        p0+=p1;p2+=p3;p4+=p5;p6+=p7;p1=ROTR64(p1,25) ^ p0;p3=ROTR64(p3,34) ^ p2;p5=ROTR64(p5,30) ^ p4;p7=ROTR64(p7,40) ^ p6;\
        p2+=p1;p4+=p7;p6+=p5;p0+=p3;p1=ROTR64(p1,51) ^ p2;p7=ROTR64(p7,14) ^ p4;p5=ROTR64(p5,54) ^ p6;p3=ROTR64(p3,47) ^ p0;\
        p4+=p1;p6+=p3;p0+=p5;p2+=p7;p1=ROTR64(p1,39) ^ p4;p3=ROTR64(p3,35) ^ p6;p5=ROTR64(p5,25) ^ p0;p7=ROTR64(p7,21) ^ p2;\
        p6+=p1;p0+=p7;p2+=p5;p4+=p3;p1=ROTR64(p1,56) ^ p6;p7=ROTR64(p7,29) ^ p0;p5=ROTR64(p5, 8) ^ p2;p3=ROTR64(p3,42) ^ p4;\
}


typedef union {
    uint h[8];
    ulong h2[4];
    uint4 h4[2];
    ulong4 h8;
} hash_t;


__attribute__((reqd_work_group_size(256, 1, 1)))
__kernel void skein(__global uint* hashes)
{
    int gid = get_global_id(0);
    
    __global hash_t *hash = (__global hash_t *)(hashes + (8* (get_global_id(0))));

    ulong c_t2[ 3] = { 0x08UL, 0xff00000000000000UL, 0xff00000000000008UL};
    uint c_add[18] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18};

    const ulong skein_ks_parity64 = 0x1BD11BDAA9FC1A22UL;

    const ulong c_sk_buf[47] = {
    13044065891108841470UL, 16732438526841956843UL, 9211558909664101194UL, 3037510430686418139UL,
    7173443257738815378UL, 6810081552185354780UL, 6350514869477290861UL, 15423083618897915945UL,
    1670450383176356210UL, 14355246811875535630UL, 12929758634773762437UL, 13158740742618369579UL,
    3381563508338326579UL, 14758371437976436245UL, 13158740742618369610UL, 16732438526841956846UL,
    13605449933369589267UL, 6174048478977683059UL, 15579517022235109899UL, 3037510430686418144UL,
    6174048478977683087UL, 17007283647522109065UL, 1884588926079571163UL, 16691526376334058072UL,
    15854362142915262115UL, 14082680139380609421UL, 16691526376334058097UL, 4534485012945173532UL,
    12929758634773762437UL, 13158740742618369588UL, 3381563508338326579UL, 14758371437976436254UL,
    13158740742618369610UL, 16732438526841956855UL, 13605449933369589267UL, 6174048478977683068UL,
    15579517022235109899UL, 3037510430686418153UL, 6174048478977683087UL, 17007283647522109074UL,
    1884588926079571163UL, 16691526376334058081UL, 15854362142915262115UL, 14082680139380609430UL,
    16691526376334058097UL, 4534485012945173541UL, 12929758634773762437UL};

    // load data
    const ulong dt0 = hash->h2[0];
    const ulong dt1 = hash->h2[1];
    const ulong dt2 = hash->h2[2];
    const ulong dt3 = hash->h2[3];

    ulong h[ 9] = {
            0xCCD044A12FDB3E13UL, 0xE83590301A79A9EBUL, 0x55AEA0614F816E6FUL, 0x2A2767A4AE9B94DBUL,
            0xEC06025E74DD7683UL, 0xE7A436CDC4746251UL, 0xC36FBAF9393AD185UL, 0x3EEDBA1833EDFC13UL,
            0xb69d3cfcc73a4e2aUL, // skein_ks_parity64 ^ h[0..7]
    };

    int i=0;

    ulong p0 = c_sk_buf[0] + dt0 + dt1;
    ulong p1 = c_sk_buf[1] + dt1;
    ulong p2 = c_sk_buf[2] + dt2 + dt3;
    ulong p3 = c_sk_buf[3] + dt3;
    ulong p4 = c_sk_buf[4];
    ulong p5 = c_sk_buf[5];
    ulong p6 = c_sk_buf[6];
    ulong p7 = c_sk_buf[7];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 1);
    //      TFBIGMIX8e();
    p1=ROTR64(p1,18) ^ p0;
    p3=ROTR64(p3,28) ^ p2;
    p2+=p1;
    p0+=p3;
    p1=ROTR64(p1,31) ^ p2;
    p3=ROTR64(p3,22) ^ p0;
    p4+=p1;
    p6+=p3;
    p0+=p5;
    p2+=p7;
    p1=ROTR64(p1,47) ^ p4;
    p3=ROTR64(p3,15) ^ p6;
    p5=c_sk_buf[8] ^ p0;
    p7=c_sk_buf[9] ^ p2;
    p6+=p1;
    p0+=p7;
    p2+=p5;
    p4+=p3;
    p1=ROTR64(p1,20) ^ p6;
    p7=ROTR64(p7,55) ^ p0;
    p5=ROTR64(p5,10) ^ p2;
    p3=ROTR64(p3,8) ^ p4;

    p0+=h[ 1];        p1+=h[ 2];
    p2+=h[ 3];        p3+=h[ 4];
    p4+=h[ 5];        p5+=c_sk_buf[10];
    p7+=c_sk_buf[11]; p6+=c_sk_buf[12];

    TFBIGMIX8o();

    p0+=h[ 2];      p1+=h[ 3];
    p2+=h[ 4];      p3+=h[ 5];
    p4+=h[ 6];      p5+=c_sk_buf[12];
    p7+=c_sk_buf[13]; p6+=c_sk_buf[14];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 3);
    TFBIGMIX8e();

    p0+=h[ 3];      p1+=h[ 4];
    p2+=h[ 5];      p3+=h[ 6];
    p4+=h[ 7];      p5+=c_sk_buf[14];
    p7+=c_sk_buf[15];   p6+=c_sk_buf[16];

    TFBIGMIX8o();

    p0+=h[ 4];      p1+=h[ 5];
    p2+=h[ 6];      p3+=h[ 7];
    p4+=h[ 8];      p5+=c_sk_buf[16];
    p7+=c_sk_buf[17];   p6+=c_sk_buf[18];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 5);
    TFBIGMIX8e();

    p0+=h[ 5];      p1+=h[ 6];
    p2+=h[ 7];      p3+=h[ 8];
    p4+=h[ 0];      p5+=c_sk_buf[18];
    p7+=c_sk_buf[19];   p6+=c_sk_buf[20];

    TFBIGMIX8o();

    p0+=h[ 6];      p1+=h[ 7];
    p2+=h[ 8];      p3+=h[ 0];
    p4+=h[ 1];      p5+=c_sk_buf[20];
    p7+=c_sk_buf[21];   p6+=c_sk_buf[22];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 7);
    TFBIGMIX8e();

    p0+=h[ 7];      p1+=h[ 8];
    p2+=h[ 0];      p3+=h[ 1];
    p4+=h[ 2];      p5+=c_sk_buf[22];
    p7+=c_sk_buf[23];   p6+=c_sk_buf[24];

    TFBIGMIX8o();

    p0+=h[ 8];      p1+=h[ 0];
    p2+=h[ 1];      p3+=h[ 2];
    p4+=h[ 3];      p5+=c_sk_buf[24];
    p7+=c_sk_buf[25];   p6+=c_sk_buf[26];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 9);
    TFBIGMIX8e();

    p0+=h[ 0];      p1+=h[ 1];
    p2+=h[ 2];      p3+=h[ 3];
    p4+=h[ 4];      p5+=c_sk_buf[26];
    p7+=c_sk_buf[27];   p6+=c_sk_buf[28];

    TFBIGMIX8o();

    p0+=h[ 1];      p1+=h[ 2];
    p2+=h[ 3];      p3+=h[ 4];
    p4+=h[ 5];      p5+=c_sk_buf[28];
    p7+=c_sk_buf[29];   p6+=c_sk_buf[30];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,11);
    TFBIGMIX8e();

    p0+=h[ 2];      p1+=h[ 3];
    p2+=h[ 4];      p3+=h[ 5];
    p4+=h[ 6];      p5+=c_sk_buf[30];
    p7+=c_sk_buf[31];   p6+=c_sk_buf[32];

    TFBIGMIX8o();

    p0+=h[ 3];      p1+=h[ 4];
    p2+=h[ 5];      p3+=h[ 6];
    p4+=h[ 7];      p5+=c_sk_buf[32];
    p7+=c_sk_buf[33];   p6+=c_sk_buf[34];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,13);
    TFBIGMIX8e();

    p0+=h[ 4];      p1+=h[ 5];
    p2+=h[ 6];      p3+=h[ 7];
    p4+=h[ 8];      p5+=c_sk_buf[34];
    p7+=c_sk_buf[35];   p6+=c_sk_buf[36];

    TFBIGMIX8o();

    p0+=h[ 5];      p1+=h[ 6];
    p2+=h[ 7];      p3+=h[ 8];
    p4+=h[ 0];      p5+=c_sk_buf[36];
    p7+=c_sk_buf[37];   p6+=c_sk_buf[38];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,15);
    TFBIGMIX8e();

    p0+=h[ 6];      p1+=h[ 7];
    p2+=h[ 8];      p3+=h[ 0];
    p4+=h[ 1];      p5+=c_sk_buf[38];
    p7+=c_sk_buf[39];   p6+=c_sk_buf[40];

    TFBIGMIX8o();

    p0+=h[ 7];      p1+=h[ 8];
    p2+=h[ 0];      p3+=h[ 1];
    p4+=h[ 2];      p5+=c_sk_buf[40];
    p7+=c_sk_buf[41];   p6+=c_sk_buf[42];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,17);
    TFBIGMIX8e();

    p0+=h[ 8];      p1+=h[ 0];
    p2+=h[ 1];      p3+=h[ 2];
    p4+=h[ 3];      p5+=c_sk_buf[42];
    p7+=c_sk_buf[43];   p6+=c_sk_buf[44];
    

    TFBIGMIX8o();
    p4+=h[ 4];
    p5+=c_sk_buf[44];
    p7+=c_sk_buf[45];
    p6+=c_sk_buf[46];
    
    p0 = (p0+h[ 0]) ^ dt0;
    p1 = (p1+h[ 1]) ^ dt1;
    p2 = (p2+h[ 2]) ^ dt2;
    p3 = (p3+h[ 3]) ^ dt3;

    h[0] = p0;
    h[1] = p1;
    h[2] = p2;
    h[3] = p3;
    h[4] = p4;
    h[5] = p5;
    h[6] = p6;
    h[7] = p7;
    h[8] = h[ 0] ^ h[ 1] ^ h[ 2] ^ h[ 3] ^ h[ 4] ^ h[ 5] ^ h[ 6] ^ h[ 7] ^ skein_ks_parity64;

    p5+=c_t2[0];  //p5 already equal h[5]
    p6+=c_t2[1];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 1);
    TFBIGMIX8e();

    p0+=h[ 1];      p1+=h[ 2];
    p2+=h[ 3];      p3+=h[ 4];
    p4+=h[ 5];      p5+=h[ 6] + c_t2[ 1];
    p6+=h[ 7] + c_t2[ 2];   p7+=h[ 8] + c_add[ 0];

    TFBIGMIX8o();

    p0+=h[ 2];      p1+=h[ 3];
    p2+=h[ 4];      p3+=h[ 5];
    p4+=h[ 6];      p5+=h[ 7] + c_t2[ 2];
    p6+=h[ 8] + c_t2[ 0];   p7+=h[ 0] + c_add[ 1];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 3);
    TFBIGMIX8e();

    p0+=h[ 3];      p1+=h[ 4];
    p2+=h[ 5];      p3+=h[ 6];
    p4+=h[ 7];      p5+=h[ 8] + c_t2[ 0];
    p6+=h[ 0] + c_t2[ 1];   p7+=h[ 1] + c_add[ 2];

    TFBIGMIX8o();

    p0+=h[ 4];      p1+=h[ 5];
    p2+=h[ 6];      p3+=h[ 7];
    p4+=h[ 8];      p5+=h[ 0] + c_t2[ 1];
    p6+=h[ 1] + c_t2[ 2];   p7+=h[ 2] + c_add[ 3];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 5);
    TFBIGMIX8e();

    p0+=h[ 5];      p1+=h[ 6];
    p2+=h[ 7];      p3+=h[ 8];
    p4+=h[ 0];      p5+=h[ 1] + c_t2[ 2];
    p6+=h[ 2] + c_t2[ 0];   p7+=h[ 3] + c_add[ 4];

    TFBIGMIX8o();

    p0+=h[ 6];      p1+=h[ 7];
    p2+=h[ 8];      p3+=h[ 0];
    p4+=h[ 1];      p5+=h[ 2] + c_t2[ 0];
    p6+=h[ 3] + c_t2[ 1];   p7+=h[ 4] + c_add[ 5];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 7);
    TFBIGMIX8e();

    p0+=h[ 7];      p1+=h[ 8];
    p2+=h[ 0];      p3+=h[ 1];
    p4+=h[ 2];      p5+=h[ 3] + c_t2[ 1];
    p6+=h[ 4] + c_t2[ 2];   p7+=h[ 5] + c_add[ 6];

    TFBIGMIX8o();

    p0+=h[ 8];      p1+=h[ 0];
    p2+=h[ 1];      p3+=h[ 2];
    p4+=h[ 3];      p5+=h[ 4] + c_t2[ 2];
    p6+=h[ 5] + c_t2[ 0];   p7+=h[ 6] + c_add[ 7];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7, 9);
    TFBIGMIX8e();

    p0+=h[ 0];      p1+=h[ 1];
    p2+=h[ 2];      p3+=h[ 3];
    p4+=h[ 4];      p5+=h[ 5] + c_t2[ 0];
    p6+=h[ 6] + c_t2[ 1];   p7+=h[ 7] + c_add[ 8];

    TFBIGMIX8o();

    p0+=h[ 1];      p1+=h[ 2];
    p2+=h[ 3];      p3+=h[ 4];
    p4+=h[ 5];      p5+=h[ 6] + c_t2[ 1];
    p6+=h[ 7] + c_t2[ 2];   p7+=h[ 8] + c_add[ 9];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,11);
    TFBIGMIX8e();

    p0+=h[ 2];      p1+=h[ 3];
    p2+=h[ 4];      p3+=h[ 5];
    p4+=h[ 6];      p5+=h[ 7] + c_t2[ 2];
    p6+=h[ 8] + c_t2[ 0];   p7+=h[ 0] + c_add[10];

    TFBIGMIX8o();

    p0+=h[ 3];      p1+=h[ 4];
    p2+=h[ 5];      p3+=h[ 6];
    p4+=h[ 7];      p5+=h[ 8] + c_t2[ 0];
    p6+=h[ 0] + c_t2[ 1];   p7+=h[ 1] + c_add[11];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,13);
    TFBIGMIX8e();

    p0+=h[ 4];      p1+=h[ 5];
    p2+=h[ 6];      p3+=h[ 7];
    p4+=h[ 8];      p5+=h[ 0] + c_t2[ 1];
    p6+=h[ 1] + c_t2[ 2];   p7+=h[ 2] + c_add[12];

    TFBIGMIX8o();

    p0+=h[ 5];      p1+=h[ 6];
    p2+=h[ 7];      p3+=h[ 8];
    p4+=h[ 0];      p5+=h[ 1] + c_t2[ 2];
    p6+=h[ 2] + c_t2[ 0];   p7+=h[ 3] + c_add[13];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,15);
    TFBIGMIX8e();

    p0+=h[ 6];      p1+=h[ 7];
    p2+=h[ 8];      p3+=h[ 0];
    p4+=h[ 1];      p5+=h[ 2] + c_t2[ 0];
    p6+=h[ 3] + c_t2[ 1];   p7+=h[ 4] + c_add[14];

    TFBIGMIX8o();

    p0+=h[ 7];      p1+=h[ 8];
    p2+=h[ 0];      p3+=h[ 1];
    p4+=h[ 2];      p5+=h[ 3] + c_t2[ 1];
    p6+=h[ 4] + c_t2[ 2];   p7+=h[ 5] + c_add[15];

    //      Round_8_512v30(h, t, p0, p1, p2, p3, p4, p5, p6, p7,17);    
    TFBIGMIX8e();

    p0+=h[ 8];      p1+=h[ 0];
    p2+=h[ 1];      p3+=h[ 2];
    p4+=h[ 3];      p5+=h[ 4] + c_t2[ 2];
    p6+=h[ 5] + c_t2[ 0];   p7+=h[ 6] + c_add[16];

    TFBIGMIX8o();

    p0+=h[ 0];      p1+=h[ 1];
    p2+=h[ 2];      p3+=h[ 3];
    p4+=h[ 4];      p5+=h[ 5] + c_t2[ 0];
    p6+=h[ 6] + c_t2[ 1]; p7+=h[ 7] + c_add[17];

    hash->h2[0] = p0;
    hash->h2[1] = p1;
    hash->h2[2] = p2;
    hash->h2[3] = p3;

    barrier(CLK_LOCAL_MEM_FENCE);
}
