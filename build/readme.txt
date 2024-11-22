[20221130]
-build,修复64位包在android11(api 30)运行报错的问题。(bat light userdata point,luajit升到最新v2.1-20220915)
    https://codeload.github.com/openresty/luajit2/zip/refs/tags/v2.1-20220915
-修复32位安卓上sproto发送或接收数据超出21亿截断的问题。
-之前的mac编译环境已经没了，各种尝试后，改为windows+mingw+ndk10e(64位下ndk15c)。
    mingw：https://pan.baidu.com/s/1c2JzvDQ
    ndk-r10e：https://dl.google.com/android/repository/android-ndk-r10e-windows-x86_64.zip
    ndk-r15c：https://dl.google.com/android/repository/android-ndk-r15c-windows-x86_64.zip

20200610
slua的去掉了luajit的支持，反馈是在arm64上不稳定。找到了openresty维护的分支。用这个吧
https://github.com/openresty/luajit2/releases
v2.1-20200102

编译windows：
mingw_make_slua_win_x64.bat
mingw_make_slua_win_x86.bat

windows 编译中遇到的问题：
1、mingw 报错
/usr/bin/sh: del: command not found
https://stackoverflow.com/questions/47874932/why-does-make-exe-try-to-run-usr-bin-sh-on-windows

2、luasocket报错  error: unknown type name ‘luaL_reg’   
修改luajit源代码  增加 #define luaL_reg     luaL_Reg

3、sproto编译不过
修改sproto编译不过的。 一个注释掉自定义lua_tointegerx，另外LUAMOD_API改成LUALIB_API

4、LPEG来自tolua库的buid
https://github.com/topameng/tolua_runtime

------------------------------------------------------------------------------------------
Mac 上编译Android遇到的问题。
make_android.sh

1、make clean 报错了
OSX: Don't set a default MACOSX_DEPLOYMENT_TARGET.
解决办法：
https://github.com/LuaJIT/LuaJIT/issues/538
下载了Mac 10.12的sdk
解压后的文件夹拷贝到了xcode的对应目录
修改make_android.sh, 
在make的命令上加上了MACOSX_DEPLOYMENT_TARGET="10.12"

-----------------------------------------------------------------------------------------
Mac 上编译Mac osx 遇到问题
make_osx_jit.sh
首先必须在make的命令上加上了MACOSX_DEPLOYMENT_TARGET="10.12" 

1、"_luaL_callmeta", referenced from:
https://github.com/LuaJIT/LuaJIT/issues/466
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

2、编译bundle时，去掉了32位系统的支持。新版的xcode也不支持


-----------------------------------------------------------------------------------------
Mac 上编译ios 遇到的问题
1、 编译 arm64时。lj_dispatch_update 函数 使用时候的没有声明
在lj_gc.c增加
#include "lj_dispatch.h"

2、编译ios的模拟器版本时，报错
lib_os.c:52:14: error: 'system' is unavailable: not available on iOS
阅读代码后修改了lj_arch.h
大概是luajit不认为自己是ios平台。
改代码可以编译通过。但是没有必要。去掉模拟器的支持吧，我们也不太需要这个。 有需求的时候改成lua吧。
更多信息搜索 luajit 模拟器




--------------------------------------------------------------------------------------------------------------------------------------
编译各种环境的jit代码，采用luajit2.1-beta3

实在没法在IOS的bundle里面使用luajit.在OSX64位模式下，只能用GC64

为了支持远程调试，集成了luasocket，仅包含socket库，扩展的ftp,smtp等库没有集成

1、编译windows版本，在MinGW环境下编译。用git上传gubmodule的文件夹总算报错。手动执行git submodule add https://github.com/noeticwxb/MinGW.git MinGW来添加一个Moudle。 
2、android、mac、ios都在mac环境下编译




