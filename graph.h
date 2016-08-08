#include <vector>
#include <map>
#include "grammar.h"

using namespace std;

class Graph {
  private:
    int size;
    bool **adj_matrix;
    
    void transitive_closure();
  public:
    Graph(int n);
    Graph(Grammar &g);
    ~Graph();
};
