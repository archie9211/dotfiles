#!/bin/bash
#source py2env/bin/activate
export DEVICE="X00TD"
export CROSS_COMPILE=/home/archie/work/aarch64-linux-android-4.9/bin/aarch64-linux-android-
echo -e "Using toolchain: $(${CROSS_COMPILE}gcc --version | head -1)"
KERNEL_DIR=$PWD
#mkdir "ccache-X00TD"
export CCACHE_DIR="${KERNEL_DIR}/ccache-X00TD"
ccache -M 5G
export ARCH=arm64
export SUBARCH=arm64
#rm -rf ../anykernel/modules/wlan.ko
rm -rf anykernel/Image.gz-dtb
#make clean && make mrproper
export KBUILD_BUILD_USER="archie"
export KBUILD_BUILD_HOST="Hackintosh"
BUILD_START=$(date +"%s")
KERNEL_DIR=$PWD
blue='\033[0;34m' cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
echo "Initiating"
make X00TD_defconfig
#make menuconfig
echo "Creating"
make -j8
echo "Building dt.img"
echo "Task Completed."
export IMAGE=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb
if [[ ! -f "${IMAGE}" ]]; then
    echo -e "Build failed :P. Check errors!";
    rm -rf drivers/platform/msm/ipa/ipa_common
    break;
else
BUILD_END=$(date +"%s");
rm -rf drivers/platform/msm/ipa/ipa_common
DIFF=$(($BUILD_END - $BUILD_START));
BUILD_TIME=$(date +"%Y%m%d-%T");
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol";
echo "Movings Files"
cd anykernel
mv $KERNEL_DIR/arch/arm64/boot/Image.gz-dtb Image.gz-dtb
echo "Making Zip"
zip -r DarkOne-Oreo-pie-X00TD-$BUILD_TIME *
cd ../
mv anykernel/DarkOne-Oreo-pie-X00TD-$BUILD_TIME.zip /home/archie/work/msm-4.4.y/oldReleases/DarkOne-Oreo-pie-X00TD-$BUILD_TIME.zip
echo -e "Kernel is named as $yellow DarkOne-Oreo-pie-X00TD-$BUILD_TIME.zip $nocol and can be found at $yellow /home/archie/work/msm-4.4.y/oldReleases$nocol"
fi

