import 'dart:convert';

import 'package:backup_mobile_smt4/screen_custom/edit_custom.dart';
import 'package:flutter/material.dart';
import '/screens_meja/edit_meja.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Details_custom extends StatefulWidget {
  final Map data;
  const Details_custom({Key? key, required this.data});

  @override
  State<Details_custom> createState() => _Details_customState();
}

class _Details_customState extends State<Details_custom> {
  late String idLainnya;
  late String imageUrl;

  Future<void> deleteLainnya(String data) async {
    String url = "http://192.168.43.116:8080/api/lainnyas/" + data;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    idLainnya = widget.data['id_lainnya'].toString();
    super.initState();
    String imageName = widget.data['image_lainnya'];
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
              deleteLainnya(widget.data['id_lainnya'].toString()).then((value) {
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
            widget.data['nama_lainnya'],
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
            widget.data['alamat_lainnya'],
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
            widget.data['telp_lainnya'],
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
            widget.data['deskripsi_lainnya'],
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
            widget.data['tanggal_lainnya'],
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
            widget.data['harga_lainnya'],
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
                    return Edits_custom(
                      idLainnya: idLainnya,
                    );
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
