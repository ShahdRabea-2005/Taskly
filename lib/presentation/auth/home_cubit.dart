import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    loadTasks();
  }

  var allTasks = [
    {
      'title': 'Finish Flutter assignment',
      'time': '4:00 PM',
      'category': 'Study',
      'priority': 'High',
      'isCompleted': false,
      'type': 'Upcoming',
    },
    {
      'title': 'Team meeting',
      'time': '10:30 AM',
      'category': 'Work',
      'priority': 'Medium',
      'isCompleted': false,
      'type': 'Today',
    },
    {
      'title': 'Morning yoga',
      'time': '7:00 AM',
      'category': 'Health',
      'priority': 'Low',
      'isCompleted': true,
      'type': 'Completed',
    },
  ];

  String currentFilter = 'All';

  void loadTasks() {
    emit(HomeLoaded(selectedFilter: currentFilter, tasks: allTasks));
  }

  void filterTasks(String filter) {
    currentFilter = filter;
    if (filter == 'All') {
      emit(HomeLoaded(selectedFilter: filter, tasks: allTasks));
    } else if (filter == 'Completed') {
      final filtered = allTasks
          .where((task) => task['isCompleted'] == true)
          .toList();
      emit(HomeLoaded(selectedFilter: filter, tasks: filtered));
    } else {
      final filtered = allTasks
          .where((task) => task['type'] == filter || task['category'] == filter)
          .toList();
      emit(HomeLoaded(selectedFilter: filter, tasks: filtered));
    }
  }

  void toggleTaskCompletion(int index) {
    allTasks[index]['isCompleted'] = !(allTasks[index]['isCompleted'] as bool);
    if (allTasks[index]['isCompleted'] == true) {
      allTasks[index]['type'] = 'Completed';
    }
    filterTasks(currentFilter);
  }
}
