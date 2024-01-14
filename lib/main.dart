import 'package:flutter/material.dart';
import 'add_entry_form.dart';
import 'entry_model.dart';
import 'random_entry_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Entry App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Entry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _showAddEntryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return AddEntryForm(
          onEntryAdded: (Entry entry) {
            setState(() {
              _entries.add(entry);
            });
            _saveEntries();
          },
        );
      },
    );
  }

  void _deleteEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
    _saveEntries();
  }

  void _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_entries.map((e) => e.toJson()).toList());
    prefs.setString('entries', encodedData);
  }

  void _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('entries');
    if (encodedData != null) {
      setState(() {
        _entries = (json.decode(encodedData) as List).map((e) => Entry.fromJson(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entries'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RandomEntryScreen(entries: _entries),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_entries[index].name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteEntry(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
