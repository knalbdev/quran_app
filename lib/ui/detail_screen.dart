/*
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
*/

class DetailScreen extends StatelessWidget {
  final int surahNumber;
  const DetailScreen({super.key, required this.surahNumber});
  
  Future _detailSurah() async {
    var data = await Dio().get('https://equran.id/api/surat/$surahNumber');
    print(data);
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _detailSurah(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) => 
      SafeArea(child: Text('$surahNumber')))
    );
  }*/
}
