import 'dart:convert';
import 'dart:io';

import 'package:backup_mobile_smt4/screens_meja/meja.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Forms_meja extends StatefulWidget {
  const Forms_meja({Key? key}) : super(key: key);

  @override
  State<Forms_meja> createState() => _Forms_mejaState();
}

class _Forms_mejaState extends State<Forms_meja> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      final url = Uri.parse("http://192.168.1.26:8080/api/mejas");
      final request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image_meja', _image!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        print("Image uploaded successfully");
      } else {
        print("Failed to upload image. Error: ${response.reasonPhrase}");
      }
    } else {
      print("No image selected");
    }
  }

  TextEditingController date = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _telpController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();

  Future saveMeja() async {
    final response = await http.post(
      Uri.parse("http://192.168.1.26:8080/api/mejas"),
      body: {
        "nama_meja": _namaController.text,
        "alamat_meja": _alamatController.text,
        "telp_meja": _telpController.text,
        "deskripsi_meja": _deskripsiController.text,
        "tanggal_meja": date.text,
        "harga_meja": _hargaController.text,
        "image_meja": _image != null ? _image!.path : ""
      },
    );
    print(response.body);

    return json.decode(response.body);
  }

  @override
  void initState() {
    date.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF42454E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF42454E),
        elevation: 0,
        title: Text(
          "Tambahkan Data Meja",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xFFF9683A),
          ),
        ),
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _pickedFile != null
                  ? Image.file(
                      File(_pickedFile!.path),
                    )
                  : Text(
                      "Masukan gambar meja",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text(
                  "Pilih Gambar",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF9683A),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _telpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "No. Telp",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Harga",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF676B77),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: date,
                  onTap: () async {
                    var dateValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: Color(0xFFF9683A),
                              onPrimary: Colors.white,
                              surface: Color(0xFFF9683A),
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (dateValue != null) {
                      setState(() {
                        date.text = DateFormat('yyyy-MM-dd').format(dateValue);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Tanggal Meja",
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF676B77),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF9683A),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await saveMeja();
                  await _uploadImage();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Mejas()),
                  );
                },
                child: Text(
                  "Tambah Meja",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF9683A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
