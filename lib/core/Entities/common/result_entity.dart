class ResultEntity {
  bool result;
  String message;
  String cultureMessage;

  ResultEntity({
    required this.result,
    required this.message,
    required this.cultureMessage,
  });

  ResultEntity.empty()
    : result = false,
      message = "",
      cultureMessage = "";
}