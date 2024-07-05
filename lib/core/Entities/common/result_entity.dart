class ResultEntity {
  int id;
  bool result;
  String message;
  String cultureMessage;

  ResultEntity({
    required this.id,
    required this.result,
    required this.message,
    required this.cultureMessage,
  });

  ResultEntity.empty()
    : id = 0, 
      result = false,
      message = "",
      cultureMessage = "";
}