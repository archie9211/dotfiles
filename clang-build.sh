#!/bin/bash
export DEVICE="X00TD"	
KERNEL_DIR=$PWD
export CCACHE_DIR="${KERNEL_DIR}/ccache-X00TD"
ccache -M 100G
export ARCH=arm64
export SUBARCH=arm64
rm -rf anykernel/Image.gz-dtb
export KBUILD_BUILD_USER="archie"
export KBUILD_BUILD_HOST="Hackintosh"
BUILD_START=$(date +"%s")
KERNEL_DIR=$PWD
blue='\033[0;34m' cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
echo "Starting"
make X00TD_defconfig 
#make menuconfig
echo "Making"
export KBUILD_COMPILER_STRING=$(/home/archie/work/CLang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')
echo -e "Using toolchain $KBUILD_COMPILER_STRING"
make -j8  \
                      ARCH=arm64 \
                      CC=/home/archie/work/CLang/bin/clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=/home/archie/work/aarch64-linux-android-4.9/bin/aarch64-linux-android-
echo "Making dt.img"
echo "Done"
export IMAGE=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb
if [[ ! -f "${IMAGE}" ]]; then
    echo -e "Build failed :P. Check errors!";
    rm -rf drivers/platform/msm/ipa/ipa_common
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
zip -r AzurE-Oreo-X00TD-clang-$BUILD_TIME *
cd ../
mv anykernel/AzurE-Oreo-X00TD-clang-$BUILD_TIME.zip /home/archie/work/msm-4.4.y/oldReleases/AzurE-Oreo-X00TD-clang-$BUILD_TIME.zip
echo -e "Kernel is named as $yellow AzurE-Oreo-X00TD-clang-$BUILD_TIME.zip $nocol and can be found at $yellow /home/archie/work/msm-4.4.y/oldReleases$nocol"
fi

