# Include shared configuration
include ../common.mk

# Benchmark-specific configuration
RUNS   ?= 10
WARMUP ?= 2

LFI        = /home/zheng/.clang
LFI_STORES = /home/zheng/.clang
NATIVE     = /home/zheng/.clang

TARGET_DIR := libvpx

all: bench

$(TARGET_DIR):
	git clone https://github.com/webmproject/libvpx

build-lfi: $(TARGET_DIR)
	mkdir -p build-lfi
	cd build-lfi && CXXFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11" LDFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11" AR=$(LFI)/bin/llvm-ar CC=$(LFI)/bin/clang CXX=$(LFI)/bin/clang++ ../$(TARGET_DIR)/configure
	make -C build-lfi -j $(JOBS)

build-lfi-stores: $(TARGET_DIR)
	mkdir -p build-lfi-stores
	cd build-lfi-stores && CXXFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11" LDFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11" AR=$(LFI_STORES)/bin/llvm-ar CC=$(LFI_STORES)/bin/clang CXX=$(LFI_STORES)/bin/clang++ ../$(TARGET_DIR)/configure
	make -C build-lfi-stores -j $(JOBS)

build-native: $(TARGET_DIR)
	mkdir -p build-native
	cd build-native && CFLAGS="-fsanitize=signed-integer-overflow,unsigned-integer-overflow -fsanitize-hw-support=0" CXXFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11 -fsanitize=signed-integer-overflow,unsigned-integer-overflow -fsanitize-hw-support=0" LDFLAGS="--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11 -fsanitize=signed-integer-overflow,unsigned-integer-overflow" AR=$(NATIVE)/bin/llvm-ar CC=$(NATIVE)/bin/clang CXX=$(NATIVE)/bin/clang++ ../$(TARGET_DIR)/configure
	make -C build-native -j $(JOBS)

vpx-benchdata:
	wget https://github.com/zyedidia/lfi-bench/releases/download/benchdata/vpx-benchdata.tar.gz
	tar -xf vpx-benchdata.tar.gz
	rm -f vpx-benchdata.tar.gz

bench: libvpx.csv

libvpx.csv: vpx-benchdata build-native build-lfi build-lfi-stores
	hyperfine --export-csv libvpx.csv --runs $(RUNS) --warmup $(WARMUP) \
		-n 'libvpx' './build-native/vpxdec --threads=$(THREADS) -o /dev/null vpx-benchdata/sample-30s.webm'

clean:
	rm -rf $(BUILD_DIRS) $(TARGET_DIR) vpx-benchdata
		rm -f *.csv

.PHONY: all bench clean
