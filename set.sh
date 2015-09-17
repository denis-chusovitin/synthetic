flex.exe code_parser.l
bison.exe --verbose --report-file "result" -d -t code_parser.y
g++ -std=c++11 lex.yy.c code_parser.tab.c *.cpp 