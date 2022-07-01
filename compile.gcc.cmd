set FREEBASIC_COMPILER_DIRECTORY=C:\Program Files (x86)\FreeBASIC-1.09.0-win64-gcc-9.3.0
set FREEBASIC_COMPILER="%FREEBASIC_COMPILER_DIRECTORY%\fbc32.exe"
set GCC_COMPILER="%FREEBASIC_COMPILER_DIRECTORY%\bin\win32\gcc.exe"
set GCC_ASSEMBLER="%FREEBASIC_COMPILER_DIRECTORY%\bin\win32\as.exe"
set GCC_LINKER="%FREEBASIC_COMPILER_DIRECTORY%\bin\win32\ld.exe"
set ARCHIVE_COMPILER="%FREEBASIC_COMPILER_DIRECTORY%\bin\win32\ar.exe"
set RESOURCE_COMPILER="%FREEBASIC_COMPILER_DIRECTORY%\bin\win32\GoRC.exe"
set COMPILER_LIB_PATH="%FREEBASIC_COMPILER_DIRECTORY%\lib\win32"
set OBJCOPY_UTIL="C:\Program Files (x86)\mingw32\bin\objcopy.exe"
set OBJDUMP_UTIL="C:\Program Files (x86)\mingw32\bin\objdump.exe"

set GCC_OPTIMIZATION=-Wall -Werror -Wno-unused-label -Wno-unused-function -Wno-unused-variable -Wno-main -Werror-implicit-function-declaration -nostdlib -nostdinc -fno-strict-aliasing -frounding-math -fno-math-errno -fno-exceptions -fno-ident -mno-stack-arg-probe -fno-stack-check -fno-stack-protector -fno-unwind-tables -fno-asynchronous-unwind-tables -fomit-frame-pointer -fno-pic -fcf-protection=none -ffunction-sections -fdata-sections

del obj\*.o obj\*.asm obj\*.exe bin\*.com obj\*.c

%FREEBASIC_COMPILER% -gen gcc -r -w error -maxerr 1 -O 0 -s console "hello.bas"
%FREEBASIC_COMPILER% -gen gcc -r -w error -maxerr 1 -O 0 -s console "psp.bas"
%FREEBASIC_COMPILER% -gen gcc -r -w error -maxerr 1 -O 0 -s console "minimum.bas"
move /y "hello.c" "obj\hello.c"
move /y "psp.c" "obj\psp.c"
move /y "minimum.c" "obj\minimum.c"
replace.vbs "obj\hello.c"
replace.vbs "obj\psp.c"
replace.vbs "obj\minimum.c"

%GCC_COMPILER% %GCC_OPTIMIZATION% -std=gnu99 -DDOS -m16 -masm=intel -march=i386 -S -Ofast "obj\hello.c" -o "obj\hello.asm"
%GCC_COMPILER% %GCC_OPTIMIZATION% -std=gnu99 -DDOS -m16 -masm=intel -march=i386 -S -Ofast "obj\psp.c" -o "obj\psp.asm"
%GCC_COMPILER% %GCC_OPTIMIZATION% -std=gnu99 -DDOS -m16 -masm=intel -march=i386 -S -Ofast "obj\minimum.c" -o "obj\minimum.asm"

%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\hello.asm" -o "obj\hello.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\psp.asm" -o "obj\psp.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\minimum.asm" -o "obj\minimum.o"

%GCC_LINKER% -m i386pe -subsystem console -e _ENTRYPOINT --stack 1048576,1048576 --no-seh -L "." -s --strip-all --gc-sections --print-gc-sections --nmagic --script=com.ld "obj\hello.o" -o "obj\hello.exe"
%GCC_LINKER% -m i386pe -subsystem console -e _ENTRYPOINT --stack 1048576,1048576 --no-seh -L "." -s --strip-all --gc-sections --print-gc-sections --nmagic --script=com.ld "obj\psp.o" -o "obj\psp.exe"
%GCC_LINKER% -m i386pe -subsystem console -e _ENTRYPOINT --stack 1048576,1048576 --no-seh -L "." -s --strip-all --gc-sections --print-gc-sections --nmagic --script=com.ld "obj\minimum.o" -o "obj\minimum.exe"

%OBJCOPY_UTIL% -O binary -j .text "obj\hello.exe" "bin\hello.com"
REM %OBJDUMP_UTIL% -M intel -D -b binary -m i386 --adjust-vma=0x100 "bin\hello.com"

%OBJCOPY_UTIL% -O binary -j .text "obj\psp.exe" "bin\psp.com"
REM %OBJDUMP_UTIL% -M intel -D -b binary -m i386 --adjust-vma=0x100 "bin\psp.com"

%OBJCOPY_UTIL% -O binary -j .text "obj\minimum.exe" "bin\minimum.com"
REM %OBJDUMP_UTIL% -M intel -D -b binary -m i386 --adjust-vma=0x100 "bin\minimum.com"