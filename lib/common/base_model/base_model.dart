import 'package:dio/dio.dart';
import 'package:jog_inventory/common/client/client.dart';

class BaseModel {
  String get endPoint => "api/fake_api";
  String get listEndPoint => "api/fake_api";

  /// [updatedAt] in case you want to store the data to the local storage and want to calculate and note storage time
  DateTime? updatedAt;

  Map<String, dynamic> toJson() => {};

  /// Note
  ///
  /// [url] in case you want to change the endpoint
  /// [queryParameters] extra perms
  /// [pathSuffix] add on to the given endpoint

  Future<Response> create(
      {Map<String, dynamic>? queryParameters,
      String? pathSuffix,
      bool isFormData = false,
      Map<String, dynamic>? data,/// send data manually
      String? url}) {
    var body;
    if (isFormData) {
      body = FormData.fromMap(data ?? toJson());
    } else
      body = data ?? toJson();
    var endpoint = [
      (url ?? this.endPoint),
      if (pathSuffix != null) ("/$pathSuffix"),
    ].join("");
    return dioClient.post(endpoint, body, queryParameters: queryParameters);
  }

  Future<Response> get(
      {Map<String, dynamic>? queryParameters,
      String? pathSuffix,
      String? url}) {
    return dioClient.get((url ?? this.endPoint) + (pathSuffix ?? ""),
        queryParameters: queryParameters);
  }

  Future<Response> update(
      {Map<String, dynamic>? queryParameters,
      String? pathSuffix,
      String? url}) {
    return dioClient.update(
        (url ?? this.endPoint) + (pathSuffix ?? ""), toJson(),
        queryParameters: queryParameters);
  }

  Future<Response> delete(
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      String? pathSuffix,
      String? url}) {
    return dioClient.delete(
        [
          (url ?? this.endPoint),
          (pathSuffix ?? ""),
          (pathSuffix ?? ""),
        ].join(""),
        data: data,
        queryParameters: queryParameters);
  }
}
