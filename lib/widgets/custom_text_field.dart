import 'package:flutter/material.dart';
import 'package:p4h_mobile/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: mainFillColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              labelText: 'Search Resous',
              hintStyle: Theme.of(context).textTheme.subtitle1),
        ),
      ),
    );
  }
}
