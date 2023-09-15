import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class PublishScreen extends StatefulWidget {
  // const PublishScreen({super.key});
  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  bool smoke = false;
  String gender = 'Belirtilmemiş';
  bool hasPets = false;
  List<XFile> selectedImages = []; // seçilen fotoğrafları kaydetmek için.
  TextEditingController descriptionController = TextEditingController();

  void _toggleSmoke(bool value) {
    setState(() {
      smoke = value;
    });
  }

  void _setGender(String? value) {
    setState(() {
      gender = value!;
    });
  }

  void _togglePets(bool value) {
    setState(() {
      hasPets = value;
    });
  }

  Future<void> _pickImages() async {
    // Galeriden ev fotoğrafını seçme işlemi burada yapılır
    // Seçilen fotoğrafı selectedImages listesine eklemelisiniz
    final picker = ImagePicker();
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImages != null) {
      setState(() {
        selectedImages = pickedImages as List<XFile>;
        String imagePath = pickedImages.path;
      });
    } else {
      print('Kullanıcı fotoğraf seçmeyi iptal etti.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(12, 12, 12, 2),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  title: Text('Antalya'),
                  subtitle: Text('Akdeniz Üniversitesi'),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                elevation: 5,
                margin: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Sigara Kullanıyor musunuz?'),
                      trailing: Switch(
                        value: smoke,
                        onChanged: _toggleSmoke,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Evci hayvanınız var mı?',
                      ),
                      trailing: Switch(
                        value: hasPets,
                        onChanged: _togglePets,
                      ),
                    ),
                    ListTile(
                      title: Text('Cinsiyetiniz :'),
                      trailing: DropdownButton<String>(
                        value: gender,
                        onChanged: _setGender,
                        items: <String>['Belirtilmemiş', 'Erkek', 'Kadın']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    ListTile(
                      title: Text('Evin Fotoğraflarını Ekleyin:'),
                      trailing: ElevatedButton(
                        onPressed: _pickImages,
                        child: Text('Fotoğraf Seç'),
                      ),
                    ),

                    // Seçilen fotoğrafları göstermek için bir widget ekleyin
                    // Örnek olarak GridView.builder kullanabilirsiniz.
                    // Ayrıca, açıklama için bir TextField ekleyin:
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Açıklama giriniz',
                          border: OutlineInputBorder(),
                          hintText: 'İlan ile ilgili açıklama giriniz',
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'İlanı yayınla',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(12, 2, 12, 2),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  title: Text('Antalya'),
                  subtitle: Text('Akdeniz Üniversitesi'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
