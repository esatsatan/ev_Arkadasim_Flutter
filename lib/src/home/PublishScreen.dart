import 'dart:io';

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
  List<XFile> imageFileList = []; // seçilen fotoğrafları kaydetmek için.
  late XFile deneme;
  TextEditingController descriptionController = TextEditingController();
  bool isCardExpanded = false;

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
    final List<XFile> selectedImages = await picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      setState(() {
        imageFileList = selectedImages;
        isCardExpanded = true;
      });
    }
    /*final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
        maxWidth: 50, maxHeight: 50, imageQuality: null);

    // ignore: unnecessary_null_comparison
    final List<XFile> pickedFileList = <XFile>[];
    if (pickedImages != null) {
      setState(() {
        pickedFileList.add(pickedImages);
      });
    } else {
      print('Kullanıcı fotoğraf seçmeyi iptal etti.');
    }
    */
  }

  @override
  void dispose() {
    descriptionController.dispose();
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
                  title: Text('Esat Satan'),
                  subtitle: Text('Akdeniz Üniversitesi'),
                ),
              ),
              // seçilen Fotoğrafları bura cardın içine ekle
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
                margin: EdgeInsets.fromLTRB(12, 12, 12, 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _pickImages,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Fotoğraf seçmek için tıklayın',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    // buraya fotoğrafları ekle
                    if (isCardExpanded)
                      Container(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.all(8),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageFileList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.file(
                                  File(imageFileList[index].path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    /*
                    for (XFile image in imageFileList)
                      Image.file(
                        File(image.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      */
                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
