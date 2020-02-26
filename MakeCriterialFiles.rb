require 'prawn'

# files = %w[03_501_CRYT 03_537_CRYT 03_719_CRYT 09_711-715_CRYT 11_expert_info 03_502_CRYT 03_538_CRYT 03_720_CRYT 09_711-715_DOP_39 13_501-505_CRYT 03_503_CRYT 03_539_CRYT 03_721_CRYT 09_991_CRYT 13_501-505_DOP_39 03_504_CRYT 03_540_CRYT 03_722_CRYT 09_991_DOP_39 13_506-510_CRYT 03_505_CRYT 03_541_CRYT 03_723_CRYT 09_CRYT 13_506-510_DOP_39 03_506_CRYT 03_542_CRYT 03_724_CRYT 09_DOP_40 13_511-515_CRYT 03_507_CRYT 03_543_CRYT 03_725_CRYT 09_expert_info 13_511-515_DOP_39 03_508_CRYT 03_544_CRYT 03_726_CRYT 10_501-505_CRYT 13_701-705_CRYT 03_509_CRYT 03_545_CRYT 03_727_CRYT 10_501-505_DOP_39 13_701-705_DOP_39 03_510_CRYT 03_546_CRYT 03_728_CRYT 10_506-510_CRYT 13_706-710_CRYT 03_511_CRYT 03_547_CRYT 03_729_CRYT 10_506-510_DOP_39 13_706-710_DOP_39 03_512_CRYT 03_548_CRYT 03_730_CRYT 10_511-515_CRYT 13_711-715_CRYT 03_513_CRYT 03_549_CRYT 03_731_CRYT 10_511-515_DOP_39 13_711-715_DOP_39 03_514_CRYT 03_550_CRYT 03_732_CRYT 10_701-705_CRYT 13_CRYT 03_515_CRYT 03_551_CRYT 03_733_CRYT 10_701-705_DOP_39 13_DOP_40 03_516_CRYT 03_552_CRYT 03_734_CRYT 10_706-710_CRYT 13_expert_info 03_517_CRYT 03_553_CRYT 03_735_CRYT 10_706-710_DOP_39 03_518_CRYT 03_554_CRYT 03_736_CRYT 10_711-715_CRYT 03_519_CRYT 03_701_CRYT 03_991_CRYT 10_711-715_DOP_39 03_520_CRYT 03_702_CRYT 03_expert_info 10_CRYT 03_521_CRYT 03_703_CRYT 09_501-505_CRYT 10_DOP_40 03_522_CRYT 03_704_CRYT 09_501-505_DOP_39 10_expert_info 03_523_CRYT 03_705_CRYT 09_506-510_CRYT 11_501-505_CRYT 03_524_CRYT 03_706_CRYT 09_506-510_DOP_39 11_501-505_DOP_39 03_525_CRYT  03_707_CRYT 09_511-515_CRYT 11_506-510_CRYT 03_526_CRYT 03_708_CRYT 09_511-515_DOP_39 11_506-510_DOP_39 03_527_CRYT 03_709_CRYT 09_516-520_CRYT 11_511-515_CRYT 03_528_CRYT 03_710_CRYT 09_516-520_DOP_39 11_511-515_DOP_39 03_529_CRYT 03_711_CRYT 09_521-525_CRYT 11_701-705_CRYT 03_530_CRYT 03_712_CRYT 09_521-525_DOP_39 11_701-705_DOP_39 03_531_CRYT 03_713_CRYT 09_526-530_CRYT 11_706-710_CRYT 03_532_CRYT 03_714_CRYT 09_526-530_DOP_39 11_706-710_DOP_39 03_533_CRYT 03_715_CRYT 09_701-705_CRYT 11_711-715_CRYT 03_534_CRYT 03_716_CRYT 09_701-705_DOP_39 11_711-715_DOP_39 03_535_CRYT  03_717_CRYT 09_706-710_CRYT 11_CRYT 03_536_CRYT 03_718_CRYT 09_706-710_DOP_39 11_DOP_40]

