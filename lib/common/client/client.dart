import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jog_inventory/common/globals/config.dart';
import 'package:jog_inventory/common/globals/global.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class _DioClient {
  late final Dio _dio;

  Init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: Duration(seconds: 20),
        contentType: "application/json",
        responseType: ResponseType.json,
        receiveTimeout: Duration(seconds: 20),
      ),
    );

    // Adding Dio Logger interceptor for logging
    // customization
    _dio.interceptors.add(PrettyDioLogger(
        maxWidth: 2000,
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true));

    // Adding error handling interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) {
        // if (e.message == null) {
        var message = _handleError(e);
        return handler.next(
            DioException(requestOptions: e.requestOptions, message: message));
        // }
        // return handler.next(e);
      },
    ));

    // Adding Auth interceptor if token is not null

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        /// adding token when there is token present
        var token = globalData.authToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer ${token}';
        }
        return handler.next(options);
      },
    ));
  }

 void setBaseUrl() => _dio.options.baseUrl = config.baseUrl;

  Future _setHeaderToken() async {
    var token = globalData.authToken;
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';
    }
  }

  String _handleError(DioException error) {
    if (error.response?.statusCode == 401) {
      globalData.logoutUser();
      if (error.message != null)
        throw error.message!;
      else
        throw "Unauthorized user";
    }
    if (error.type == DioExceptionType.unknown) {
      throw 'Unknown error from server!';
    } else if (error.type == DioExceptionType.sendTimeout) {
      throw 'Send Timeout!';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw 'Receive Timeout!';
    } else if (error.type == DioExceptionType.cancel) {
      throw 'Request to API server was cancelled';
    } else {
      throw 'Unexpected error occurred!';
    }
  }

// GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      _setHeaderToken();
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

// POST request
  Future<Response> post(String endpoint, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      _setHeaderToken();
      return await _dio.post(endpoint,
          data: data, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

// UPDATE request
  Future<Response> update(String endpoint, dynamic data,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      _setHeaderToken();
      return await _dio.put(endpoint,
          data: data, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

// DELETE request
  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      _setHeaderToken();
      return await _dio.delete(endpoint,
          queryParameters: queryParameters, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MultipartFile> createMultipartFile(File file) async {
    return await MultipartFile.fromFile(file.path);
  }
}

var dioClient = _DioClient();
