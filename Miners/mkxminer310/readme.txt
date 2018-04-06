mkxminer: Assembler-optimized Lyra2rev2 miner for AMD GPUs (Vertcoin, Monacoin, Verge, Straks, Shieldcoin, RACE)

!!! Only works with AMD videocards. No NVidia, Intel, CPU or ASICs !!!


=== List of Lyra2rev2 coins
Vertcoin [VTC] - https://bitcointalk.org/index.php?topic=404364.0
Mona [MONA] - https://bitcointalk.org/index.php?topic=392436.0
Verge [XVG] - https://bitcointalk.org/index.php?topic=1365894.0
Straks [STAK] - https://bitcointalk.org/index.php?topic=2433318.0
Shieldcoin [XSH] - https://bitcointalk.org/index.php?topic=2234453.0
RACE - https://bitcointalk.org/index.php?topic=2848766.0
KREDS - https://bitcointalk.org/index.php?topic=2886837.0
Galactrum [ORE] - https://bitcointalk.org/index.php?topic=2576111.0



=== List of recommended pools
stratum+tls://stak.suprnova.cc:7710 (go here to register: https://stak.suprnova.cc/)
stratum+tls://mona.suprnova.cc:3001 (go here to register: https://mona.suprnova.cc/)
stratum+tls://vtc.suprnova.cc:5676 (go here to register: https://vtc.suprnova.cc/)




=== Usage (Windows)
Try running example.cmd (change -u option value to your login and -p option to your password).
If it works ok, then try running best.cmd (it uses assembler kernels).
If it is working, then you may want to tweak some settings, see Options section below.

If you are getting errors about unsupported videocard or if you have an Intel CPU and AMD GPUs, try running example2platforms.cmd.

You can also check out bestfarm.cmd for a useful script, which will name your miners according to their local IP address.

Press 'q' to exit the app.



=== Usage (Linux)
It is recommended to use mkxminer under Windows. But if you have to use Linux, then ./example.sh is your starting point.
Command line parameters are the same for Linux and Windows.

Note: mkxminer is a 32-bit application. So if you are using a 64 bit application, like Ubuntu 16.04 x64, then you need
to install some some required libraries. Execute these commands in a terminal in case you're on Ubuntu x64:
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libstdc++6:i386

If you execute ./mkxminer and it just closes without printing anything, then you don't have 32 bit support (see above).

Error: ./mkxminer: error while loading shared libraries: libOpenCL.so.1: cannot open shared object file: No such file or directory
Reason: You don't have 32bit OpenCL installed. If you added 32 bit support (like written above), you may need to reinstall AMD drivers.

Error: Frontend phase failed compilation.
Error: Compilation from LLVMIR binary to IL text failed!
Reason: the AMD driver is not compatible with mkxminer. Try another driver. You can see AMD GPU-PRO version by executing:
dpkg -l amdgpu-pro

For example, amdgpu-pro-17.40-492261.tar.xz and amdgpu-pro-17.40-483984.tar.xz show this problem on RX480, but work fine on R9 390.

If you have some problems - please report via PM in bitcointalk.

Known issue: once you quit mkxminer, the current terminal window becomes unusable. Close terminal and open a new one.

Press 'q' to exit the app. Do NOT press Ctrl+C or you'll get a zombie process.



=== Options
-o or --url - URL of the stratum server (ex: stratum+tls://stak.suprnova.cc:7710)
    You can currently only specify one pool, no backups supported.
-u or --user - Username for stratum server
-p or --pass -  Password for stratum server
-d or --device - Select device to use, one value, range and/or comma separated (e.g. 0-2,4) default: all
-I or --intensity - Intensity of GPU scanning (23 for high end cards, 20 for low end)
--exitsick - Exit miner if one of GPUs becomes sick (so that you can create a script to restart app / reboot PC)
--asm - Will enable ASM kernels for supported GPUs (Vega, Fiji, Ellesmere, Tonga, Hawaii, Tahiti, Oland currently)
    for about 10% extra speed. Note: this may crash your miner, especially on some Ellesmere cards.
    Recommended 16.10.3 driver or latest AMD / beta blockchain driver.

--platform - Select OpenCL platform ID to use for GPU mining. Default is autodetect.
--engine - GPU engine (over)clock range in Mhz - one value, range and/or comma separated list (e.g. 1050-1100,900,750-850)
--fan - GPU fan percentage range - one value, range and/or comma separated list (e.g. 0-85,100,100). Fan 100% recommended for pro mining.
--map - Map OpenCL to ADL device order manually, paired CSV (e.g. 1:0,2:1 maps OpenCL 1 to ADL 0, 2 to 1)
--memclock - Set the GPU memory (over)clock in Mhz - one value for all or separate by commas for per card
--powertune - Set the GPU powertune percentage - one value for all or separate by commas for per card
--reorder - Attempt to reorder GPU devices according to PCI Bus ID
--vddc - Set the GPU voltage in Volts - one value for all or separate by commas for per card

--auto-fan - Automatically adjust all GPU fan speeds to maintain a target temperature
--auto-gpu - Automatically adjust all GPU engine clock speeds to maintain a target temperature
--temp-cutoff - Temperature which a device will be automatically disabled at, one value or comma separated list
--temp-overheat - Temperature which a device will be throttled at while automanaging fan and/or GPU, one value or comma separated list
--temp-target - Temperature which a device should stay at while automanaging fan and/or GPU, one value or comma separated list



=== Speeds (no overclocking)
Radeon Pro Duo: 84.8MHs (42.4 + 42.4)
FuryX: 55MHs
Vega56: 53MHs
RX 580: 39MHs
RX 480: 36MHs
R9 390: 32MHs
R9 380X: 26MHs
R9 280X: 26MHs

* Note: the actual mining speed is a bit higher as some of the hashrate is used as devfee. The above values are what you (the miner) gets.
Other miners with devfee show you the total hashrate and then you have to reduce it by devfee: for example,
if you have 30MHs with 5% devfee, then effectively it is 28.5MHs for you (30 * (1.0 - 0.05)).
This miner shows you exactly the MHs that you earn, so devfee value is irrelevant.

You do not have to use this miner. For a free open-source option, please use https://miner.nicehash.com/ or https://github.com/sgminer-dev/sgminer.


=== Tweaking
There are pretty much only three things to tweak:
1) Use assembler kernels (add "--asm" parameter to command line). Highly recommended for extra speed, but may require you to install other drivers if you experience crashes.
2) Increase GPU frequency. Memory frequency is not important.
3) Increase intensity. 23 is recommended for 4GB+ videocards.



=== Version history
v1.0.0: 11 November 2017 - Initial nicehash version.
v1.0.1: 12 November 2017 - Added missing DLL and fixed gfx901 problem.
v2.0.0: 5 December 2017 - Rewritten + tls pools supported.
v2.0.1: 12 December 2017 - Added VTC pool, AMD platform autodetection.
v3.0.0: 23 December 2017 - stratum+tcp pools are now supported.
v3.0.1: 9 January 2018 - Fixed problem with pools not supporting extranonce, 'q' to exit, Linux port, cleaned up dlls.
v3.1.0 Linux: 8 February 2018 - Better Linux compatibility and non-TLS/SSL pools supported. Fixed some pool disconnections.
v3.1.0 Windows: 2 April 2018 - Added Vega optimized binary, fixed some pool disconnects.
