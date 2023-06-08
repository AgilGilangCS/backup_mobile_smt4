import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens_meja/form_meja.dart';

class kursipage extends StatelessWidget {
  const kursipage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
                Text("Kategori Kursi", style: GoogleFonts.poppins(fontSize: 18,
                    fontWeight: FontWeight.bold),),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: Image.asset("assets/images/lemari.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text("Lemari besi kayu",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,fontSize: 16,
                            ),),
                          ),
                          Padding(padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                            child: Text(
                              "Rp.500.000",style: GoogleFonts.poppins(color: Color(0xFFF9683A)),
                            ),),
                        ],
                      ),
                    ),
                  ],),
              ]),
        ));
  }
}
