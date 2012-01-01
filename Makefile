# For normal builds; remove -DX11 -lX11 from flags if you don't have X11
CC=gcc
EXE=ibniz
FLAGS=`sdl-config --libs --cflags` -DX11 -lX11
all: ibniz

# For win32 builds using mingw32 (you'll probably need to modify these)
#CC=i586-mingw32msvc-gcc
#EXE=ibniz.exe
#FLAGS=-L./SDL-1.2.14/lib -I./SDL-1.2.14/include -static -lmingw32 SDL-1.2.14/lib/libSDL.a SDL-1.2.14/lib/libSDLmain.a -mwindows -lwinmm
#all: ibniz.exe

clean:
	rm -f *.o *~ ibniz vmtest ibniz.exe

package: clean
	cd .. && tar czf ibniz-1.1.tar.gz ibniz-1.1/

$(EXE): ui_sdl.o vm_slow.o clipboard.o
	$(CC) -s -Os ui_sdl.o vm_slow.o clipboard.o -o $(EXE) $(FLAGS) -lm

ui_sdl.o: ui_sdl.c ibniz.h font.i vm.h texts.i
	$(CC) -c -Os ui_sdl.c -o ui_sdl.o $(FLAGS)

clipboard.o: clipboard.c ibniz.h
	$(CC) -c -Os clipboard.c -o clipboard.o $(FLAGS)

vm_slow.o: vm_slow.c ibniz.h vm.h
	$(CC) -c -O3 vm_slow.c -o vm_slow.o

font.i: font.pl
	perl font.pl > font.i

runtest: vmtest
	./vmtest

vmtest: vm_test.c vm_slow.c
	gcc vm_test.c vm_slow.c -o vmtest -lm
