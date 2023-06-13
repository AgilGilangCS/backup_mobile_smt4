import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:backup_mobile_smt4/catalog.dart';
import 'package:backup_mobile_smt4/screen_custom/custom.dart';
import 'package:backup_mobile_smt4/screen_kursi/kursi.dart';
import 'package:backup_mobile_smt4/screen_lemari/lemari.dart';
import 'package:backup_mobile_smt4/screens_meja/meja.dart';
import 'package:http/http.dart' as http;

class Homes extends StatefulWidget {
  const Homes({Key? key}) : super(key: key);

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic> _listdata = [];

  Future<void> _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.43.116/mobile_smt4/API/read_meja.php'));
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
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  final List<String> imageList = [
    'assets/images/meja.jpg',
    'assets/images/kursi.jpg',
    'assets/images/lemari.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xFF42454E),
              title: Text(
                'Perhatian',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Apakah anda ingin menutup aplikasi?',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XFF676B77),
                    onPrimary: Color(0XFFFFFFFF),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Tidak'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XFFF9683A),
                    onPrimary: Color(0XFFFFFFFF),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Iya'),
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Black Wooden",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Color(0xFF42454E),
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width * 0.6,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40, top: 6, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Catalogs();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/daftar-produk.png"),
                          SizedBox(width: 15),
                          Text(
                            "Daftar Produk",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Image.asset("assets/images/next.png"),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF676B77),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF42454E),
                  border: Border.all(color: Color(0xFF42454E)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(47),
                    topRight: Radius.circular(47),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            " Selamat",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            " Datang,",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF9683A),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "    Semangat",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            " Bekerja",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF9683A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Mejas();
                                  }),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/img-meja.png",
                                  ),
                                  Text(
                                    "Meja",
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(25),
                                backgroundColor: Color(0xFF676B77),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 6,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Kursis();
                                  }),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/img-kursi.png",
                                  ),
                                  Text(
                                    "Kursi",
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 19,
                                  vertical: 7,
                                ),
                                backgroundColor: Color(0xFF676B77),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Lemaris();
                                  }),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/img-lemari.png",
                                  ),
                                  Text(
                                    "Lemari",
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 33,
                                  vertical: 15,
                                ),
                                backgroundColor: Color(0xFF676B77),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 6,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Customs();
                                  }),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/img-custom.png",
                                  ),
                                  Text(
                                    "Lainnya",
                                    style: GoogleFonts.openSans(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 19,
                                  vertical: 7,
                                ),
                                backgroundColor: Color(0xFF676B77),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
