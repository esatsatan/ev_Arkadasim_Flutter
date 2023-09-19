import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // İlanı yayınlayanın bilgileri
          ListTile(
            leading: CircleAvatar(
              // İlanı yayınlayanın profil resmi buraya gelebilir
              backgroundColor: Colors.grey, // Varsayılan renk
            ),
            title: Text('İlanı Yayınlayanın Adı Soyadı'),
          ),
          // Fotoğrafların olduğu bölüm
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Yatay kaydırma
            child: Row(
              children: <Widget>[
                // Fotoğraflar buraya eklenebilir
                //Image.asset('assets/image1.jpg'), // Örnek bir fotoğraf
                //Image.asset('assets/image2.jpg'), // Örnek bir fotoğraf
                //Image.asset('assets/image3.jpg'), // Örnek bir fotoğraf
              ],
            ),
          ),
          // İlanı yayınlayanın üniversitesi
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Üniversite: İlanı Yayınlayanın Üniversitesi',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          // İlanı yayınlayanın açıklaması
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'İlanı Yayınlayanın Açıklaması Buraya Gelecek.',
            ),
          ),
          // Evcil hayvan ve sigara bilgileri
          ListTile(
            leading: Icon(Icons.pets), // Evcil hayvan ikonu
            title: Text('Evcil Hayvan: Evet'),
          ),
          ListTile(
            leading: Icon(Icons.smoking_rooms), // Sigara ikonu
            title: Text('Sigara Kullanıyor: Hayır'),
          ),
          // Cinsiyet bilgisi
          ListTile(
            leading: Icon(Icons.person), // Cinsiyet ikonu
            title: Text('Cinsiyet: Erkek'),
          ),
        ],
      ),
    );
  }
}
