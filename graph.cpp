#include "graph.h"
#include <iostream>

Graph::Graph(vector<Production> &productions) {
  size = productions.size();
  
  adj_matrix = new bool*[size];
    
  for(int i = 0; i < size; i++) {
    adj_matrix[i] = new bool[size];
  }
  
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      adj_matrix[i][j] = false;
    }
  }
  
  for (int i = 0; i < productions.size(); i++) {
    auto body = productions[i].body;

    for (int j = 0; j < body.size(); j++) {
      for (int k = 0; k < productions.size(); k++) {
        if (productions[k].head.name == body[j].name) {
          adj_matrix[i][k] = true;
        }
      }
    }
  }
  
}

Graph::~Graph() {
  for(int i = 0; i < size; i++) {
    delete [] adj_matrix[i];
  }
  delete [] adj_matrix;
}
