import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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

              backgroundColor: Colors.blue, // Varsayılan renk
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
              items: [
                Image.network(
                  'https://img.freepik.com/free-photo/modern-residential-district-with-green-roof-balcony-generated-by-ai_188544-10276.jpg?w=1380&t=st=1695279269~exp=1695279869~hmac=0179b1308687a18e5799a2a4c8dd52f2a0cb31972c3153e7004a9b62c40d2b92',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://img.freepik.com/free-photo/house-isolated-field_1303-23773.jpg?w=1060&t=st=1695279401~exp=1695280001~hmac=e8cbde5a6d78898a7d42ed012767ec2db65df15acd3a10dd417d3b4e0db77ecc',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fitWidth,
                ),
              ],
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
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.phone, size: 17),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    '05437603367',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // İlanı yayınlayanın açıklaması
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Akdeniz üniversitesine yatay geçiş yaptım. 3 + 1 eve geçtim 2 tane ev arkadaşına ihtiacım var.',
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.pets),
                        SizedBox(
                          width: 5,
                        ),
                        Text('HAYIR'),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.smoking_rooms),
                        SizedBox(
                          width: 5,
                        ),
                        Text('EVET'),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text('ERKEK'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /*
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
          */
        ],
      ),
    );
  }
}
