import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final double fieldSize;

  const CustomSearchField({
    Key? key,
    required this.hintText,
    required this.fieldSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SizedBox(
            height: fieldSize,
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 20,
                    onPressed: () {},
                    constraints:
                        const BoxConstraints(minHeight: 36, minWidth: 36),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    iconSize: 20,
                    onPressed: () {
                      controller.clear();
                    },
                    constraints:
                        const BoxConstraints(minHeight: 36, minWidth: 36),
                  ),
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  filled: true,
                  fillColor: searchBarColor,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  hintStyle: subtitle4,
                )),
          )),
    );
  }
}
