
.PHONY : all count clean

all : helwar.pdf helwar.txt helwar.info helwar.html helwar.count

MAKEINFO = makeinfo
TEXI2PDF = texi2pdf

helwar.pdf : helwar.texi
	$(TEXI2PDF) --tidy -o helwar.pdf helwar.texi
helwar.txt : helwar.texi
	$(MAKEINFO) --plaintext -o helwar.txt helwar.texi
helwar.info : helwar.texi
	$(MAKEINFO) --no-split -o helwar.info helwar.texi
helwar.html : helwar.texi
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
	       -e "p"\
	       -e "n"\
	       -e "b good"\
	       < helwar.txt > helwar.count

count : helwar.count
	@wc -w helwar.count

clean :
	@rm -rf helwar.pdf helwar.txt helwar.info helwar.html\
	   helwar.count helwar.t2d
