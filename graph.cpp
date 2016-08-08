#include "graph.h"
#include <iostream>

Graph::Graph(int n) {
  size = n;
  
  adj_matrix = new bool*[size];
    
  for(int i = 0; i < size; i++) {
    adj_matrix[i] = new bool[size];
  }
  
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      adj_matrix[i][j] = false;
    }
  }
}

Graph::Graph(Grammar &g) : Graph(g.productions.size()) {
  for (int i = 0; i < g.productions.size(); i++) {
    auto body = g.productions[i].body;

    for (int j = 0; j < body.size(); j++) {
      for (int k = 0; k < g.symbols[body[j]].productions.size(); k++) {
        adj_matrix[i][g.symbols[body[j]].productions[k]] = true;
      }
    }
  }  
  transitive_closure();
}

Graph::~Graph() {
  for(int i = 0; i < size; i++) {
    delete [] adj_matrix[i];
  }
  delete [] adj_matrix;
}

void Graph::transitive_closure() {
  for (int k = 0; k < size; k++) {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        adj_matrix[i][j] = adj_matrix[i][j] || 
          adj_matrix[i][k] && adj_matrix[k][j];
      }
    }
  }
}

