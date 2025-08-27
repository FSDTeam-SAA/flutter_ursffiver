import 'package:dartz/dartz.dart';

import '../api_handler/failure.dart';
import '../api_handler/success.dart';
import '../notifiers/button_status_notifier.dart';
import '../notifiers/snackbar_notifier.dart';
import 'dekhao.dart';

T? handleFold<T>({
  required Either<DataCRUDFailure, Success<T>> either,
  ProcessStatusNotifier? processStatusNotifier,
  SnackbarNotifier? snackbarNotifier,
  void Function(T? data)? onSuccess,
  void Function(DataCRUDFailure failure)? onError,
}) {
  return either.fold(
    (failure) {
      dekhao2(failure.toString());
      processStatusNotifier?.setError(message: failure.message);
      snackbarNotifier?.notifyError(message: failure.message);
      if(onError != null)onError(failure);
      return null;
    },
    (result) {
      if (onSuccess != null) onSuccess(result.data);
      dekhao("success result is ${(result as Success).message}");
      processStatusNotifier?.setSuccess(message: (result as Success).message);
      snackbarNotifier?.notifySuccess(message: (result as Success).message);
      return result.data;
    },
  );
}
