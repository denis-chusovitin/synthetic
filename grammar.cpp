#include "grammar.h"

int Grammar::findWithAdd(string name, bool is_variable) {
  int i;
  for(i = 0; i < symbols.size() && symbols[i].name != name; i++);
  
  if (i == symbols.size()) { 
    symbols.push_back(Symbol(name, is_variable));
  }
  
  return i;
}

void Grammar::addProductions(string head_name, vector<vector<int>> prods) {
  int idx = findWithAdd(head_name, true);
  
  for (auto it = prods.begin(); it != prods.end(); it++) {
    productions.push_back(Production(idx, *it));
    symbols[idx].productions.push_back(idx);
  } 
}


