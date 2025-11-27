// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:home_ease/features/home/logic/home_state.dart';
import 'package:home_ease/features/categorie/data/models/category_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.initial());

  List categories = [];
  
  // Static categories data
  static final List<Categories> _staticCategories = [
    Categories(id: '1', name: 'Cleaning', path: 'assets/images/cleaning.png'),
    Categories(id: '2', name: 'Plumbing', path: 'assets/images/plumbing.png'),
    Categories(id: '3', name: 'Electrical', path: 'assets/images/electrical.png'),
    Categories(id: '4', name: 'Painting', path: 'assets/images/painting.png'),
    Categories(id: '5', name: 'Carpentry', path: 'assets/images/carpentry.png'),
    Categories(id: '6', name: 'Gardening', path: 'assets/images/gardening.png'),
  ];
  
  Future<void> emitGetCategoriesStates() async {
    emit(const HomeState.getCategoriesLoading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    categories = _staticCategories;
    final categoryModel = CategoryModel(categories: _staticCategories);
    emit(HomeState.getCategoriesSuccess(categoryModel));
  }
}
