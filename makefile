FLEX_SDK = ~/flexsdk
ADL = $(FLEX_SDK)/bin/adl
AMXMLC = $(FLEX_SDK)/bin/amxmlc
SOURCES = src/*.hx assets/loading.png

all: tiled.swf

tiled.swf: $(SOURCES)
	haxe \
	-cp src \
	-cp vendor \
	-swf-version 11.8 \
	-swf-header 800:640:60:ffffff \
	-main Startup \
	-swf tiled.swf \
	-swf-lib vendor/starling.swc --macro "patchTypes('vendor/starling.patch')"

run:
	make
	cygstart tiled.swf

clean:
	rm -rf game.swf *~ src/*~

test: game.swf
	$(ADL) -profile tv -screensize 640x360:640x360 game.xml