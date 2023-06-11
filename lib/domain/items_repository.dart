import 'package:dev_pace_task/data/items_data_provider.dart';

abstract class ItemsRepository {
  List<String> getItems();

  Future<void> addItem();

  Future<void> removeItem();
}

class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsDataProvider _dataProvider = ItemsDataProviderImpl();
  @override
  Future<void> addItem() => _dataProvider.addItem();

  @override
  List<String> getItems() => _dataProvider.getItems();

  @override
  Future<void> removeItem() => _dataProvider.removeItem();
}
