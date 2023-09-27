import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/module/splash/repository/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final _className = 'AppSettingCubit';
  final SplashRepository _splashRepository;

  SplashCubit(SplashRepository appSettingRepository)
      : _splashRepository = appSettingRepository,
        super(const SplashStateInitial()) {
    init();
  }

  bool get isOnBoardingShown =>
      _splashRepository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<bool> cacheOnBoarding() async {
    final result = await _splashRepository.cacheOnBoarding();

    return result.fold((l) => false, (success) => success);
  }

  void init() {
    emit(const SplashStateInitial());

    String? data;

    Future.delayed(const Duration(seconds: 5),() {
      data = 'Loaded';
      emit(SplashStateLoaded(data.toString()));
    });
  }

}
