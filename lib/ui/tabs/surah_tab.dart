import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/globals.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/ui/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('/data/list-surah.json');
    //print(data);

    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        initialData: [],
        builder: ((context, snapshot) {
          if(!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
              Divider(color: const Color(0xFFAAAAAA).withOpacity(0.1)),
              itemCount: snapshot.data!.length);
        })
    );
  }

  Widget _surahItem({required BuildContext context, required Surah surah}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen()));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Stack(
            children: [
              SvgPicture.asset('assets/svg/nomor_surah.svg'),
              SizedBox(
                height: 36,
                width: 36,
                child: Center(child: Text(
                  surah.nomor.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              )
            ],
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              surah.namaLatin,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16
              )
            ),
              const SizedBox(height: 4),
              Row(children: [
                Text(
                    surah.tempatTurun.name,
                    style: GoogleFonts.poppins(
                        color: secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                    )
                ),
                SizedBox(width: 5,),
                SvgPicture.asset('/svg/dot.svg'),
                SizedBox(width: 5,),
                Text(
                    '${surah.jumlahAyat} Ayat',
                    style: GoogleFonts.poppins(
                        color: secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12
                    )
                ),
              ],
              )
          ],)),
          Text(
            surah.nama,
            style: GoogleFonts.amiri(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),
  );
}
