if [[ -z $1 ]]; then
	echo 'Empty config filename. Please select:'
	ls ./arch/arm64/configs
	exit
fi
if [[ -f ./arch/arm64/configs/$1 ]]; then
	make -j8 O=out $1
else
	echo "Config $1 not found."
	exit
fi

sh download_toolchain.sh
source ./env
make -j8 O=out
cp ./out/arch/arm64/boot/Image.gz-dtb ./AnyKernel3
cd ./AnyKernel3
sh build.sh
cd ..
echo '===============[ BUILD SUCCESSFUL ]================='
echo 'Flash update.zip via TWRP'
