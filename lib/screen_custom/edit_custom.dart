import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Edits_custom extends StatefulWidget {
  final String idLainnya;

  const Edits_custom({Key? key, required this.idLainnya}) : super(key: key);

  @override
  State<Edits_custom> createState() => _Edits_lainnyaState();
}

class _Edits_lainnyaState extends State<Edits_custom> {
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
      final url = "http://192.168.43.116:8080/api/lainnyas/${widget.idLainnya}";
      final dio = Dio();

      FormData formData = FormData.fromMap({
        "image_lainnya": await MultipartFile.fromFile(
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

  Future<void> fetchLainnya() async {
    final response = await http.get(
        Uri.parse("http://192.168.43.116:8080/api/lainnyas/${widget.idLainnya}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'] != null && data['data'].length > 0) {
        final lainnya = data['data'];
        if (lainnya != null) {
          setState(() {
            _namaController.text = lainnya["nama_lainnya"].toString();
            _alamatController.text = lainnya["alamat_lainnya"].toString();
            _telpController.text = lainnya["telp_lainnya"].toString();
            _deskripsiController.text = lainnya["deskripsi_lainnya"].toString();
            date.text = lainnya["tanggal_lainnya"].toString();
            _hargaController.text = lainnya["harga_lainnya"].toString();
          });
        } else {
          print("No data available");
        }
      } else {
        print("No data available");
      }
    } else {
      print("Failed to fetch lainnya. Error: ${response.reasonPhrase}");
    }
  }

  Future<void> saveLainnya() async {
    final response = await http.put(
      Uri.parse("http://192.168.43.116:8080/api/lainnyas/${widget.idLainnya}"),
      body: {
        "nama_lainnya": _namaController.text,
        "alamat_lainnya": _alamatController.text,
        "telp_lainnya": _telpController.text,
        "deskripsi_lainnya": _deskripsiController.text,
        "tanggal_lainnya": date.text,
        "harga_lainnya": _hargaController.text,
        "image_lainnya": _image != null ? _image!.path.split('/').last : "",
      },
    );

    return json.decode(response.body);
  }

  @override
  void initState() {
    date.text = "";
    fetchLainnya(); // Mengambil data lainnya saat inisialisasi
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
          "Edit Data Lainnya",
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
                      "Masukan gambar lainnya",
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
                  await saveLainnya();
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
