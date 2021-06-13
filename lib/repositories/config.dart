import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = StateProvider((ref) => 'https://ghibliapi.herokuapp.com/');

final dioConfigurationProvider = Provider((ref) => BaseOptions(baseUrl: ref.watch(baseUrlProvider).state));

final dioProvider = Provider((ref) => Dio(ref.watch(dioConfigurationProvider)));
