
.PHONY : all count clean

all : helwar.pdf helwar.txt helwar.info helwar.html helwar.count

MAKEINFO = makeinfo
TEXI2PDF = texi2pdf

SOURCES = helwar.texi ccbysa3.texi

helwar.pdf : $(SOURCES)
	$(TEXI2PDF) --tidy -o helwar.pdf helwar.texi
helwar.txt : $(SOURCES)
	$(MAKEINFO) --plaintext -o helwar.txt helwar.texi
helwar.info : $(SOURCES)
	$(MAKEINFO) --no-split -o helwar.info helwar.texi
helwar.html : $(SOURCES)
	$(MAKEINFO) --html --no-split -o helwar.html helwar.texi
helwar.count : helwar.txt
	sed -n -e ": top"\
	       -e "t skip"\
	       -e ": skip"\
	       -e "s|-\*-The novel's text starts here-\*-||"\
	       -e "t good"\
	       -e "n"\
	       -e "b top"\
	       -e ": good"\
	       -e "t skip2"\
	       -e ": skip2"\
	       -e "s|^Appendix A||"\
	       -e "t end"\
	       -e "s|^\**$$||"\
	       -e "p"\
	       -e "n"\
	       -e "b good"\
	       -e ": end"\
	       -e "q"\
	       < helwar.txt > helwar.count

count : helwar.count
	@wc -w helwar.count

clean :
	@rm -rf helwar.pdf helwar.txt helwar.info helwar.html\
	   helwar.count helwar.t2d
