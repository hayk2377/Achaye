import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';


class SlideImage extends StatefulWidget {
  Map<String, Object> userData;

  SlideImage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  _SlideImageState createState() => _SlideImageState(userData);
}

class _SlideImageState extends State<SlideImage> {
  File? _selectedImage;
  String? selectedReligion;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  _SlideImageState(Map<String, Object> userData);

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: Color(0xFFFF7F50),
      ),
      body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child:Form(
          key:_formKey,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'We are almost done !',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20,),
          const Text(
              'Religious Preference:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedReligion,
              hint: const Text('Select Religion'),
              onChanged: (newValue) {
                setState(() {
                  selectedReligion = newValue!;
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'Orthodox',
                  child: Text('Orthodox'),
                ),
                DropdownMenuItem<String>(
                  value: 'Muslim',
                  child: Text('Muslim'),
                ),
                DropdownMenuItem<String>(
                  value: 'Catholic',
                  child: Text('Catholic'),
                ),
                DropdownMenuItem<String>(
                  value: 'Protestant',
                  child: Text('Protestant'),
                ),
                DropdownMenuItem<String>(
                  value: 'Other',
                  child: Text('Other'),
                ),
                DropdownMenuItem<String>(
                  value: 'Atheist',
                  child: Text('Atheist'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a religion';
                }
                return null;
              },
            ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: _selectedImage != null
                ? const Text('you have selected')
                : const Text('No image selected'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _selectImage,
            child: const Text('Select Image'),
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          ElevatedButton(
            onPressed:()=> context.go('/pagethree'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF7F50)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: const Text('Previous'),
          ),
          ElevatedButton(      
            onPressed: () {
              final form = _formKey.currentState;
                        if (form!.validate()) {
                          if (_selectedImage != null) {
                            widget.userData['imageFilePath'] = _selectedImage!.path;
                            widget.userData['religiousPreferences'] = _selectedImage!.path;

                            context.go('/pagefour');

                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('please provide an image'),
                              ),
                            );
                          }
            };},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: const Text('Next'),
          ),
          ]),
        ],
      ),
    ),));
  }
}