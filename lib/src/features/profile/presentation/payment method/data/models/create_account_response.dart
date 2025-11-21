class CreateAccountResponse {
  bool? success;
  String? message;
  String? accountId;

  CreateAccountResponse({this.success, this.message, this.accountId});

  CreateAccountResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['accountId'] = this.accountId;
    return data;
  }
}
