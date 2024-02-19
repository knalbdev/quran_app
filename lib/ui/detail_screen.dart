import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/model/surah.dart';

import '../globals.dart';

class DetailScreen extends StatelessWidget {
  final int surahNumber;
  const DetailScreen({super.key, required this.surahNumber});

  Future<Surah> _surahDetail() async {
    var response = await Dio().get('https://equran.id/api/surat/$surahNumber');

    return Surah.fromJson(json.decode(response.toString()));
  } 

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<Surah>(
        future: _surahDetail(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Surah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _detail(surah: surah),
                )
              ],
              body: Container(),
            ),
          );
        },
      );
  }

  Widget _detail({required Surah surah}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Stack(children: [
      Container(
        height: 265,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFDF98FA),
                  Color(0xFF9055FF)
                ]
            )
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Opacity(
          opacity: 0.2,
          child: SvgPicture.asset(
            'svg/quran_banner.svg',
            width: 324 - 58,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              surah.namaLatin,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26
              ),
            ),
            const SizedBox(height: 4),
            Text(
              surah.arti,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.white.withOpacity(0.35),
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  surah.tempatTurun.name,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${surah.jumlahAyat} Ayat',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
            const SizedBox(height: 38),
            SvgPicture.asset('svg/basmallah.svg')
          ],
        ),
      )
    ],),
  );

  AppBar _appBar({required BuildContext context, required Surah surah}) => AppBar(
    backgroundColor: Colors.white,

    // hide the back button
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Row(children: [
      IconButton(
        // to make a back button back to the prev page when pressed
          onPressed: (() => {
            Navigator.of(context).pop()
          }),
          icon: SvgPicture.asset('svg/back_icon.svg')),
      const SizedBox(
        width: 24,
      ),
      Text(
        surah.namaLatin,
        style: GoogleFonts.poppins(
            fontSize: 20,
            color: primary,
            fontWeight: FontWeight.bold
        ),
      ),
      const Spacer(),
      IconButton(
          onPressed: (() => {}),
          icon: SvgPicture.asset('assets/svg/search_icon.svg')),
    ],),
  );
}
