%{
#include <stdio.h>
#include <iostream>
#include <list>
#include <vector>
#include <string>
#include <typeinfo>

/*
#include "class_struct.h"
#include "new_struct_for_program.h"
#include "search_functions.h"
#include "create_program_functions.h"
#include "functions_to_create_new_struct.h"
#include "functions_to_print_data_from_new_struct.h"
*/
#include "grammar.h"
#include "graph.h"

#ifdef __cplusplus
// extern "C" {
#endif

  //#ifndef yylineno
  extern int yylineno;
  //#endif
  extern int yylex();

  extern void setNewBuffer(const char *buffer_pointer);

  extern void yyerror(char const *s) {
    std::cerr << s << ", line " << yylineno << std::endl;
    return;
    
  extern int percent_count;
  }
#ifdef __cplusplus
//}
#endif

  //#define YYSTYPE std::string

  std::vector<std::string> massive_of_tokens;

  typedef struct {
    std::string str;
    char *char_type;
    int integer;
  //  OperatorTypeClass *node_t;
  //  TokenTypeClass *token_t;  /// Пока не используется но может понадобится
  } YYSTYPE;
  
#define YYSTYPE YYSTYPE

  //#define YYPRINT(file, type, value) printf("%d", value);

  bool print_graph = false;
  bool print_program = false;
  bool is_input_file_set = false;

  std::string output_graph_file("");
  std::string output_program_file("");
  
  vector<int> prod_body;
  vector<vector<int>> prod_bodies;
  
  Grammar g;

%}


%token VARIABLE
%token SYMBOL

%token RETURNED_TOKEN

%token DOUBLE_PERCENT 
%token PERCENT_OPEN_BRACE
%token PERCENT_CLOSE_BRACE
%token TOKEN_LINE_START
 
%error-verbose

%type<str> VARIABLE SYMBOL RETURNED_TOKEN 

%%

PROGRAM : TOKEN_SECTION_EMPTY_OR_NOT DOUBLE_PERCENT OPS {
  /*
  vector<Prod>::iterator prod; 
  vector<Symbol>::iterator j;  
  
  for (prod=productions.begin(); prod!=productions.end(); prod++) {
    vector<Symbol> body = prod->second;
    std::cout << prod->first.name << ":\n ";
    for (j=body.begin(); j!=body.end(); j++) {
        std::cout << j->name << ' ';
    }
    std::cout << '\n';
  }
  */
  /*
  for (auto it = g.productions.begin(); it!=g.productions.end(); it++) {
    std::cout << g.symbols[it->head].name << ":\n ";
    auto body = it->body;
    for (auto i = body.begin(); i != body.end(); i++) {
      std::cout << g.symbols[*i].name << ' ';
    }
    std::cout << '\n';
  }
  */
  Graph graph(g);
   // productions.push_back(Production(Symbol($1, true), *it));
  // printHelloFromSo();
  //searchOperators($3);
  //std::cout << $3;
  //createAdditionalConnections();
  //createNodesFromMap();
  //generateAdditionalConnectionsInNewStructure();
  //if (print_graph) {
   // printAllDataFromNewStruct(output_graph_file, massive_of_tokens);
  //}
  //if (print_program) {
  //  generateProgramCode(output_program_file);
  //}
};

TOKEN_SECTION_EMPTY_OR_NOT:
| TOKEN_LINES;

TOKEN_LINES:
TOKEN_LINE
| TOKEN_LINES TOKEN_LINE;

TOKEN_LINE:
TOKEN_LINE_START RETURNED_TOKENS;

RETURNED_TOKENS:
RETURNED_TOKEN { massive_of_tokens.push_back($1); }
| RETURNED_TOKENS RETURNED_TOKEN { massive_of_tokens.push_back($2); };

OPS:
OP {
}  // Наследуется от ОР $$ = new Operators($1);
| OPS OP { };

OP:
VARIABLE ':' DEFINITION_BLOCKS ';' { 
	g.addProductions($1, prod_bodies);
  prod_bodies.clear();
};

DEFINITION_BLOCKS: 
{
  prod_bodies.push_back(prod_body);
}
|
DEFINITION_BLOCK {
  prod_bodies.push_back(prod_body);
  prod_body.clear();
}
|
DEFINITION_BLOCKS '|' DEFINITION_BLOCK {
  prod_bodies.push_back(prod_body);
  prod_body.clear();
};

DEFINITION_BLOCK: 
TOKEN 
| DEFINITION_BLOCK TOKEN
;

