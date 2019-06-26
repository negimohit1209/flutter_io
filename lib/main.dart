import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() async {
  var data = await readData(); 
  if(data != null){
    String message = await readData();
    print(message);
  }
  runApp(MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('read/write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(13.4),
          alignment: Alignment.topCenter,
          child: ListTile(
            title: TextField(
              controller: _enterDataField,
              decoration: InputDecoration(labelText: 'write something'),
            ),
            subtitle: FlatButton(
              onPressed: () {
                writeData(_enterDataField.text);
              },
              child: Column(
                children: <Widget>[
                  Text('save data'),
                  Padding(
                    padding: EdgeInsets.all(14.5),
                  ),
                  Text('save data goes here')
                ],
              ),
            ),
          )),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/data.txt');
}

// Write and read from file
Future<File> writeData(String message) async {
  final file = await _localFile;
  //write to file
  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    return file.readAsString();
  } catch (e) {
    return 'nothing saved yet';
  }
}
