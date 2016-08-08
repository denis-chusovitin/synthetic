#ifndef GRAMMAR_H_
#define GRAMMAR_H_

#include <string>
#include <vector>

using namespace std;

struct Production;

struct Symbol {
  string name;
  bool is_variable;
  vector<int> productions;
  
  Symbol(string name, bool is_variable) : 
    name(name), is_variable(is_variable) {}
};

struct Production {
  int head;
  vector<int> body;
  
  Production(int head, vector<int> body) :
    head(head), body(body) {}
}; 

class Grammar {
  private:
    int start;

  public:
    vector<Production> productions;
    vector<Symbol> symbols;
    int findWithAdd(string name, bool is_variable);
    void addProductions(string head_name, vector<vector<int>> productions);
};

#endif
