[ ENGLISH ]

SOFTWARE PROVIDED AS IS WITH NO WARRANTIES OR ANY RESPONSIBILITY

Lines above for MTP algo for ZCoin

8GB of RAM is MUST HAVE. Same for GPU, 8Gb only cards. 4Gb will be too slow.

Current implementation generate MerkleTree on CPU, that's why good to get fast CPU and put GPU's into x16 PCI-E. Otherwise big rigs(6+ GPU's) will spend lot of time for generating MerkleTree and transferring data into GPU, because pools send lot of new jobs sometimes.

Because of this powerdraw is unstable, while data is transferring to GPU, GPU's running at low powerdraw. If you think this is bad for your hardware - don't use the miner. But there us parameter --mtp-stable-power, which will make miner hash all the time to avoid those jumps, so it can help.



[ RUSSIAN ]

СОФТ ПРЕДОСТАВЛЯЕТСЯ КАК ЕСТЬ БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ И ОТВЕТСТВЕННОСТИ

Текст ниже для алгоритма MTP монеты ZCoin

8Гб оперативной памяти ОБЯЗАТЕЛЬНО. Тоже касается и видеокарт, только 8Гб карты будут работать хорошо. 4Гб в раз десять медленнее.

Текущая реализация генерирует MerkleTree на процессоре, поэтому для наилучших результатов нужен хороший процессор и видеокарты вставленные в x16 PCI-E. Иначе веелики шансы на больших ригах(по 6 карт) тратить много времени на генерацию MerkleTree и обновление данных, т.к. пулы порой часто высылают новую работу.

Из-за этого потребление энергии нестабильно, пока данные отправляются на видеокарты, оные будут работать в режиме энергосбережения, что возможно не очень хорошо для видеокарт. Используйте майнер на свой страх и риск. Так же есть параметр --mtp-stable-power, он заставит майнер постоянно хешировать, что уберёт эти скачки в некоторой степени.