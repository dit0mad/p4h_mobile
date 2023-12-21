import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double fieldSize;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.fieldSize,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red, // Set your desired focus border color
                      width: 2.0, // Set your desired border width
                    ),
                  ),
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
