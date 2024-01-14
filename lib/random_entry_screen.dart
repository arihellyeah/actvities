import 'package:flutter/material.dart';
import 'entry_model.dart';
import 'dart:math';

class RandomEntryScreen extends StatefulWidget {
  final List<Entry> entries;

  RandomEntryScreen({Key? key, required this.entries}) : super(key: key);

  @override
  _RandomEntryScreenState createState() => _RandomEntryScreenState();
}

class _RandomEntryScreenState extends State<RandomEntryScreen> {
  Entry? _randomEntry;
  // String? _selectedCategory = 'Any';
  String? _selectedEffortLevel = 'Any';
  String? _selectedCost = 'Any';
  String? _selectedDuration = 'Any';

  // Define the options for effort and cost
  final List<String> _effortLevels = ['Any', 'Low', 'Medium', 'High'];
  final List<String> _costOptions = ['Any', '0 - 100', '101 - 500', '500+'];
  final List<String> _duration = [
    'Any',
    '< 1h', 
    '1h - 4h', 
    '4h - 12h',
    'all day',
    'weekend',
    'long term',
      ];

  //   List<String> _getUniqueCategories() {
  //   Set<String> categories = {'Any'};
  //   for (var entry in widget.entries) {
  //     categories.add(entry.category);
  //   }
  //   return categories.toList();
  // }

void _generateRandomEntry() {
  final random = Random();
  List<Entry> filteredEntries = widget.entries;

  // Apply filters
  // if (_selectedCategory != 'Any') {
  //   filteredEntries = filteredEntries.where((entry) => entry.category == _selectedCategory).toList();
  // }

  if (_selectedEffortLevel != 'Any') {
    filteredEntries = filteredEntries.where((entry) => entry.effortLevel == _selectedEffortLevel).toList();
  }

  if (_selectedCost != 'Any') {
    filteredEntries = filteredEntries.where((entry) => entry.cost == _selectedCost).toList();
  }

    if (_selectedDuration != 'Any') {
    filteredEntries = filteredEntries.where((entry) => entry.duration == _selectedDuration).toList();
  }

  // Clear previous result
  setState(() {
    if (filteredEntries.isNotEmpty) {
      _randomEntry = filteredEntries[random.nextInt(filteredEntries.length)];
    } else {
      _randomEntry = null; // Reset _randomEntry if no matches
    }
  });
}


@override
Widget build(BuildContext context) {
  // List<String> categoryOptions = _getUniqueCategories();

  return Scaffold(
    appBar: AppBar(title: Text('Random Entry Generator')),
    body: Column(
      children: [
        // // Dropdown for Category
        // DropdownButtonFormField<String>(
        //   value: _selectedCategory,
        //   decoration: InputDecoration(labelText: 'Category'),
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       _selectedCategory = newValue;
        //     });
        //   },
        //   items: categoryOptions.map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // ),

        // Dropdown for Effort Level
        DropdownButtonFormField<String>(
          value: _selectedEffortLevel,
          decoration: InputDecoration(labelText: 'Effort Level'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedEffortLevel = newValue;
            });
          },
          items: _effortLevels.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        // Dropdown for Duration Level
        DropdownButtonFormField<String>(
          value: _selectedDuration,
          decoration: InputDecoration(labelText: 'Duration'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedDuration = newValue;
            });
          },
          items: _duration.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        // Dropdown for Cost
        DropdownButtonFormField<String>(
          value: _selectedCost,
          decoration: InputDecoration(labelText: 'Cost'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCost = newValue;
            });
          },
          items: _costOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        // Button to generate random entry
        ElevatedButton(
          onPressed: _generateRandomEntry,
          child: Text('Generate Random Entry'),
        ),

        // Display the random entry details
        if (_randomEntry != null) ...[
          Text('Name: ${_randomEntry!.name}'),
          Text('Description: ${_randomEntry!.description}'),
          Text('Category: ${_randomEntry!.category}'),
          Text('Effort: ${_randomEntry!.effortLevel}'),
          Text('Cost: ${_randomEntry!.cost}'),
          // Other details...
        ],
      ],
    ),
  );
}
  }
