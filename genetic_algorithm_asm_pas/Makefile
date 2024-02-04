ASSEMBLER= wine ml
ASSEMBLER_FLAGS= /c /coff /Fl /I"C:\masm\include"
LINKER= wine link
LINKER_FLAGS= /subsystem:console /LIBPATH:"C:\masm\lib"
PASCAL= wine fpc

ASM_SOURCES= $(wildcard *.asm)
PROGRAMS= prak_7_asm.exe prak_7_pas.exe

ASM_SOURCES_UTF= $(patsubst %.asm, %.utf8.asm,  $(ASM_SOURCES))
OBJS=$(patsubst %.asm, %.obj, $(ASM_SOURCES))
LISTINGS=$(patsubst %.asm, %.lst, $(ASM_SOURCES))

all: $(PROGRAMS)

prak_7_asm.exe: l_asm.pas $(OBJS)
	$(PASCAL) -o$@ $<

prak_7_pas.exe: l_pas.pas
	$(PASCAL) -o$@ $<


%.obj: %.asm
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) $^

%.utf8.asm: %.asm
	iconv -f cp1251 -t utf8 < $^ > $@

convert_to_utf: $(ASM_SOURCES_UTF)

clean:
	rm -f $(OBJS) *.o  *.ppu $(LISTINGS) $(PROGRAMS) $(ASM_SOURCES_UTF)

run:
	wine ./$(PROGRAM)

