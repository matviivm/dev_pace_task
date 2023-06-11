import 'dart:async';

import 'package:dev_pace_task/domain/items_repository.dart';

import 'items_state.dart';

abstract class ItemsBloc {
  Stream<ItemsState> get items;

  Future<void> addItem();

  Future<void> removeItem();

  void dispose();
}

class ItemsBlocImpl implements ItemsBloc {
  final ItemsRepository _repository = ItemsRepositoryImpl();

  final StreamController<ItemsState> _items = StreamController();

  @override
  Future<void> addItem() async {
    _items.add(ItemsLoadingState());
    try {
      await _repository.addItem();
      _items.add(ItemsLoadedState(_repository.getItems()));
    } catch (_) {
      _items.add(ItemsLoadingErrorState('Please try to add more items'));
    }
  }

  @override
  Stream<ItemsState> get items => _items.stream;

  @override
  Future<void> removeItem() async {
    _items.add(ItemsLoadingState());
    await _repository.removeItem();
    _items.add(ItemsLoadedState(_repository.getItems()));
  }

  @override
  void dispose() {
    _items.close();
  }
}
