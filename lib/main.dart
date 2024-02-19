import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter CRUD Operations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // useMaterial3: true, // Removed for simplicity, you can uncomment if needed
      ),
      home: const MyHomePage(title: 'Flutter CRUD Operations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = Hive.box('myBox');

  void writeData() async {
    await box.put(2, 'Rahul');
    setState(() {}); // Update UI after writing data
  }

  void readData() {
    setState(() {
      // No need to do anything here if UI should update with writeData()
    });
  }

  void updateData() async {
    await box.put(2, 'Sanjeev');
    setState(() {}); // Update UI after updating data
  }

  void deleteData() async {
    await box.delete(2);
    setState(() {}); // Update UI after deleting data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: writeData,
              child: const Text(' Create '),
            ),
            ElevatedButton(
              onPressed: readData,
              child: const Text('  Read  '),
            ),
            ElevatedButton(
              onPressed: updateData,
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: deleteData,
              child: const Text(' Delete '),
            ),
            const SizedBox(height: 20),
            Text(
              box.get(2, defaultValue: 'No Data Found'),
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
