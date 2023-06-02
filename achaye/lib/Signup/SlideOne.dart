import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'DatePicker.dart';

class SlideOne extends StatefulWidget {
  Map<String, Object> userData;

  SlideOne({ required this.userData});

  @override
  _SlideOneState createState() => _SlideOneState(userData);
}

class _SlideOneState extends State<SlideOne> {
  String _selectedSex = '';
  DateTime? _selectedDate;
  final TextEditingController _nameControllerf = TextEditingController();
  final TextEditingController _nameControllerl = TextEditingController();

  Map<String, Object> userData;

  _SlideOneState(this.userData);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameControllerf.dispose();
    _nameControllerl.dispose();

    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: Color(0xFFFF7F50),
      ),
      body: SingleChildScrollView(
        child: Card(
        elevation: 10,
        shadowColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Step 1: Personal Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'First Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
      
                    TextFormField(
                      controller: _nameControllerf,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your First name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 26),
      
                    const Text(
                      'Last Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
      
                    TextFormField(
                      controller: _nameControllerl,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Last name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sex',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedSex,
                          onChanged: (value) {
                            setState(() {
                              _selectedSex = value!;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedSex,
                          onChanged: (value) {
                            setState(() {
                              _selectedSex = value!;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Birthdate',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
      
                    DatePicker(
                      selectedDate: _selectedDate,
                      onDateChanged: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:()=>context.go('/'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF7F50)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _selectedDate != null && _selectedSex.isNotEmpty) {
                          userData['firstName'] = _nameControllerf.text;
                          userData['lastName']=_nameControllerl.text;
                          userData['birthday'] = _selectedDate!;
                          userData['sex'] = _selectedSex;
                          context.go('/pagetwo');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill out the required fields.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          ),
      ),
  );
}
}