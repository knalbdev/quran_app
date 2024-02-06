import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/globals.dart';
import 'package:quran/ui/tabs/hijb_tab.dart';
import 'package:quran/ui/tabs/page_tab.dart';
import 'package:quran/ui/tabs/para_tab.dart';
import 'package:quran/ui/tabs/surah_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _salam(),
                ),
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  shape: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: const Color(0xFFAAAAAA).withOpacity(0.1),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                  child: _tab()
                  ),
                )
              ],

          body: const TabBarView(
            children: [
              SurahTab(),
              ParaTab(),
              PageTab(),
              HijbTab()
            ],
          )
        ),
      ),
    ),
    );
  }

  TabBar _tab() {
    return TabBar(
      labelColor: primary,
      indicatorColor: primary,
      indicatorWeight: 3,
      tabs: [
      _tabItem(label: 'Surah'),
      _tabItem(label: 'Surah'),
      _tabItem(label: 'Surah'),
      _tabItem(label: 'Surah'),
    ],);
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Column _salam() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamualaikum',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: secondary
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Tia',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            _lastRead()
          ],
        );
  }

  Stack _lastRead() {
    return Stack(
      children: [
            Container(
              height: 131,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFFDF98FA),
                  Color(0xFF9055FF)
                ])),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('/svg/quran_banner.svg')),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('/svg/book.svg'),
                      const SizedBox(width: 8,),
                      Text(
                        'Last Read',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,),
                Text(
                  'Al-Fatihah',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Ayat No: 1',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                ],
              ),
            )
          ],);
  }

  AppBar _appBar() => AppBar(
    backgroundColor: Colors.white,

    // hide the back button
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Row(children: [
      IconButton(
          onPressed: (() => {}),
          icon: SvgPicture.asset('assets/svg/menu_icon.svg')),
      const SizedBox(
        width: 24,
      ),
      Text(
        'Quran App',
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

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    //showSelectedLabels: false,
    //showUnselectedLabels: false,
    items: [
    _bottomNavigationBarItem(icon: '/svg/quran_icon.svg', label: 'Quran'),
    _bottomNavigationBarItem(icon: '/svg/doa_icon.svg', label: 'Doa'),
    _bottomNavigationBarItem(icon: '/svg/bookmark_icon.svg', label: 'Bookmark'),
  ],);

  BottomNavigationBarItem _bottomNavigationBarItem({required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            color: secondary,
          ),
        activeIcon: SvgPicture.asset(
          icon,
          color: primary,
        ),
        label: label
      );
}
