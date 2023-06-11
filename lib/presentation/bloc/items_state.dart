abstract class ItemsState {}

class ItemsLoadingState implements ItemsState {}

class ItemsLoadedState implements ItemsState {
  ItemsLoadedState(this.items);

  final List<String> items;
}

class ItemsLoadingErrorState implements ItemsState {
  ItemsLoadingErrorState(this.errorMessage);

  final String errorMessage;
}
