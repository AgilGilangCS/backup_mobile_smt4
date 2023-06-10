import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:backup_mobile_smt4/homes.dart';
import 'package:backup_mobile_smt4/screens_meja/detail_meja.dart';
import 'package:backup_mobile_smt4/screens_meja/form_meja.dart';
import 'package:http/http.dart' as http;

class Mejas extends StatefulWidget {
  const Mejas({super.key});

  @override
  State<Mejas> createState() => _MejasState();
}

class _MejasState extends State<Mejas> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.0.136/mobile_smt4/API/read.php'));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          centerTitle: true,
          title: Text(
            "Meja",
            style: GoogleFonts.poppins(
                color: Color(0xFF42454E), fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF42454E),
          )),
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              width: 426,
              height: 786,
              decoration: BoxDecoration(
                color: Color(0xFF42454E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
            // List
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: ListView.builder(
                itemCount: _listdata.length,
                itemBuilder: (context, index) {
                  // Body List
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 360,
                            height: 133,
                            decoration: BoxDecoration(
                              color: Color(0xFF676B77),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // Isi Dalam List
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //  Nama Pemesan
                                children: [
                                  Text(
                                    _listdata[index]['nama_meja'],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Alamat
                                  SizedBox(height: 5),
                                  Text(
                                    _listdata[index]['alamat_meja'],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Garis
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xFFF9683A),
                                  ),
                                  // Tanggal dan Icon Button
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // Tanggal
                                    children: [
                                      Text(
                                        _listdata[index]['tanggal_meja'],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Icon Button
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_right_rounded,
                                          color: Color(0XFFF9683A),
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return Details_meja();
                                            },
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
              ),
            ),
            Positioned(
              right: 34,
              bottom: 31,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Forms_meja();
                    },
                  ));
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0XFFF9683A),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFFFFFFFF),
                    size: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
