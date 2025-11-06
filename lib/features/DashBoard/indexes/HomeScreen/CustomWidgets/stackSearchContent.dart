import 'package:flutter/material.dart';
import 'package:smartrip/features/Login/customwidgets/textfields.dart';

class SearchOverlayWidget extends StatefulWidget {
  final TextEditingController controller;
  final double statusBarHeight;
  final VoidCallback onClose;
  final Function(String)? onResultTap;

  final List<String> allItems;

  const SearchOverlayWidget({
    super.key,
    required this.controller,
    required this.statusBarHeight,
    required this.onClose,
    required this.allItems,
    this.onResultTap,
  });

  @override
  State<SearchOverlayWidget> createState() => _SearchOverlayWidgetState();
}

class _SearchOverlayWidgetState extends State<SearchOverlayWidget> {
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.allItems;

    widget.controller.addListener(_filterList);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_filterList);
    super.dispose();
  }

  void _filterList() {
    final query = widget.controller.text.toLowerCase();

    setState(() {
      filteredItems =
          widget.allItems
              .where((item) => item.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: widget.onClose,
        child: Container(
          color: Colors.black.withOpacity(0.4),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            top: widget.statusBarHeight,
            left: 15,
            right: 15,
          ),
          width: double.infinity,
          height: double.infinity,
          child: GestureDetector(
            onTap: () {}, // Prevent close on inner tap
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      title: '',
                      hintText: 'Search....',
                      controller: widget.controller,
                      onFieldSubmitted: (_) => widget.onClose(),
                    ),
                    // TextField(
                    //   controller: widget.controller,
                    //   autofocus: true,
                    //   decoration: InputDecoration(
                    //     hintText: "Search...",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    //   onSubmitted: (_) => widget.onClose(),
                    // ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 500),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder:
                            (context, index) => ListTile(
                              title: Text(filteredItems[index]),
                              onTap: () {
                                widget.onResultTap?.call(filteredItems[index]);
                                widget.onClose();
                              },
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