TOKEN:
VARIABLE { 
  prod_body.push_back(g.findWithAdd($1, true));
}
| SYMBOL {
  prod_body.push_back(g.findWithAdd($1, false));
};
%%
#define OFFSET_FOR_MINUSES 2

    bool isArgumentExists(int _argc, char **_argv, std::string _parameter,
                          int *_parameter_position) {
  for (int i = 0; i < _argc; ++i) {
    if (_argv[i][0] == '-' && _argv[i][1] == '-') {
      std::string temp_str(_argv[i] + OFFSET_FOR_MINUSES);
      // cout << temp_str << endl;
      if (temp_str.compare(_parameter) == 0) {
        *_parameter_position = i;
        return true;
      }
    }
  }
  return false;
};

bool isFilePathNextToParameter(int _position, int _argc, char **_argv) {
  if (_position + 1 < _argc) {
    if (_argv[_position + 1][0] != '-') {
      return true;
    }
  }
  return false;
}

int main(int argc, char **argv) {
  int argument_position = 0;

  int graph_file_position = 0;
  int program_file_position = 0;
  int input_file_position = 0;

  // Если пришло --version
  // Выводим версию
  if (isArgumentExists(argc, argv, "version", &argument_position)) {
    printf("%s\n", "Code Creator, version 0.01 | 18.09.2015 ");
    return 0;
  }
  // Если пришло --help
  // Выводим хэлп
  if (isArgumentExists(argc, argv, "help", &argument_position)) {
    printf("%s\n",
           "Help Information:\n Usage: parser [argument [file]]     generate "
           "content depending on argument and write it in file or screen.\n\n "
           "--help:     Show help (this message) and exit\n --version:  Show "
           "version and exit\n --graph:    generates graph description in dot "
           "langauage. If [file] specified writes this description in to the "
           "file. \n --program:  generates program code. If [file] specified "
           "writes this code in to the file.\n --input:    parse text from "
           "file\n  ");
    return 0;
  }

  // Если пришло --graph
  // Выводим граф
  if (isArgumentExists(argc, argv, "graph", &argument_position)) {
    print_graph = true;
    // Сделать проверку есть ли у аргумента параметр
    // В данном случае аргумент задает куда будем писать граф, если не задан то
    // на экран
    if (isFilePathNextToParameter(argument_position, argc, argv)) {
      graph_file_position = argument_position + 1;
      output_graph_file.assign(argv[graph_file_position]);
    }
  }

  if (isArgumentExists(argc, argv, "program", &argument_position)) {
    print_program = true;
    if (isFilePathNextToParameter(argument_position, argc, argv)) {
      program_file_position = argument_position + 1;
      output_program_file.assign(argv[program_file_position]);
    }
  }
  /// файл ввода
  // Если пришло --input
  if (isArgumentExists(argc, argv, "input", &argument_position)) {
    is_input_file_set = true;
    if (isFilePathNextToParameter(argument_position, argc, argv)) {
      input_file_position = argument_position + 1;
    }
  }
  // Допустим с параметрами разобрались
  // Теперь если задан файл для парсинга
  // Мы из него пишем в память и потом парсим
  if (is_input_file_set) {
    // Обработка и чтение из файла
    // Перед вызовом лекса надо считать из файла и в память.
    int const max_buffer_size = 2048;
    char buff[max_buffer_size];
    std::string _str("");
    FILE *pointer_to_file;

    pointer_to_file = fopen(argv[input_file_position], "r+");
    if (pointer_to_file != NULL) {
      while (fgets(buff, 2048, pointer_to_file)) {
        _str.append(buff);
      }
      fclose(pointer_to_file);
      std::string temp_first_pars_string("");
      int pos_of_percent_brace;
      pos_of_percent_brace = _str.find("%{");
      if (pos_of_percent_brace != -1) {
        temp_first_pars_string = _str.substr(0, pos_of_percent_brace);
        temp_first_pars_string.append(_str.substr(_str.find("%}") + 3));
        _str.assign(temp_first_pars_string);
      } else {
      }
      /// Set New Buffer For Flex Input
      setNewBuffer(_str.c_str());
    } else {
      // Нужо написать что раз не выбран файл то работаем с вводом
      std::cout << "Not Set read file.\nReading from the standard input:\n "
                << std::endl;
    }
  }
  // Работает, этого должно быть достаточно чтобы собрать например массив строк,
  //  и из него сделать буфер из которого будем читать

  return yyparse();
}
