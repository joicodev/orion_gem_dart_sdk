library;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ai_chat_dart_sdk/ai_chat_dart_sdk.dart';
import 'package:ai_chat_dart_sdk/src/core/storage/data/secure_storage_repository_impl.dart';
import 'package:dio/dio.dart';

part 'interceptors/client_log_interceptor.dart';
part 'interceptors/token_interceptor.dart';
part 'helpers/base_use_cases.dart';

part 'exceptions/api_exceptions.dart';
part 'exceptions/base_exception.dart';
part 'exceptions/dio_exceptions.dart';
// part 'exceptions/firebase_exceptions.dart';
part 'exceptions/serializing_exception.dart';

enum TypeMethodHttp { get, post, put, patch, delete }
