sh download_toolchain.sh
source ./env
make -j8 O=out pine-mt7601u-perf_defconfig
make -j8 O=out
cp ./out/arch/arm64/boot/Image.gz-dtb ./AnyKernel3
cd ./AnyKernel3
sh build.sh
cd ..
echo '===============[ BUILD SUCCESSFUL ]================='
echo 'Flash update.zip via TWRP'
