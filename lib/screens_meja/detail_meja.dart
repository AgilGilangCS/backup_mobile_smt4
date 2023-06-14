import 'dart:convert';

import 'package:flutter/material.dart';
import '/screens_meja/edit_meja.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Details_meja extends StatefulWidget {
  final Map data;
  const Details_meja({Key? key, required this.data});

  @override
  State<Details_meja> createState() => _Details_mejaState();
}

class _Details_mejaState extends State<Details_meja> {
  late String idMeja;

  Future<void> deleteMeja(String data) async {
    String url = "http://192.168.1.26:8080/api/mejas/" + data;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    idMeja = widget.data['id_meja'].toString();
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
          "Detail",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Color(0xFFF9683A)),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFF9683A),
            )),
        actions: [
          IconButton(
              onPressed: () {
                deleteMeja(widget.data['id_meja'].toString()).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data telah dihapus")));
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                color: Color(0xFFF24E1E),
              ))
        ],
      ),
      // Body
      body: ListView(padding: EdgeInsets.only(left: 20, right: 10), children: [
        SizedBox(
          height: 70,
        ),
        // Nama Pesanan
        Text(
          "Nama Pesanan",
          style: GoogleFonts.poppins(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['nama_meja'],
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
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['alamat_meja'],
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
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['telp_meja'],
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
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['deskripsi_meja'],
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
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['tanggal_meja'],
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
              fontWeight: FontWeight.bold),
        ),
        // output
        Text(
          widget.data['harga_meja'],
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
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Edits_meja(
                  idMeja: idMeja,
                );
              },
            ));
          },
          child: Text("Edit"),
          style: ElevatedButton.styleFrom(
              primary: Color(0XFF676B77),
              onPrimary: Color(0XFFFFFFFF),
              minimumSize: Size(0, 40),
              textStyle: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Color(0XFF000000)),
        )
      ]),
    );
  }
}
