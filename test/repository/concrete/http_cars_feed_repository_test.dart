import 'package:flutter_test/flutter_test.dart';
import 'package:flutterdryve/repository/concrete/http_cars_feed_repository.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() async {
  HttpCarsFeedRepository httpCarsFeedRepository;
  MockDio mockClient;
  MockResponse mockResponse;

  group('HttpCarsFeedRepository tests', () {
    setUp(() {
      mockClient = MockDio();
      mockResponse = MockResponse();
      httpCarsFeedRepository = HttpCarsFeedRepository(
        client: mockClient,
      );
    });

    group('fetchAllCars', () {
      test('should work', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(200);
        when(mockResponse.data).thenReturn([]);
        await httpCarsFeedRepository.fetchAllCars();
      });

      test('should throw exception when response is not 200', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(500);
        expect(() => httpCarsFeedRepository.fetchAllCars(), throwsException);
      });
    });

    group('fetchAllBrands', () {
      test('should work', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(200);
        when(mockResponse.data).thenReturn([]);
        await httpCarsFeedRepository.fetchAllBrands();
      });

      test('should throw exception when response is not 200', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(500);
        expect(() => httpCarsFeedRepository.fetchAllBrands(), throwsException);
      });
    });

    group('fetchAllColors', () {
      test('should work', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(200);
        when(mockResponse.data).thenReturn([]);
        await httpCarsFeedRepository.fetchAllColors();
      });

      test('should throw exception when response is not 200', () async {
        when(mockClient.get(any)).thenAnswer((_) => Future.value(mockResponse));
        when(mockResponse.statusCode).thenReturn(500);
        expect(() => httpCarsFeedRepository.fetchAllColors(), throwsException);
      });
    });
  });
}
