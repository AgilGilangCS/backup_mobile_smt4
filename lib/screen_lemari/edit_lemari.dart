import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Edits_lemari extends StatefulWidget {
  final String idLemari;

  const Edits_lemari({Key? key, required this.idLemari}) : super(key: key);

  @override
  State<Edits_lemari> createState() => _Edits_lemariState();
}

class _Edits_lemariState extends State<Edits_lemari> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      final url = "http://192.168.43.116:8080/api/lemaris/${widget.idLemari}";
      final dio = Dio();

      FormData formData = FormData.fromMap({
        "image_lemari": await MultipartFile.fromFile(
          _image!.path,
          filename: _image!.path.split('/').last,
        ),
      });

      try {
        final response = await dio.put(url, data: formData);
        if (response.statusCode == 200) {
          print("Image uploaded successfully");
        } else {
          print("Failed to upload image. Error: ${response.statusMessage}");
        }
      } catch (e) {
        print("Error uploading image: $e");
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

  Future<void> fetchLemari() async {
    final response = await http.get(
        Uri.parse("http://192.168.43.116:8080/api/lemaris/${widget.idLemari}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'] != null && data['data'].length > 0) {
        final lemari = data['data'];
        if (lemari != null) {
          setState(() {
            _namaController.text = lemari["nama_lemari"].toString();
            _alamatController.text = lemari["alamat_lemari"].toString();
            _telpController.text = lemari["telp_lemari"].toString();
            _deskripsiController.text = lemari["deskripsi_lemari"].toString();
            date.text = lemari["tanggal_lemari"].toString();
            _hargaController.text = lemari["harga_lemari"].toString();
          });
        } else {
          print("No data available");
        }
      } else {
        print("No data available");
      }
    } else {
      print("Failed to fetch lemari. Error: ${response.reasonPhrase}");
    }
  }

  Future<void> saveLemari() async {
    final response = await http.put(
      Uri.parse("http://192.168.43.116:8080/api/lemaris/${widget.idLemari}"),
      body: {
        "nama_lemari": _namaController.text,
        "alamat_lemari": _alamatController.text,
        "telp_lemari": _telpController.text,
        "deskripsi_lemari": _deskripsiController.text,
        "tanggal_lemari": date.text,
        "harga_lemari": _hargaController.text,
        "image_lemari": _image != null ? _image!.path.split('/').last : "",
      },
    );

    return json.decode(response.body);
  }

  @override
  void initState() {
    date.text = "";
    fetchLemari(); // Mengambil data lemari saat inisialisasi
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
          "Edit Data Lemari",
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
              _image != null
                  ? Image.file(
                      _image!,
                    )
                  : Text(
                      "Masukan gambar lemari",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
                ),
                child: TextFormField(
                  controller: _telpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Nomor Telepon",
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
                ),
                child: TextFormField(
                  controller: _deskripsiController,
                  maxLines: 3,
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
                ),
                child: TextFormField(
                  controller: date,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null && picked != DateTime.now()) {
                      setState(() {
                        date.text = DateFormat('yyyy-MM-dd').format(picked);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Tanggal",
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF676B77),
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                  await _uploadImage();
                  await saveLemari();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Simpan",
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
