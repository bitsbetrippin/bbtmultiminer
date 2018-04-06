:: Note: May be unstable with intensity -i 21 and above.
:: Set the developer donation percent with --donate. Minimum donation is 1%.
ccminer -a x16r -o [pool url] -u [user] -p [password] -i 19 --donate 1 -N 300
:: -N 300 sets the hashrate to be calculated over the past 300 shares,
:: to get more stable average hashrate for x16r.
