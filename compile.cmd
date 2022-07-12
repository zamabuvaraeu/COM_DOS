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

set GCC_OPTIMIZATION=-Wall -Werror -Wno-unused-label -Wno-unused-function -Wno-unused-variable -Wno-main -Werror-implicit-function-declaration -nostdlib -nostdinc -fno-strict-aliasing -frounding-math -fno-math-errno -fno-exceptions -fno-ident -mno-stack-arg-probe -fno-stack-check -fno-stack-protector -fno-unwind-tables -fno-asynchronous-unwind-tables -fomit-frame-pointer -fno-pic -fcf-protection=none -ffunction-sections

del bin\hello.com obj\*.exe obj\*.o obj\*.asm obj\*.c

copy /y "DOS\DOS.asm" "obj\DOS.asm"

%FREEBASIC_COMPILER% -gen gcc -r -w error -maxerr 1 -O 0 -s console "DOS\Heap.bas"
%FREEBASIC_COMPILER% -gen llvm -r -w error -maxerr 1 -O 0 -s console "DOS\Heap.bas"

%FREEBASIC_COMPILER% -gen gcc -r -w error -maxerr 1 -O 0 -s console "DOS\IntToString.bas"
%FREEBASIC_COMPILER% -gen llvm -r -w error -maxerr 1 -O 0 -s console "DOS\IntToString.bas"

%FREEBASIC_COMPILER% -i DOS -gen gcc -r -w error -maxerr 1 -O 0 -s console "Examples\hello.bas"
%FREEBASIC_COMPILER% -i DOS -gen llvm -r -w error -maxerr 1 -O 0 -s console "Examples\hello.bas"

%FREEBASIC_COMPILER% -i DOS -gen gcc -r -w error -maxerr 1 -O 0 -s console "Examples\psp.bas"
%FREEBASIC_COMPILER% -i DOS -gen llvm -r -w error -maxerr 1 -O 0 -s console "Examples\psp.bas"

move /y "DOS\Heap.c" "obj\Heap.c"
move /y "DOS\Heap.ll" "obj\Heap.ll"

move /y "DOS\IntToString.c" "obj\IntToString.c"
move /y "DOS\IntToString.ll" "obj\IntToString.ll"

move /y "Examples\hello.c" "obj\hello.c"
move /y "Examples\hello.ll" "obj\hello.ll"

move /y "Examples\psp.c" "obj\psp.c"
move /y "Examples\psp.ll" "obj\psp.ll"

replace.vbs "obj\Heap.c"
replace.vbs "obj\Heap.ll"

replace.vbs "obj\IntToString.c"
replace.vbs "obj\IntToString.ll"

replace.vbs "obj\hello.c"
replace.vbs "obj\hello.ll"

replace.vbs "obj\psp.c"
replace.vbs "obj\psp.ll"

%GCC_COMPILER% %GCC_OPTIMIZATION% -m16 -march=i386 -S -Ofast "obj\Heap.c" -o "obj\Heap.asm"
%GCC_COMPILER% %GCC_OPTIMIZATION% -m16 -march=i386 -S -Ofast "obj\IntToString.c" -o "obj\IntToString.asm"

%GCC_COMPILER% %GCC_OPTIMIZATION% -m16 -march=i386 -S -Ofast "obj\hello.c" -o "obj\hello.asm"
%GCC_COMPILER% %GCC_OPTIMIZATION% -m16 -march=i386 -S -Ofast "obj\psp.c" -o "obj\psp.asm"

%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\DOS.asm" -o "obj\DOS.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\Heap.asm" -o "obj\Heap.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\IntToString.asm" -o "obj\IntToString.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\hello.asm" -o "obj\hello.o"
%GCC_ASSEMBLER% --32 --strip-local-absolute "obj\psp.asm" -o "obj\psp.o"

%GCC_LINKER% -m i386pe -subsystem console -e _ENTRYPOINT --stack 1048576,1048576 --no-seh -L "." -s --strip-all --gc-sections --print-gc-sections --nmagic --script=com.ld "obj\DOS.o" "obj\Heap.o" "obj\hello.o" -o "obj\hello.exe"
%GCC_LINKER% -m i386pe -subsystem console -e _ENTRYPOINT --stack 1048576,1048576 --no-seh -L "." -s --strip-all --gc-sections --print-gc-sections --nmagic --script=com.ld "obj\DOS.o" "obj\Heap.o" "obj\IntToString.o" "obj\psp.o" -o "obj\psp.exe"

%OBJCOPY_UTIL% -O binary -j .text -j .data "obj\hello.exe" "bin\hello.com"
%OBJCOPY_UTIL% -O binary -j .text -j .data "obj\psp.exe" "bin\psp.com"

%OBJDUMP_UTIL% -D -b binary -m i8086 --adjust-vma=0x100 "bin\hello.com"
%OBJDUMP_UTIL% -D -b binary -m i8086 --adjust-vma=0x100 "bin\psp.com"