import 'package:e_learning_app/src/features/search/model/data_model.dart';
import 'package:e_learning_app/src/features/search/model/pagination_model.dart';

class ExpertModel {
  final String? message;
  final List<DataModel>? data;
  final PaginationModel? pagination;

  ExpertModel({this.message, this.data, this.pagination});

  factory ExpertModel.fromJson(Map<String, dynamic> json) {
    return ExpertModel(
      message: json['message'],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination:
          json['pagination'] != null
              ? PaginationModel.fromJson(json['pagination'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}
