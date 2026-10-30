abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final String selectedFilter;
  final dynamic tasks;

  HomeLoaded({required this.selectedFilter, required this.tasks});
}
