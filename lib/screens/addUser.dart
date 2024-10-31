// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sqflite_crud/models/student_model.dart';
// import 'package:sqflite_crud/services/student_database.dart';
// import 'package:image_picker/image_picker.dart';

// class AddUser extends StatefulWidget {
//   const AddUser({super.key});

//   @override
//   State<AddUser> createState() => _AddUserState();
// }

// class _AddUserState extends State<AddUser> {
//   final _nameController = TextEditingController();
//   final _nisnController = TextEditingController();
//   final _birthDateController = TextEditingController();
//   final _studentDb = StudentDatabase.instance;
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker(); // Initialize only once

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New User'),
//         centerTitle: true,
//         backgroundColor: Colors.purple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildLabel('Nama Siswa'),
//               _buildTextField(_nameController, 'Masukkan Nama'),
//               const SizedBox(height: 20),
//               _buildLabel('NISN Siswa'),
//               _buildTextField(_nisnController, 'Masukkan NISN'),
//               const SizedBox(height: 20),
//               _buildLabel('Tanggal Lahir'),
//               GestureDetector(
//                 onTap: _selectDate,
//                 child: AbsorbPointer(
//                   child: _buildTextField(
//                     _birthDateController,
//                     'Pilih Tanggal Lahir',
//                     suffixIcon: Icons.calendar_today,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildPhotoUploader(),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _saveStudent,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     backgroundColor: Colors.purple,
//                   ),
//                   child: const Text('Tambah'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to select date
//   Future<void> _selectDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked); // Fixed typo in date format
//       });
//     }
//   }

//   // Function to pick image
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to save student data
//   Future<void> _saveStudent() async {
//     if (_nameController.text.isEmpty || _nisnController.text.isEmpty || _birthDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields'))
//       );
//       return;
//     }

//     final student = Student(
//       name: _nameController.text,
//       nisn: _nisnController.text,
//       birthDate: _birthDateController.text,
//       photoPath: _imageFile?.path,
//     );

//     await _studentDb.insertStudent(student);
//     _clearFields();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Student Added'))
//     );
//   }

//   // Function to clear form fields
//   void _clearFields() {
//     _nameController.clear();
//     _nisnController.clear();
//     _birthDateController.clear();
//     setState(() {
//       _imageFile = null;
//     });
//   }

//   // Helper to build labels
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(fontSize: 18),
//     );
//   }

//   // Helper to build text fields
//   Widget _buildTextField(TextEditingController controller, String hintText, {IconData? suffixIcon}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//         filled: true,
//         fillColor: Colors.grey[200],
//       ),
//     );
//   }

//   // Helper to build photo uploader
//   Widget _buildPhotoUploader() {
//     return Center(
//       child: Column(
//         children: [
//           const Text('Unggah Foto Profil', style: TextStyle(fontSize: 10)),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: _pickImage,
//             child: CircleAvatar(
//               radius: 50,
//               backgroundImage: _imageFile != null
//                   ? FileImage(_imageFile!)
//                   : const AssetImage('assets/placeholder.png') as ImageProvider,
//               child: _imageFile == null
//                   ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
//                   : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_crud/models/student_model.dart';
import 'package:sqflite_crud/services/student_database.dart';


class AddUser extends StatefulWidget {
 const AddUser({super.key});


 @override
 State<AddUser> createState() => _AddUserState();
}


class _AddUserState extends State<AddUser> {
 final _nameController = TextEditingController();
 final _nisnController = TextEditingController();
 final _birthDateController = TextEditingController();
 final _studentDb = StudentDatabase.instance;
 File? _imageFile;


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text(
         'Add New User',
         style: TextStyle(color: Colors.white),
       ),
       backgroundColor: Colors.purple,
       centerTitle: true,
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             _buildLabel('Nama Siswa'),
             _buildTextField(_nameController, 'Masukkan Nama'),
             SizedBox(height: 20),
             _buildLabel('NISN Siswa'),
             _buildTextField(_nisnController, 'Masukan NSIN'),
             SizedBox(height: 20),
             _buildLabel('Tanggal Lahir'),
             GestureDetector(
               onTap: _selectDate,
               child: AbsorbPointer(
                 child: _buildTextField(
                   _birthDateController,
                   'Pilih Tanggal Lahir',
                   suffixIcon: Icons.calendar_today,
                 ),
               ),
             ),
             const SizedBox(height: 20),
             _buildPhotoUploader(),
             const SizedBox(height: 20),
             Center(
               child: ElevatedButton(
                 onPressed: _saveStudent,
                 style: ElevatedButton.styleFrom(
                   padding: const EdgeInsets.symmetric(
                       horizontal: 40, vertical: 15),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),
                   backgroundColor: Colors.purple,
                 ),
                 child: const Text(
                   'Tambah',
                   style: TextStyle(color: Colors.white),
                 ),
               ),
             )
           ],
         ),
       ),
     ),
   );
 }


 // Fungsi untuk memilih tanggal
 Future<void> _selectDate() async {
   DateTime? picked = await showDatePicker(
     context: context,
     initialDate: DateTime.now(),
     firstDate: DateTime(1900),
     lastDate: DateTime.now(),
   );
   if (picked != null) {
     setState(() {
       _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
     });
   }
 }


 // Fungsi untuk memilih gambar
 Future<void> _pickImage() async {
   final pickedFile =
       await ImagePicker().pickImage(source: ImageSource.gallery);
   if (pickedFile != null) {
     setState(() {
       _imageFile = File(pickedFile.path);
     });
   }
 }


 // Fungsi untuk menyimpan data siswa
 Future<void> _saveStudent() async {
   final student = Student(
     name: _nameController.text,
     nisn: _nisnController.text,
     birthDate: _birthDateController.text,
     photoPath: _imageFile?.path,
   );


   await _studentDb.insertStudent(student);
   _clearFields();
   ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Siswa Ditambahkan!')),
   );
 }


 // Fungsi untuk mengosongkan field setelah simpan
 void _clearFields() {
   _nameController.clear();
   _nisnController.clear();
   _birthDateController.clear();
   setState(() {
     _imageFile = null;
   });
 }


 // Fungsi untuk membangun label
 Widget _buildLabel(String text) {
   return Text(text, style: TextStyle(fontSize: 18));
 }


 // Fungsi untuk membangun TextField
 Widget _buildTextField(TextEditingController controller, String hintText,
     {IconData? suffixIcon}) {
   return TextField(
     controller: controller,
     decoration: InputDecoration(
       hintText: hintText,
       suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
       filled: true,
       fillColor: Colors.grey[200],
     ),
   );
 }


 // Fungsi untuk upload foto
 Widget _buildPhotoUploader() {
   return Center(
     child: Column(
       children: [
         const Text('Unggah Foto Profil', style: TextStyle(fontSize: 18)),
         const SizedBox(height: 10),
         GestureDetector(
           onTap: _pickImage,
           child: CircleAvatar(
             radius: 50,
             backgroundImage: _imageFile != null
                 ? FileImage(_imageFile!)
                 : const AssetImage('assets/placeholder.png') as ImageProvider,
             child: _imageFile == null
                 ? const Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                 : null,
           ),
         ),
       ],
     ),
   );
 }
}



