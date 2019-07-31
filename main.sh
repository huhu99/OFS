# The main function to test the orangefs with fio
#
# set alias for this script
# alias empty_env='rm /mnt/test.* ~/test.*'
# init results.txt file
# rm ~/results.txt
#
# Change directory into the root directory, files for FIO test would be generated here, which
# would be defaultly deleted after every test, however, if you have needs for multiple tests, 
# it is not necessary to deleted them every test, please comment optionally
cd ~
# init test name
tsnm="test"
#
# test 1
# empty_env
tsnm="test_1"
batch='16k'
io_t='readwrite'
io_s='10G'
IO_type_array = ("readwrite", "readwrite", "readwrite", "readwrite", \
				"readwrite", "readwrite", "readwrite", "readwrite", \
				"readwrite", "readwrite", "readwrite", "readwrite", \
				"readwrite", "readwrite", "readwrite", "readwrite", \
				"read", "write", "randread", "randwrite", \
				"readwrite", "randrw")
Block_size_array = ("16K", "16K", "16K", "16K", \
					"16K", "16K", "16K", "16K", \
					"1K", "2K", "4K", "8K", \
					"16K", "32K", "64K", "128K", \
					"16K", "16K", "16K", "16K", \
					"16K", "16K")
IO_size_array = ("128M", "512M", "1G", "2G", \
				"3G", "4G", "5G", "10G", \
				"1G", "1G", "1G", "1G", \
				"1G", "1G", "1G", "1G", \
				"1G", "1G", "1G", "1G", \
				"1G", "1G")
for test_id in {1..22}
do
	batch = Block_size_array[test_id]
	io_t = IO_type_array[test_id]
	io_s = IO_size_array[test_id]
	result = "test_${test_id}"
	echo "================== ${result} begins, i/o type ${batch}; batchsize ${batch}; i/o size ${io_s};  ===================" | tee -a ~/results.txt
	fio -direct=1 -iodepth 1 -thread  -ioengine=psync -rw=${io_t} -bs=${batch} -io_size=${io_s} -size=512M -numjobs=10 -runtime=60 -group_reporting  -fallocate=none -name=${result} -directory=/mnt/orangefs | tee -a ~/${result}.txt
done
# empty_env
# the following line is to delete the files generated for FIO test, which are too space consuming
# for speeding up, you can comment the following line of code optionally
rm ~/${tsnm}.*
#
#
# unalias
# unalias empty_env
