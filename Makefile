
MDDIR=manuscript
LPDIR=~/Documents/Dropbox/hackerways/manuscript

all:
	echo "Do make publish to run emacs and sync to Dropbox"

frame:
	./res/frame.sh *.tif
	cp *.png images/
	mv *.png ../publish/hacker-ways/images

lpimg:
	rsync -azv images/ ~/Documents/Dropbox/hackerways/manuscript/images/

MARKDOWN=\
	$(MDDIR)/introduction.md \
	$(MDDIR)/terminal.md \
	$(MDDIR)/tools.md \
	$(MDDIR)/editor.md \
	$(MDDIR)/programming.md \
	$(MDDIR)/speaking-python.md \
	$(MDDIR)/computing.md

$(MDDIR)/%.md:	%.org
	./res/export.sh $<
	mv $*.md $@

publish:	$(MARKDOWN)
	rsync -azv $(MDDIR)/ $(LPDIR)/

clean:
	rm -f *screen.tif
	rm -rf ltxpng