# files = %w[
# 03_401_CRYT
# 03_402_CRYT
# 03_403_CRYT
# 03_404_CRYT
# 03_405_CRYT
# 03_406_CRYT
# 03_407_CRYT
# 03_408_CRYT
# 03_409_CRYT
# 03_410_CRYT
# 03_411_CRYT
# 03_412_CRYT
# 03_413_CRYT
# 03_414_CRYT
# 03_415_CRYT
# 03_416_CRYT
# 03_417_CRYT
# 03_418_CRYT
# 03_419_CRYT
# 03_420_CRYT
# 03_421_CRYT
# 03_422_CRYT
# 03_423_CRYT
# 03_424_CRYT
# 03_425_CRYT
# 03_426_CRYT
# 03_427_CRYT
# 03_428_CRYT
# 03_429_CRYT
# 03_430_CRYT
# 03_431_CRYT
# 03_432_CRYT
# 03_433_CRYT
# 03_434_CRYT
# 03_435_CRYT
# 03_436_CRYT
# 03_437_CRYT
# 03_438_CRYT
# 03_439_CRYT
# 03_440_CRYT
# 03_441_CRYT
# 03_442_CRYT
# 03_443_CRYT
# 03_444_CRYT
# 03_445_CRYT
# 03_501_CRYT
# 03_502_CRYT
# 03_503_CRYT
# 03_504_CRYT
# 03_505_CRYT
# 03_506_CRYT
# 03_507_CRYT
# 03_508_CRYT
# 03_509_CRYT
# 03_510_CRYT
# 03_511_CRYT
# 03_512_CRYT
# 03_513_CRYT
# 03_514_CRYT
# 03_515_CRYT
# 03_516_CRYT
# 03_517_CRYT
# 03_518_CRYT
# 03_519_CRYT
# 03_520_CRYT
# 03_521_CRYT
# 03_522_CRYT
# 03_523_CRYT
# 03_524_CRYT
# 03_525_CRYT
# 03_526_CRYT
# 03_527_CRYT
# 03_528_CRYT
# 03_529_CRYT
# 03_530_CRYT
# 03_991_CRYT
# 03_expert_info
# 04_401_CRYT
# 04_402_CRYT
# 04_403_CRYT
# 04_404_CRYT
# 04_405_CRYT
# 04_406_CRYT
# 04_407_CRYT
# 04_408_CRYT
# 04_409_CRYT
# 04_410_CRYT
# 04_411_CRYT
# 04_412_CRYT
# 04_413_CRYT
# 04_414_CRYT
# 04_415_CRYT
# 04_416_CRYT
# 04_417_CRYT
# 04_418_CRYT
# 04_419_CRYT
# 04_420_CRYT
# 04_421_CRYT
# 04_422_CRYT
# 04_423_CRYT
# 04_424_CRYT
# 04_425_CRYT
# 04_426_CRYT
# 04_427_CRYT
# 04_428_CRYT
# 04_429_CRYT
# 04_430_CRYT
# 04_431_CRYT
# 04_432_CRYT
# 04_433_CRYT
# 04_434_CRYT
# 04_435_CRYT
# 04_436_CRYT
# 04_437_CRYT
# 04_438_CRYT
# 04_439_CRYT
# 04_440_CRYT
# 04_441_CRYT
# 04_442_CRYT
# 04_443_CRYT
# 04_444_CRYT
# 04_445_CRYT
# 04_501_CRYT
# 04_502_CRYT
# 04_503_CRYT
# 04_504_CRYT
# 04_505_CRYT
# 04_506_CRYT
# 04_507_CRYT
# 04_508_CRYT
# 04_509_CRYT
# 04_510_CRYT
# 04_511_CRYT
# 04_512_CRYT
# 04_513_CRYT
# 04_514_CRYT
# 04_515_CRYT
# 04_516_CRYT
# 04_517_CRYT
# 04_518_CRYT
# 04_519_CRYT
# 04_520_CRYT
# 04_521_CRYT
# 04_522_CRYT
# 04_523_CRYT
# 04_524_CRYT
# 04_525_CRYT
# 04_526_CRYT
# 04_527_CRYT
# 04_528_CRYT
# 04_529_CRYT
# 04_530_CRYT
# 04_991_CRYT
# 04_expert_info
# ]

