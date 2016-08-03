#include <vector>
#include <map>
#include "production.h"

using namespace std;

class Graph {
  private:
    int size;
    bool **adj_matrix;
   // map<Production*, int, ProductionCompare> index_map;
    
    void get_element(Production* p1, Production* p2);
  public:
    Graph(vector<Production> &productions);
    ~Graph();
};
