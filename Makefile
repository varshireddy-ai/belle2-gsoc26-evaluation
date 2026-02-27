PREFIX ?= $(HOME)/belle2-eval/install

all: xz libffi sqlite python

xz:
	cd sources/xz && \
	./configure --prefix=$(PREFIX) && \
	$(MAKE) && \
	$(MAKE) install

libffi: xz
	cd sources/libffi && \
	./configure --prefix=$(PREFIX) && \
	$(MAKE) && \
	$(MAKE) install

sqlite: xz
	cd sources/sqlite && \
	./configure --prefix=$(PREFIX) && \
	$(MAKE) && \
	$(MAKE) install

python: xz libffi sqlite
	cd sources/python && \
	export CPPFLAGS="-I$(PREFIX)/include" && \
	export LDFLAGS="-L$(PREFIX)/lib" && \
	export PKG_CONFIG_PATH="$(PREFIX)/lib/pkgconfig" && \
	./configure --prefix=$(PREFIX) && \
	$(MAKE) && \
	$(MAKE) install

clean:
	rm -rf build