files = %w[
01_701_CRYT
01_702_CRYT
01_703_CRYT
01_704_CRYT
01_705_CRYT
01_706_CRYT
01_707_CRYT
01_708_CRYT
01_709_CRYT
01_710_CRYT
01_711_CRYT
01_712_CRYT
01_993_CRYT
01_CRYT
01_expert_info
02_701_CRYT
02_702_CRYT
02_703_CRYT
02_704_CRYT
02_705_CRYT
02_706_CRYT
02_707_CRYT
02_708_CRYT
02_709_CRYT
02_710_CRYT
02_711_CRYT
02_712_CRYT
02_993_CRYT
02_expert_info
03_701_CRYT
03_702_CRYT
03_703_CRYT
03_704_CRYT
03_705_CRYT
03_706_CRYT
03_707_CRYT
03_708_CRYT
03_709_CRYT
03_710_CRYT
03_711_CRYT
03_712_CRYT
03_expert_info
04_701_CRYT
04_702_CRYT
04_703_CRYT
04_704_CRYT
04_705_CRYT
04_706_CRYT
04_707_CRYT
04_708_CRYT
04_703_CRYT
04_709_CRYT
04_710_CRYT
04_711_CRYT
04_712_cRYT
04_expert_info
05_701_CRYT
05_702_CRYT
05_703_CRYT
05_704_CRYT
05_705_CRYT
05_706_CRYT
05_707_CRYT
05_708_CRYT
05_709_CRYT
05_710_CRYT
05_711_CRYT
05_712_CRYT
05_993_CRYT
05_expert_info
06_701_CRYT
06_702_CRYT
06_703_CRYT
06_704_CRYT
06_705_CRYT
06_706_CRYT
06_707_CRYT
06_708_CRYT
06_709_CRYT
06_710_CRYT
06_711_CRYT
06_712_CRYT
06_993_CRYT
06_expert_1nfo
07_701_CRYT
07_702_CRYT
07_703_CRYT
07_704_CRYT
07_705_CRYT
07_706_CRYT
07_707_CRYT
07_708_CRYT
07_709_CRYT
07_710_CRYT
07_711_CRYT
07_712_CRYT
07_993_CRYT
07_expert_info
08_701_CRYT
08_702_CRYT
08_703_CRYT
08_704_CRYT
08_705_CRYT
08_706_CRYT
08_707_CRYT
08_708_CRYT
08_709_CRYT
08_710_CRYT
08_711_CRYT
08_712_CRYT
08_expert_info
09_701-702_CRYT
09_701-702_DOP_39
09_703-704_CRYT
09_703-704_DOP_39
09_993_CRYT
09_993_DOP_39
09_CRYT
09_DOP_40
09_expert_info
10_701-702_CRYT
10_701-702_DOP_39
10_703-704_CRYT
10_703-704_DOP_39
10_CRYT
10_DOP_40
10_expert_info
11_701_CRYT
11_701_DOP_39
11_702_CRYT
11_702_DOP_39
11_CRYT
11_DOP_40
11_expert_info
12_701_CRYT
12_702_CRYT
12_703_CRYT
12_704_CRYT
12_705_CRYT
12_706_CRYT
12_707_CRYT
12_708_CRYT
12_709_CRYT
12_710_CRYT
12_711_CRYT
12_712_CRYT
12_993_CRYT
12_expert_info
13_701_CRYT
13_701_DOP_39
13_702_CRYT
13_702_DOP_39
13_CRYT
13_DOP_40
13_expert_info
18_701_CRYT
18_702_CRYT
18_703_CRYT
18_704_CRYT
18_705_CRYT
18_706_CRYT
18_707_CRYT
18_708_CRYT
18_709_CRYT
18_710_CRYT
18_711_CRYT
18_712_CRYT
18_992_CRYT
18_expert_info
29_701_CRYT
29_702_CRYT
29_CRYT
29_DOP_1
29_DOP_2
29_DOP_3
29_DOP_4
29_expert_info
30_701_CRYT
30_702_CRYT
30_CRYT
30_DOP_1
30_DOP_2
30_DOP_3
30_DOP_4
30_expert_info
31_701_CRYT
31_702_CRYT
31_CRYT
31_DOP_1
31_DOP_2
31_DOP_3
31_DOP_4
31_expert_info
33_701_CRYT
33_702_CRYT
33_CRYT
33_DOP_1
33_DOP_2
33_DOP_3
33_DOP_4
33_expert_info
]

pdfText = "Hello, Criteries!"

criteriesPath = 'D:/data/Пример критериев/2016_06_30-03-09-10-11-13'

files.each do |f|
    fullPath = File.join(criteriesPath, f)
    fullPath += '.pdf'
    Prawn::Document.generate fullPath do |pdf|
        pdf.text pdfText
    end
end