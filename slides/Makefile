SOURCES=$(wildcard *.md)
SLIDES=$(patsubst %.md,%.html,$(SOURCES))

all: $(SLIDES) head.html foot.html

%.html: %.md head.html foot.html
	cat head.html > $@
	markdown $< >> $@
	cat foot.html >> $@

clean:
	rm -f $(SLIDES)

.PHONY: all clean

