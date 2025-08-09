# Include shared configuration
include ../common.mk

# Benchmark-specific configuration
RUNS ?= 10
WARMUP ?= 2

TARGET_DIR := zstd

all: bench

$(TARGET_DIR):
	git clone https://github.com/facebook/zstd.git

build-lfi: $(TARGET_DIR)
	meson setup build-lfi $(TARGET_DIR)/build/meson --cross-file $(LFI_MESON) -Ddefault_library=static
	ninja -C build-lfi

build-lfi-stores: $(TARGET_DIR)
	meson setup build-lfi-stores $(TARGET_DIR)/build/meson --cross-file $(STORES_MESON) -Ddefault_library=static
	ninja -C build-lfi-stores

build-native: $(TARGET_DIR)
	meson setup build-native $(TARGET_DIR)/build/meson --cross-file $(NATIVE_MESON) -Ddefault_library=static
	ninja -C build-native

bench: build-native build-lfi-stores build-lfi bigfile.txt
	mkdir -p /tmp/$(USER)
	build-native/programs/zstd -f bigfile.txt -o bigfile.txt.zst
	hyperfine --runs $(RUNS) --warmup $(WARMUP) --export-csv zstd-decompress.csv \
		-n 'zstd' 'build-native/programs/zstd -df bigfile.txt.zst -o /tmp/$(USER)/test_native_out.txt'
	# mkdir -p /tmp/$(USER)
	# # hyperfine --runs $(RUNS) --warmup $(WARMUP) --export-csv zstd-compress.csv \
	# # 	-n 'LFI' 'build-lfi/programs/zstd -f bigfile.txt -o /tmp/$(USER)/test_lfi.zst' \
	# # 	-n 'LFI-stores' 'build-lfi-stores/programs/zstd -f bigfile.txt -o /tmp/$(USER)/test_lfi_stores.zst' \
	# # 	-n 'Native' 'build-native/programs/zstd -f bigfile.txt -o /tmp/$(USER)/test_native.zst'

clean:
	rm -f bigfile.txt.zst *.csv
	rm -f /tmp/$(USER)/test_*.zst /tmp/$(USER)/test_*_out.txt
	rm -rf $(BUILD_DIRS) $(TARGET_DIR)

.PHONY: all bench clean
