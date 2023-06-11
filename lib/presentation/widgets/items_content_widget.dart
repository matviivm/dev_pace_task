import 'package:dev_pace_task/presentation/bloc/items_state.dart';
import 'package:flutter/material.dart';

class ItemsContentWidget extends StatelessWidget {
  const ItemsContentWidget({
    Key? key,
    required this.itemsState,
  }) : super(key: key);

  final ItemsState? itemsState;
  @override
  Widget build(BuildContext context) {
    late final Widget contentWidget;

    switch (itemsState.runtimeType) {
      case ItemsLoadingState:
        contentWidget = const Center(
          child: CircularProgressIndicator(),
        );

      case ItemsLoadingErrorState:
        contentWidget =
            Text((itemsState as ItemsLoadingErrorState).errorMessage);
      case ItemsLoadedState:
        final itemsList = itemsState as ItemsLoadedState;
        contentWidget = itemsList.items.isEmpty
            ? const Text('Items list is empty')
            : GridView.count(
                shrinkWrap: true,
                childAspectRatio: 2,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                physics: const NeverScrollableScrollPhysics(),
                children: itemsList.items
                    .map(
                      (itemName) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3),
                        ),
                        child: Center(
                          child: Text(itemName),
                        ),
                      ),
                    )
                    .toList(),
              );
      default:
        contentWidget = const Text('Items list is empty');
    }
    return contentWidget;
  }
}
