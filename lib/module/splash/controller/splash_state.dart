part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashStateInitial extends SplashState {
  const SplashStateInitial();
}

class SplashStateLoading extends SplashState {
  const SplashStateLoading();
}

class SplashStateError extends SplashState {
  final String meg;
  final int statusCode;
  const SplashStateError(this.meg, this.statusCode);
}

class SplashStateLoaded extends SplashState {
  final String value;
  const SplashStateLoaded(this.value);
}
