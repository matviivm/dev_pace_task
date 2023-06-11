import 'dart:math';

abstract class ItemsDataProvider {
  List<String> getItems();

  Future<void> addItem();

  Future<void> removeItem();
}

class ItemsDataProviderImpl implements ItemsDataProvider {
  final List<String> _initialItems = [];

  final List<String> _possibleItemsName = [
    'Android',
    'Windows',
    'iOS',
    'Linux',
    'Laptop',
    'PC'
  ];

  final _random = Random();

  @override
  Future<void> addItem() async {
    await Future.delayed(const Duration(milliseconds: 250));
    _initialItems.add(
      _possibleItemsName[_random.nextInt(_possibleItemsName.length)],
    );
    if (_initialItems.length == 3) {
      throw Exception("Can't be added more items");
    }
  }

  @override
  List<String> getItems() => _initialItems;

  @override
  Future<void> removeItem() async {
    await Future.delayed(const Duration(milliseconds: 250));
    _initialItems.removeLast();
  }
}
