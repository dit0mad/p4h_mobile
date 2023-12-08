import 'package:flutter/material.dart';
import 'package:p4h_mobile/widgets/custom_text_field.dart';

class SearchProfile extends StatefulWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  late final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Search Prowfil',
      fieldSize: 40,
      controller: searchController,
    );
  }
}
