import 'dart:convert';
import 'dart:io';

import 'package:backup_mobile_smt4/screen_custom/custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Forms_custom extends StatefulWidget {
  const Forms_custom({Key? key}) : super(key: key);

  @override
  State<Forms_custom> createState() => _Forms_customState();
}

class _Forms_customState extends State<Forms_custom> {
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

  Future<void> _uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.43.116:8080/api/lainnyas/'), // Ganti dengan URL endpoint Anda
    );

    var multipartFile =
        await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Gambar berhasil diupload');
    } else {
      print('Gagal mengupload gambar');
    }
  }

  TextEditingController date = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _telpController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();

  Future saveLainnya() async {
    final response = await http.post(
      Uri.parse("http://192.168.43.116:8080/api/lainnyas"),
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
          "Tambahkan Data Lainnya",
          style: TextStyle(
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
                      "Masukan gambar Lainnya",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(height: 20),
              // TextFormField lainnya
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
                        date.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      });
                    }
                  },
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
                  await _uploadImage;
                  await saveLainnya();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Customs()),
                  );
                },
                child: Text(
                  "Tambah",
                  style: TextStyle(
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
