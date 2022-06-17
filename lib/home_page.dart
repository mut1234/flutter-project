import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Center(
          child: Column(
            children: [
              const Text('Student App', style: TextStyle(fontSize: 50.0)),
              Image.asset('images/logo.ico')
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Student App',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Student List'),
              onTap: () {
                Navigator.popAndPushNamed(context, "/StudentList");
              },
            )
          ],
        ),
      ),
    );
  }

  
}
