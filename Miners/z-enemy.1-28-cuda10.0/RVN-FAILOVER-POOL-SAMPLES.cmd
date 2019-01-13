@echo off
:start

z-enemy -a x16r -o stratum+tcp://ravenminer.com:6666 -u RFQXKVKpHMwyJ86YqQUJSZK1S8m8oRbC5h -p d=16 -i 20 -o stratum+tcp://mine.icemining.ca:3636 -u RFQXKVKpHMwyJ86YqQUJSZK1S8m8oRbC5h -p c=RVN -o stratum+tcp://cryptopool.party:3636 -u RFQXKVKpHMwyJ86YqQUJSZK1S8m8oRbC5h -p d=10

goto start