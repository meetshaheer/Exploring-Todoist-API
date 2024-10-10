// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main(List<String> args) {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ProjectListScreen(),
//     );
//   }
// }

// class TodoistApiService {
//   final String _apiToken = '92597cf179f1f165cd93b7501d1114e956408ea5'; // Your API token here
//   final String _baseUrl = 'https://api.todoist.com/rest/v2';

//   Map<String, String> _headers() {
//     return {
//       'Authorization': 'Bearer $_apiToken',
//       'Content-Type': 'application/json',
//     };
//   }

//   // Fetch all projects
//   Future<List<dynamic>> getProjects() async {
//     var url = Uri.parse('$_baseUrl/projects');
//     var response = await http.get(url , headers: _headers());
//     var responsebody = jsonDecode(response.body);
//     return responsebody;
//   }

//   // Fetch tasks for a specific project
//   Future<List<dynamic>> getTasks(String projectId) async {
//     var url = Uri.parse('$_baseUrl/tasks?project_id=$projectId');
//     var response = await http.get(url, headers: _headers());
//     var responsebody = jsonDecode(response.body);
//     return responsebody;
//   }
// }

// class ProjectListScreen extends StatefulWidget {
//   @override
//   _ProjectListScreenState createState() => _ProjectListScreenState();
// }

// class _ProjectListScreenState extends State<ProjectListScreen> {
//   final TodoistApiService apiService = TodoistApiService();
//   List<dynamic> projects = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProjects();
//   }

//   Future<void> fetchProjects() async {
//     try {
//       final projectList = await apiService.getProjects();
//       setState(() {
//         projects = projectList;
//       });
//     } catch (e) {
//       print('Error fetching projects: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todoist Projects'),
//       ),
//       body: projects.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: projects.length,
//               itemBuilder: (context, index) {
//                 final project = projects[index];
//                 return ListTile(
//                   title: Text(project['name']),
//                   onTap: () {
//                     // Navigate to the Task screen when a project is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             TaskListScreen(projectId: project['id'].toString(), projectName: project['name']),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

// class TaskListScreen extends StatefulWidget {
//   final String projectId;
//   final String projectName;

//   TaskListScreen({required this.projectId, required this.projectName});

//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }

// class _TaskListScreenState extends State<TaskListScreen> {
//   final TodoistApiService apiService = TodoistApiService();
//   List<dynamic> tasks = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTasks();
//   }

//   Future<void> fetchTasks() async {
//     try {
//       final taskList = await apiService.getTasks(widget.projectId);
//       setState(() {
//         tasks = taskList;
//       });
//     } catch (e) {
//       print('Error fetching tasks: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks for ${widget.projectName}'),
//       ),
//       body: tasks.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 final task = tasks[index];
//                 return ListTile(
//                   title: Text(task['content']),
//                 );
//               },
//             ),
//     );
//   }
// }

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
                  label: Text("98"),
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
                              height: 100,
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
                                        icon: Icon(Iconsax.trash4)),
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
                                                text: data['created_at'].toString().substring(0, 10),
                                                style: TextStyle(fontFamily: "afac", fontSize: 15, color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
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
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: addtitle,
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Iconsax.pen_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
