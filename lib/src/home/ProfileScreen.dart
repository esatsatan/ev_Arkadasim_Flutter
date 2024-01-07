import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/authentication/AuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../verification/PhoneVerifyScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  AuthService auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  String username = "";
  String email = "";
  String password = "";
  String university = "";

  AuthService _authService = AuthService();
  Future getUsername() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        String Name = data['username'];
        String Email = data['email'];
        String Password = data['password'];
        String University = data['university'];

        setState(() {
          username = Name;
          email = Email;
          password = Password;
          university = University;
        });
      } else {
        print('Veritabanında böyle bir döküman yok.');
      }
    }).catchError((error) {
      print('bir hata oluştu çünkü : $error');
    });
  }

  @override
  void initState() {
    super.initState();
    //print('kullanıcı idsi : ${FirebaseAuth.instance.currentUser!.uid}');
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneNumberController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Kişisel Bilgiler',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              username.trim(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              university.trim(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              email.trim(),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Burada telefon doğrulaması için gerekli componentler yazılır.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      decoration: InputDecoration(
                        labelText: 'Telefon numarası',
                        prefixIcon: const Icon(Icons.phone_in_talk_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Doğrulama işlemleri burada gerçekleştirilebilir.
                      // Örneğin, telefon numarasını bir API'ye gönderip doğrulama kodu alabilirsiniz.
                      // Bu örnekte sadece bir mesaj yazdırıyorum.
                      //_authService.loginWithPhoneNumber(_phoneNumberController.text, OTP)

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyPhone();
                          },
                        ),
                      );

                      //_authService.loginWithPhoneNumber(_phoneNumberController.text);
                    },
                    child: Text('Doğrula'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Aktif ilanlarım',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  'AKTİF',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.check_circle_outlined,
                                size: 22,
                                color: Colors.green,
                              ),
                            ],
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
            ),
          ],
        ),
      ),
    );
  }
}
