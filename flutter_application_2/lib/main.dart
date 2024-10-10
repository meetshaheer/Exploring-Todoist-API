import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api-services.dart';
import 'package:flutter_application_1/api.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: apiData(),
    );
  }
}

class apiData extends StatefulWidget {
  const apiData({super.key});

  @override
  State<apiData> createState() => apiDataState();
}

class apiDataState extends State<apiData> {
  TextEditingController addtitle = TextEditingController();
  TextEditingController adddesc = TextEditingController();
  TextEditingController updatetitle = TextEditingController();
  TextEditingController updateesc = TextEditingController();
  final String baseUrl = "https://api.todoist.com/rest/v2";
  final String apiToken = "92597cf179f1f165cd93b7501d1114e956408ea5";
  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
    };
  }

  addtasks() async {
    var url = Uri.parse("$baseUrl/tasks");
    await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(
        {
          'content': addtitle.text,
          'description': adddesc.text,
          'created_at': "2024:10:02",
          'due': {'date': "2024:11:11"}
        },
      ),
    );
    adddesc.clear();
    addtitle.clear();
  }

  updatetasks(String id) async {
    var url = Uri.parse("$baseUrl/tasks/$id");
    var response = await http.put(
      url,
      headers: _headers(),
      body: jsonEncode(
        {
          'content': updatetitle.text,
          'description': updateesc.text,
          'created_at': "2024:10:02",
        },
      ),
    );
    print(response);
    updatetitle.clear();
    updateesc.clear();
  }

  trimTaskName(String content) {
    int trimIndex = content.indexOf('[');

    if (trimIndex == -1) {
      return content;
    }

    return content.substring(0, trimIndex);
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   ApiServices().gettasks();
  // }

  @override
  @override
  Widget build(BuildContext context) {
    var count = ApiServices().gettasks();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 244, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi! Shaheer Ahmed",
                    style: TextStyle(
                      fontFamily: "afac",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Welcome to your desk.",
                    style: TextStyle(
                      fontFamily: "afac",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://shorturl.at/zJTbV",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "My Inbox!",
                  style: TextStyle(
                    fontFamily: "afac",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Expanded(child: Container()),
                const Badge(
                  label: Text("45"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                future: ApiServices().gettasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              height: 121,
                              color: const Color.fromARGB(255, 255, 250, 234),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    trailing: IconButton(
                                        onPressed: () async {
                                          await ApiServices().deletetasks(data['id'] ?? "0");
                                          setState(() {});
                                        },
                                        icon: const Icon(Iconsax.trash4)),
                                    title: Text(
                                      trimTaskName(data['content'] ?? "No Title"),
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: "afac",
                                        fontSize: 18,
                                      ),
                                      softWrap: true,
                                      maxLines: 1,
                                    ),
                                    subtitle: Text(
                                      data['description'] ?? "No description",
                                      style: const TextStyle(
                                          fontFamily: "afac", fontSize: 15, overflow: TextOverflow.ellipsis),
                                      softWrap: true,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, top: 1, right: 15),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Created At: ",
                                            style: TextStyle(fontFamily: "afac", fontSize: 15, color: Colors.black),
                                            children: [
                                              TextSpan(
                                                // 2024-10-02
                                                text: data['created_at'].toString().substring(0, 10),
                                                style: TextStyle(fontFamily: "afac", fontSize: 15, color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              // await updatetasks(snapshot.data?[index] ?? "0");
                                              // setState(() {

                                              // });
                                              updatetitle.text = data['content'];
                                              updateesc.text = data['description'];

                                              showDialog(
                                                context: context,
                                                builder: (BuildContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Update Task",
                                                      style: TextStyle(
                                                        fontFamily: "afac",
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        TextFormField(
                                                          controller: updatetitle,
                                                          decoration: const InputDecoration(
                                                            label: Text("Title"),
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(10),
                                                              ),
                                                              borderSide: BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextFormField(
                                                          controller: updateesc,
                                                          decoration: const InputDecoration(
                                                            label: Text("Description"),
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(10),
                                                              ),
                                                              borderSide: BorderSide(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await updatetasks(data['id'] ?? "0");
                                                          setState(() {});

                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text(
                                                          "Update Task",
                                                          style: TextStyle(
                                                            fontFamily: "afac",
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Iconsax.edit,
                                              size: 20,
                                            )),
                                        Expanded(child: Container()),
                                        Row(
                                          children: [
                                            const Text(
                                              "Due At: ",
                                              style: TextStyle(fontFamily: "afac", fontSize: 15, color: Colors.black),
                                            ),
                                            Badge(
                                              label:
                                                  Text(data?['due']?['date'].toString().substring(0, 10) ?? "No Due"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffB3261D),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertDialog(
                title: const Text(
                  "Add Task",
                  style: TextStyle(
                    fontFamily: "afac",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: addtitle,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: adddesc,
                      decoration: const InputDecoration(
                        label: Text("Description"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      await addtasks();
                      setState(() {});

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Create Task",
                      style: TextStyle(
                        fontFamily: "afac",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(
          Iconsax.pen_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
