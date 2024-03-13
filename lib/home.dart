import 'package:flutter/material.dart';
import 'contactd.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = [];
  int selectedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contact List",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              maxLength: 20,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter your name ",
                  label: const Text("Name "),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: "Enter your mobile no ",
                  label: const Text("Mobile no"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contacts.add(Contact(
                            name: nameController.text.toString(),
                            contact: contactController.text));
                        nameController.clear();
                        contactController.clear();
                      });
                    },
                    child: const Text(
                      "Save",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String contact = contactController.text;
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = name;
                          contactController.text = contact;
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          selectedIndex = -1;
                          nameController.clear();
                          contactController.clear();
                        });
                      }
                    },
                    child: const Text(
                      "Update",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    contacts[index].name,
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(
                                  contacts[index].contact,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            IconButton(
                                onPressed: () {
                                  nameController.text = contacts[index].name;
                                  contactController.text =
                                      contacts[index].contact;
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    contacts.removeAt(index);
                                  });

                                }, icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
