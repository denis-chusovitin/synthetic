struct RequestNodeInformation {
  std::string _name;
  int i;
};

struct AnswerNodeInformation {
  bool is_stop;
  bool is_closure_operator;
  int count;
  std::string _name;
};