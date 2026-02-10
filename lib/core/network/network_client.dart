import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';
import '../constants/api_constants.dart';

/// Network client with retry logic and timeout handling
class NetworkClient {
  final http.Client _client;

  NetworkClient({http.Client? client}) : _client = client ?? http.Client();

  /// Performs GET request with retry logic
  Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    int maxRetries = 3,
  }) async {
    return _executeWithRetry(
      () => _client.get(
        Uri.parse(url),
        headers: headers,
      ),
      maxRetries: maxRetries,
    );
  }

  /// Performs POST request with retry logic
  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    int maxRetries = 3,
  }) async {
    return _executeWithRetry(
      () => _client.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      ),
      maxRetries: maxRetries,
    );
  }

  /// Executes HTTP request with retry logic and error handling
  Future<http.Response> _executeWithRetry(
    Future<http.Response> Function() request, {
    required int maxRetries,
  }) async {
    int retryCount = 0;

    while (true) {
      try {
        final response = await request().timeout(
          ApiConstants.connectionTimeout,
          onTimeout: () {
            throw NetworkException(
              message: 'Connection timeout after ${ApiConstants.connectionTimeout.inSeconds}s',
            );
          },
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return response;
        } else if (response.statusCode >= 500 && retryCount < maxRetries) {
          // Retry on server errors
          retryCount++;
          await Future.delayed(
            ApiConstants.retryDelay * retryCount,
          );
          continue;
        } else {
          throw ServerException(
            message: 'Server error: ${response.body}',
            statusCode: response.statusCode,
          );
        }
      } on SocketException catch (e) {
        if (retryCount < maxRetries) {
          retryCount++;
          await Future.delayed(ApiConstants.retryDelay * retryCount);
          continue;
        }
        throw NetworkException(
          message: 'No internet connection: ${e.message}',
        );
      } on TimeoutException catch (e) {
        if (retryCount < maxRetries) {
          retryCount++;
          await Future.delayed(ApiConstants.retryDelay * retryCount);
          continue;
        }
        throw NetworkException(
          message: 'Request timeout: ${e.message}',
        );
      } on NetworkException {
        rethrow;
      } on ServerException {
        rethrow;
      } catch (e) {
        throw NetworkException(
          message: 'Unexpected network error: $e',
        );
      }
    }
  }

  void dispose() {
    _client.close();
  }
}
