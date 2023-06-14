import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Edits_meja extends StatefulWidget {
  final String idMeja;

  const Edits_meja({Key? key, required this.idMeja}) : super(key: key);

  @override
  State<Edits_meja> createState() => _Edits_mejaState();
}

class _Edits_mejaState extends State<Edits_meja> {
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
      final url =
          Uri.parse("http://192.168.1.26:8080/api/mejas/${widget.idMeja}");
      final request = http.MultipartRequest('PUT', url);
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

  Future<void> fetchMeja() async {
    final response = await http
        .get(Uri.parse("http://192.168.1.26:8080/api/mejas/${widget.idMeja}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'] != null && data['data'].length > 0) {
        final meja = data['data'][0];
        if (meja != null) {
          setState(() {
            _namaController.text = meja["nama_meja"].toString();
            _alamatController.text = meja["alamat_meja"].toString();
            _telpController.text = meja["telp_meja"].toString();
            _deskripsiController.text = meja["deskripsi_meja"].toString();
            date.text = meja["tanggal_meja"].toString();
            _hargaController.text = meja["harga_meja"].toString();
          });
        } else {
          print("No data available");
        }
      } else {
        print("No data available");
      }
    } else {
      print("Failed to fetch meja. Error: ${response.reasonPhrase}");
    }
  }

  Future<void> saveMeja() async {
    final response = await http.put(
      Uri.parse("http://192.168.1.26:8080/api/mejas/${widget.idMeja}"),
      body: {
        "nama_meja": _namaController.text,
        "alamat_meja": _alamatController.text,
        "telp_meja": _telpController.text,
        "deskripsi_meja": _deskripsiController.text,
        "tanggal_meja": date.text,
        "harga_meja": _hargaController.text,
        "image_meja": _image != null ? _image!.path : "",
      },
    );

    return json.decode(response.body);
  }

  @override
  void initState() {
    date.text = "";
    fetchMeja(); // Mengambil data meja saat inisialisasi
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
          "Edit Data Meja",
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
                    color: Color(0xFF42454E),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF9683A),
                  elevation: 0,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: "Nama Meja",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: "Alamat Meja",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _telpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon Meja",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Deskripsi Meja",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: date,
                decoration: InputDecoration(
                  labelText: "Tanggal",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      date.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga Meja",
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF9683A),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  saveMeja();
                  Navigator.pop(context);
                },
                child: Text(
                  "Simpan",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF42454E),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF9683A),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
