class ResultEntity {
  int id;
  bool result;
  String message;
  String cultureMessage;
  int? statusCode;
  dynamic data;

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

  ResultEntity fromJson(Map<String, dynamic> jsonMap) {
    return ResultEntity(
      id: jsonMap['id'],
      result: jsonMap['result'],
      message: jsonMap['message'],
      cultureMessage: jsonMap['cultureMessage'],
    );
  }
}