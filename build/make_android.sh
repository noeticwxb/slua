cd "$( dirname "${BASH_SOURCE[0]}" )"

DIR=$(pwd)

cd luajit-2.1.0-beta3
# git clean -f
SRCDIR=$(pwd)

NDK=D:/android-ndk-r10e
${NDK?"Need to set NDKPATH"}

NDKABI=8
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"


# # Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
# NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
# NDKABI=14
# NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
# DESTDIR=$DIR/android/armeabi-v7a
# mkdir -p $DESTDIR
# # rm -rf "$DESTDIR"/*.a
# # make clean MACOSX_DEPLOYMENT_TARGET="10.12"
# # git clean -f
# make HOST_CC="gcc -m32" MACOSX_DEPLOYMENT_TARGET="10.12" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" BUILDMODE=static
# echo $DESTDIR
# cp src/libluajit.a $DESTDIR/libluajit.a

# # Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
# NDKABI=14
# DESTDIR=$DIR/android/x86
# mkdir -p $DESTDIR
# NDKVER=$NDK/toolchains/x86-4.9
# NDKP=$NDKVER/prebuilt/windows-x86_64/bin/i686-linux-android-
# NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-x86"
# rm -rf "$DESTDIR"/*.a
# make clean MACOSX_DEPLOYMENT_TARGET="10.12"
# git clean -f
# make HOST_CC="gcc -m32" MACOSX_DEPLOYMENT_TARGET="10.12" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF" BUILDMODE=static
# echo $DESTDIR
# cp src/libluajit.a $DESTDIR/libluajit.a

# Android/ARM, arm64-v8a
NDKABI=21
NDKARCH="-march=armv8-a "
DESTDIR=$DIR/android/arm64-v8a
mkdir -p $DESTDIR
NDKVER=$NDK/toolchains/aarch64-linux-android-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/aarch64-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm64"
rm -rf "$DESTDIR"/*.a
make clean MACOSX_DEPLOYMENT_TARGET="10.12"
# git clean -f
make HOST_CC="gcc -m64" MACOSX_DEPLOYMENT_TARGET="10.12" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" BUILDMODE=static
echo $DESTDIR
cp src/libluajit.a $DESTDIR/libluajit.a

# make clean
# git clean -f

NDK=D:/android-ndk-r15c
cd ../android/jni

$NDK/ndk-build.cmd clean
$NDK/ndk-build.cmd

exit

cp ../libs/armeabi-v7a/libslua.so ../../../Assets/Plugins/Android/libs/armeabi-v7a/libslua.so
cp ../libs/x86/libslua.so ../../../Assets/Plugins/Android/libs/x86/libslua.so
cp ../libs/arm64-v8a/libslua.so ../../../Assets/Plugins/Android/libs/arm64-v8a/libslua.so





