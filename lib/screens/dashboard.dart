import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p4h_mobile/constants.dart';
import 'package:p4h_mobile/controllers/tab_controller.dart' as controller;
import 'package:p4h_mobile/screens/discussion.dart';
import 'package:p4h_mobile/screens/messages.dart';
import 'package:p4h_mobile/screens/profile_screen/profile_main.dart';
import 'package:p4h_mobile/screens/resource_screens/resource_screen.dart';

class Dashboard extends StatelessWidget {
  static const routeName = 'DashBoard Screen';
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller.TabController tabController =
        Get.put(controller.TabController());

    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Center(
                  child: Text(
                    tabController.title.value,
                    style: headlineStyle1,
                  ),
                ),
              ),
              TabBar(
                tabController: tabController,
              ),
              Expanded(
                child: Obx(() => IndexedStack(
                        index: tabController.index.value,
                        children: const [
                          ProfileState(),
                          Messages(),
                          ResourceScreenMediator(),
                          DiscussionScreen(),
                        ])),
              ),
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
    required this.tabController,
  }) : super(key: key);

  final controller.TabController tabController;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Material(
      child: Ink(
        padding: const EdgeInsets.all(12),
        height: mq.size.height * 0.07,
        color: Colors.red[800],
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
              Ink(width: 28, child: const DropdownList())
            ],
          ),
        ),
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
    return DropdownButton<String>(
      icon: const Padding(
        padding: EdgeInsets.only(right: 2),
        child: Icon(Icons.menu),
      ),
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
    );
  }
}
