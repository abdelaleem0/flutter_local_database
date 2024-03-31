import 'package:equatable/equatable.dart';

class Async<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final bool successWithoutData;
  final bool? loading;

  const Async._(
      {required this.data,
      required this.errorMessage,
      required this.successWithoutData,
      required this.loading});

  const Async.initial()
      : this._(
            data: null,
            errorMessage: null,
            successWithoutData: false,
            loading: null);

  const Async.loading()
      : this._(
            data: null,
            errorMessage: null,
            successWithoutData: false,
            loading: true);

  const Async.success(T data)
      : this._(
            data: data,
            errorMessage: null,
            successWithoutData: false,
            loading: false);

  const Async.successWithoutData()
      : this._(
            data: null,
            errorMessage: null,
            successWithoutData: true,
            loading: false);

  const Async.failure(String errorMessage)
      : this._(
            data: null,
            errorMessage: errorMessage,
            successWithoutData: false,
            loading: false);

  bool get isLoading => loading ?? false;

  bool get isSuccess =>
      (successWithoutData || data != null) && (errorMessage == null);

  bool get isFailure => errorMessage != null;

  @override
  List<Object?> get props => [data, errorMessage, successWithoutData, loading];
}
