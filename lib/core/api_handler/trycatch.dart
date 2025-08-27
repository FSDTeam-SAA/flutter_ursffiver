import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../helpers/dekhao.dart';
import 'exceptions.dart';
import 'failure.dart';

abstract base class Repository {
  Future<Either<DataCRUDFailure, T>> asyncTryCatch<T>({required Future<T> Function() tryFunc, }) async{
      try {
        return await tryFunc().then((value) => Right(value));
        
      } on ServerException catch(e){
        dekhao(e);
        return Left(DataCRUDFailure(failure: Failure.severFailure, message: 'Server failed!'));
      } on NoDataException catch(e){
        dekhao(e);
        return Left(DataCRUDFailure(failure: Failure.noData, message: "Doesn't exist!"));
      } on SocketException {
        return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
      } on DioException catch (e){
        dekhao("DioFailure $e");
        if(e.response?.statusCode.toString() == "403") {
          return Left(DataCRUDFailure(failure: Failure.forbidden, message: e.response?.data["message"] ?? "Process failed! $e"));
        }
        return Left(DataCRUDFailure(failure: Failure.dioFailure, message: e.response?.data["message"] ?? "Process failed! $e"));
      } on FormatException catch (e){
        dekhao("DioFailure $e");
        return Left(DataCRUDFailure(failure: Failure.formatFailure, message: "Formatting failed! $e"));
      } catch (e) {
        dekhao(e);
        return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: 'Some error occured. ${'\n'} Error: ${e.toString()}'));
      }
  }

  Either<DataCRUDFailure, T> tryCatch<T>({required T Function() tryFunc, }) {
      try {
        return Right(tryFunc());
        
      } on ServerException {
        return Left(DataCRUDFailure(failure: Failure.severFailure, message: ''));
      } on SocketException {
        return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
      } catch (e) {
        return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: 'Some error occured. Error: ${e.toString()}'));
      }
  }
}



