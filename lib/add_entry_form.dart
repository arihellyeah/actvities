import 'package:flutter/material.dart';
import 'entry_model.dart';

class AddEntryForm extends StatefulWidget {
  final Function(Entry) onEntryAdded;

  const AddEntryForm({Key? key, required this.onEntryAdded}) : super(key: key);

  @override
  _AddEntryFormState createState() => _AddEntryFormState();
}

class _AddEntryFormState extends State<AddEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _durationController = TextEditingController();
  final _environmentController = TextEditingController();
  final _seasonController = TextEditingController();

  String _selectedEffortLevel = 'Low'; // Default value
  final List<String> _effortLevels = ['Low', 'Medium', 'High'];

  String _selectedCost = '0 - 100'; // Default value
  final List<String> _cost = ['0 - 100', '101 - 500', '500+'];

  String? _selectedCategory;
  List<String> _categories = [
    'Tech', 
    'Home Projects', 
    'Outing',
    // Add more categories as needed
  ];

    String? _selectedDuration;
  List<String> _duration = [
    '< 1h', 
    '1h - 4h', 
    '4h - 12h',
    'all day',
    'weekend',
    'long term',
    // Add more categories as needed
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _environmentController.dispose();
    _seasonController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onEntryAdded(
        Entry(
          name: _nameController.text,
          description: _descriptionController.text,
          category: _selectedCategory ?? '',
          duration: _selectedDuration ?? '',
          cost: _selectedCost,
          effortLevel: _selectedEffortLevel,
          environment: _environmentController.text,
          season: _seasonController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedEffortLevel,
                decoration: InputDecoration(labelText: 'Effort Level'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEffortLevel = newValue!;
                  });
                },
                items: _effortLevels.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCost,
                decoration: InputDecoration(labelText: 'Cost'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCost = newValue!;
                  });
                },
                items: _cost.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              // // Dropdown for categories
              // DropdownButtonFormField<String>(
              //   value: _selectedCategory,
              //   decoration: InputDecoration(labelText: 'Category'),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedCategory = newValue;
              //     });
              //   },
              //   items: _categories.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a category';
              //     }
              //     return null;
              //   },
              // ),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
