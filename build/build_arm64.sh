source ./build/env

if [[ -z "$1" ]]; then
	echo "Empty config filename. Please select:"
	ls ./arch/arm64/configs
	exit
fi
if [[ -f "./arch/arm64/configs/$1" ]]; then
	make -j8 O=out $1
	while true; do
            read -p "Do you wish to edit config?: " yn
            case "$yn" in
                [Yy]* ) make O=out menuconfig; break;;
                [Nn]* ) break;;
                    * ) echo "Please answer yes or no";;
            esac
        done
else
	echo "Config $1 not found"
	exit
fi

sh ./build/pre-compile.sh
make -j8 O=out
cp ./out/arch/arm64/boot/Image.gz-dtb ./build/AnyKernel3
cd ./build/AnyKernel3
sh ./build.sh
cd ../..
if [[ -z "./out/arch/arm64/boot/Image.gz-dtb" ]]; then
    echo "===============[ BUILD SUCCESSFUL ]================="
    echo "Flash update.zip via TWRP"
else
    echo "===============[   BUILD FAILED   ]================="
    echo "Check logs"
fi

