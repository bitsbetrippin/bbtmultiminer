set address=EXCHANGE_ADDRESS.YOUR_PAYMENT_ID.YOUR_WORKER/YOUR_EMAIL
set pool1=stratum+tcp://pasc-eu1.nanopool.org:15555
set pool2=stratum+tcp://pasc-eu2.nanopool.org:15555
set pool3=stratum+tcp://pasc-asia1.nanopool.org:15555
sgminer.exe -k pascal -o %pool1% -u %address% -p x -o %pool2% -u %address% -p x -o %pool3% -u %address% -p x -I 21 -w 64 -g2 --gpu-platform 0
pause