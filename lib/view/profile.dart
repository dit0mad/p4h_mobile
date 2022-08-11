import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent[400],
                    radius: 40,
                    backgroundImage: const NetworkImage(
                        'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                  ),
                ), //C

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Berthrude Albert',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'I work for P4H Global',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.green;
                            }

                            return Colors.red; // Use the component's default.
                          },
                        ),
                      ),
                      // style: ,
                      child: const Text('pwogre mwen'),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print('touched');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: const [
                          Icon(
                            (Icons.camera_alt),
                            color: Colors.black,
                            size: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Mwen Foto \n or Videyo',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: const [
                          Icon(
                            (Icons.contact_page),
                            color: Colors.black,
                            size: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Mwen \n Dokiman',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 1.0, left: 4),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Prowfil Pos',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const Searchbar(),
          ],
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        Container(
          padding: EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      backgroundColor: Colors.greenAccent[400],
                      radius: 40,
                      backgroundImage: const NetworkImage(
                          'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
                    ),
                  ), //C

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '2:11',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            '03/07/2019',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Text('Felisitasyon soti P4H'),
              //TODO: implement collapsible comment
              Container(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.green;
                            }

                            return Colors.red; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Commment'),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Searchbar extends StatelessWidget {
  //TODO: implement searchbar
  const Searchbar({
    Key? key,
    //required this.controller,
  }) : super(key: key);

  // final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0),
      child: Container(
        width: 200,
        color: Colors.white,
        //margin: const EdgeInsets.only(top: 90),
        child: TextField(
          // onChanged: (value) => controller.searchProduct(value),
          textAlignVertical: TextAlignVertical.center,
          //  controller: controller.searchhController.value,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(
              10.0,
            ))),
            isDense: true,
            contentPadding: EdgeInsets.zero,
            prefixIconConstraints: const BoxConstraints(
              minHeight: 30,
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
            hintText: "Search Prowfil",
            suffixIconConstraints: const BoxConstraints(
              minHeight: 36,
              minWidth: 36,
            ),
            suffixIcon: IconButton(
              constraints: const BoxConstraints(
                minHeight: 36,
                minWidth: 36,
              ),
              splashRadius: 24,
              icon: const Icon(
                Icons.clear,
              ),
              onPressed: () {
                // controller.searchProduct('');
                // controller.searchhController.value.clear();
              },
            ),
          ),
        ),
      ),
    );
  }
}
