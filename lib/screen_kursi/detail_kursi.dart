import 'dart:convert';

import 'package:backup_mobile_smt4/screen_kursi/edit_kursi.dart';
import 'package:flutter/material.dart';
import '/screens_meja/edit_meja.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Details_kursi extends StatefulWidget {
  final Map data;
  const Details_kursi({Key? key, required this.data});

  @override
  State<Details_kursi> createState() => _Details_kursiState();
}

class _Details_kursiState extends State<Details_kursi> {
  late String idKursi;
  late String imageUrl;

  Future<void> deleteKursi(String data) async {
    String url = "http://192.168.43.116:8080/api/kursis/" + data;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    idKursi = widget.data['id_kursi'].toString();
    super.initState();
    String imageName = widget.data['image_kursi'];
    imageUrl = "http://192.168.43.116:8080/storage/img/$imageName";
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
          "Detail",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xFFF9683A),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFF9683A),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              deleteKursi(widget.data['id_kursi'].toString()).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Data telah dihapus")),
                );
                Navigator.pop(context);
              });
            },
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Color(0xFFF24E1E),
            ),
          )
        ],
      ),
      // Body
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 10),
        children: [
          Container(
            height: 200,
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      // Tampilkan teks atau tindakan lain jika gambar gagal dimuat
                      return Text(
                        'Gagal memuat gambar',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Tidak ada gambar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          SizedBox(
            height: 70,
          ),
          // Nama Pesanan
          Text(
            "Nama Pesanan",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['nama_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Alamat
          Text(
            "Alamat",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['alamat_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // No.Telepon
          Text(
            "No.Telepon",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['telp_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Deskripsi
          Text(
            "Deskripsi",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['deskripsi_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Tanggal
          Text(
            "Batas Tanggal",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['tanggal_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Harga
          Text(
            "Harga",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
          // output
          Text(
            widget.data['harga_kursi'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Button Edit
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Edits_kursi(idKursi: idKursi);
                  },
                ),
              );
            },
            child: Text("Edit"),
            style: ElevatedButton.styleFrom(
              primary: Color(0XFF676B77),
              onPrimary: Color(0XFFFFFFFF),
              minimumSize: Size(0, 40),
              textStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Color(0XFF000000),
            ),
          ),
        ],
      ),
    );
  }
}
