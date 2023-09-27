import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/module/home/model/home_model.dart';
import 'package:newsapp/module/home/repository/home_repository.dart';

part 'home_controller_state.dart';

class HomeControllerCubit extends Cubit<HomeControllerState> {
  HomeControllerCubit(HomeRepository homeRepository)
      : _homeRepository = homeRepository,
        super(HomeControllerLoading()) {
    getHomeData();
  }

  final HomeRepository _homeRepository;
  final searchController = TextEditingController();

  HomeModel? homeModel;


  Future<void> getHomeData() async {
    emit(HomeControllerLoading());
    final result = await _homeRepository.getHomeData();

    result.fold((failure) {
      emit(HomeControllerError(errorMessage: failure.message));
    }, (data) {
      homeModel = data;
      emit(HomeControllerLoaded(homeModel: data));
    });
  }

}
