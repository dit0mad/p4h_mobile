import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/controllers/tab_controller.dart' as controller;
import 'package:p4h_mobile/screens/discussion.dart';
import 'package:p4h_mobile/screens/messages.dart';
import 'package:p4h_mobile/screens/profile.dart';
import 'package:p4h_mobile/screens/resource_screens/resource_screen.dart';

class Dashboard extends StatelessWidget {
  static const routeName = 'DashBoard Screen';
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller.TabController tabController =
        Get.put(controller.TabController());
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Center(
                      child: Text(
                    tabController.title.value,
                    style: headlineStyle1,
                  ))),
              TabBar(
                width: width,
                tabController: tabController,
              ),
              Obx(() => SizedBox(
                    child: IndexedStack(
                        index: tabController.index.value,
                        children: const [
                          Profile(),
                          Messages(),
                          ResourceScreen(),
                          DiscussionScreen()
                          // Returns(),
                          // Profile(),
                        ]),
                    //show screen according to index
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBar extends StatelessWidget {
  const TabBar({
    Key? key,
    required this.width,
    required this.tabController,
  }) : super(key: key);

  final double width;
  final controller.TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[800],
      height: 45,
      width: width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                (Icons.question_mark_outlined),
                color: Colors.black,
                size: 15,
              ),
            ),
          ),
          BuildTabButton(
            tabController: tabController,
            title: 'Mwen',
            index: 0,
          ),
          BuildTabButton(
            tabController: tabController,
            title: 'Pale',
            index: 1,
          ),
          BuildTabButton(
            tabController: tabController,
            title: 'Resous',
            index: 2,
          ),
          BuildTabButton(
            tabController: tabController,
            title: 'Diskisyon',
            index: 3,
          ),
          Container(
            height: 90,
            width: 30,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(5)),
            child: const DropdownList(),
          )
        ],
      ),
    );
  }
}

class BuildTabButton extends StatefulWidget {
  const BuildTabButton({
    Key? key,
    required this.tabController,
    required this.title,
    required this.index,
  }) : super(key: key);

  final controller.TabController tabController;
  final String title;
  final int index;

  @override
  State<BuildTabButton> createState() => _BuildTabButtonState();
}

class _BuildTabButtonState extends State<BuildTabButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(2.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  widget.tabController.index.value == widget.index
                      ? widget.tabController.color.value
                      : Colors.white),
              foregroundColor: MaterialStateProperty.all(
                Colors.black,
              ),
            ),
            onPressed: () {
              widget.tabController.changeIndex(widget.index);
            },
            child: Text(widget.title),
          ),
        ));
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({Key? key}) : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  List<String> list = <String>[
    'Opyson #1',
    'Opyson #2',
    'Opyson #3',
    'Opyson #4',
    'Opyson #5',
    'Opyson #6',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        child: DropdownButton<String>(
          icon: const Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(Icons.menu),
          ),
          elevation: 16,
          isExpanded: true,
          onChanged: (value) {
            // This is called when the user selects an item.
            setState(() {});
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: FittedBox(
                  child: Text(
                value,
                style: headlineStyle2,
              )),
            );
          }).toList(),
        ),
      ),
    );
  }
}
