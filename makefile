fastaParser: fasta.l fasta.y
	mkdir -p bin
	bison -o fastaParser.cpp -d fasta.y
	flex fasta.l
	g++ -std=c++20 -g -o bin/fastaParser fastaParser.cpp fastaLexer.cpp -ll


clean:
	rm -f fastaParser.cpp fastaLexer.cpp fastaParser.hpp preEncryptParser.cpp preEncryptLexer.cpp preEncryptParser.hpp
	rm -rf bin

preEncrypt: preEncrypt.l preEncrypt.y
	mkdir -p bin
	bison -o preEncryptParser.cpp -d preEncrypt.y
	flex preEncrypt.l
	g++ -std=c++20 -g -o bin/preEncrypt preEncryptParser.cpp preEncryptLexer.cpp -ll

