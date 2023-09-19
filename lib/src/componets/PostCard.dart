import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final List<String> imageList = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
    // İlgilendiğiniz kadar daha fazla resim ekleyebilirsiniz
  ];

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
            title: Text('Esat Satan'),
          ),
          // Fotoğrafların olduğu bölüm
          Padding(
            padding: EdgeInsets.all(2.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0, // Görüntü kaydırıcısının yüksekliği
                enlargeCenterPage: true, // Orta sayfanın büyütülmesi
                autoPlay: true, // Otomatik oynatma
                aspectRatio: 16 / 9, // Görüntü oranı
              ),
              items: [],
            ),
          ),

          /*
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
          */
          // İlanı yayınlayanın üniversitesi
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Akdeniz Üniversitesi',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          // İlanı yayınlayanın açıklaması
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Akdeniz üniversitesine yatay geçiş yaptım. 3 + 1 eve geçtim 2 tane ev arkadaşına ihtiacım var.',
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
