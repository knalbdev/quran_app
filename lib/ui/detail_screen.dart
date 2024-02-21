import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/model/ayah.dart';
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
                  child: _detailBanner(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                    itemBuilder: (context, index) => _ayatItem(
                      // the condition to getting the data based on their index
                        ayat: surah.ayat!.elementAt(index + (surahNumber == 1 ? 1 : 0))),
                    separatorBuilder: (context, index) => Container(),
                    // the condition to check the amount of total ayat that want to be shown
                    itemCount: surah.jumlahAyat + (surahNumber == 1 ? -1 : 0)
                ),
              ),
            ),
          );
        },
      );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xF121931),
                Color(0xFFFFFFF)
              ]
            )
          ),
          child: Row(children: [
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: Color(0xFF863ED5),
                borderRadius: BorderRadius.circular(13.5),
              ),
              child: Center(child: Text(
                '${ayat.nomor}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                )
              ))
            ),
            const Spacer(),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.share_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.play_arrow_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
            IconButton(
                iconSize: 24,
                onPressed: () => {},
                icon: const Icon(
                  Icons.bookmark_sharp,
                  color: Color(0xFF863ED5),
                )
            ),
          ],
          )
        ),
        const SizedBox(height: 24),
        Text(
          ayat.ar,
          style: GoogleFonts.amiri(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF240F4F)
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 24),
        Text(
          ayat.idn,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.normal,
              color: const Color(0xFF240F4F)
          ),
        )
      ]
    ),
  );

  Widget _detailBanner({required Surah surah}) => Padding(
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
