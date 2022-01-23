import 'package:flutter/cupertino.dart';

class PickerWithSearchField extends StatefulWidget {
  const PickerWithSearchField({
    Key? key,
    required this.list,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  final List<String> list;
  final Function(String title) onSelectedItemChanged;

  @override
  State<PickerWithSearchField> createState() => _PickerWithSearchFieldState();
}

class _PickerWithSearchFieldState extends State<PickerWithSearchField> {
  List<String> filteredList = [];

  TextEditingController searchController = TextEditingController();
  FixedExtentScrollController scrollController = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
      ),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          CupertinoTextField(
            autofocus: true,
            padding: const EdgeInsets.all(20),
            placeholder: 'Поиск..',
            controller: searchController,
            onChanged: (text) {
              filteredList = widget.list
                  .where(
                    (e) => e.toLowerCase().startsWith(text.toLowerCase()),
                  )
                  .toList();

              setState(() {
                filteredList;
              });

              if (filteredList.isNotEmpty) {
                widget.onSelectedItemChanged(
                  filteredList.first,
                );

                scrollController.jumpToItem(
                  filteredList.indexWhere(
                    (b) => b == filteredList.first,
                  ),
                );
              }
            },
          ),
          Expanded(
            child: CupertinoPicker.builder(
              scrollController: scrollController,
              childCount: filteredList.isEmpty
                  ? widget.list.length
                  : filteredList.length,
              itemExtent: 60,
              onSelectedItemChanged: (index) {
                final String title = filteredList.isEmpty
                    ? widget.list[index]
                    : filteredList[index];

                widget.onSelectedItemChanged(
                  title,
                );
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    filteredList.isEmpty
                        ? widget.list[index]
                        : filteredList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
