import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_smt4/kategori/kursipage.dart';
import 'package:mobile_smt4/kategori/lainnyapage.dart';
import 'package:mobile_smt4/kategori/lemaripage.dart';
import 'package:mobile_smt4/kategori/mejapage.dart';
import 'package:mobile_smt4/screen_custom/custom.dart';
import 'package:mobile_smt4/screen_kursi/kursi.dart';
import 'package:mobile_smt4/screen_lemari/lemari.dart';
import 'package:mobile_smt4/screens_meja/meja.dart';

class Catalogs extends StatefulWidget {
  const Catalogs({Key? key}) : super(key: key);

  @override
  State<Catalogs> createState() => _CatalogsState();
}

class _CatalogsState extends State<Catalogs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _activeTabIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_setActiveTabIndex);
  }
  void _setActiveTabIndex(){
    _activeTabIndex = _tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF42454E),
      appBar: AppBar(
        title: Text("Daftar Produk",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Color(0xFFF9683A)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF42454E),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFF9683A),
            )),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFFF9683A),
          labelColor: Color(0xFFF9683A),
          unselectedLabelColor: Color(0xFFFFFFFF),
          labelPadding: EdgeInsets.all(0),
          tabs: [
            Tab(text: 'Meja'),
            Tab(text: 'Kursi'),
            Tab(text: 'Lemari'),
            Tab(text: 'Lainnya'),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
              mejapage(),
              kursipage(),
              lemaripage(),
              lainnyapage(),
            ],
      )
    );
  }
}
