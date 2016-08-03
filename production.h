#include <string>
#include <vector>

using namespace std;

struct Symbol
{
  string name;
  bool isVariable;
  
  Symbol(string name, bool isVariable) : 
    name(name), isVariable(isVariable) {}
};

struct Production
{
  Symbol head;
  vector<Symbol> body;
  Production(Symbol head, vector<Symbol> body) : 
    head(head), body(body) {}
};

