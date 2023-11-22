import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class ProductToAdd {
  String name;
  String brand;
  int weight;
  String material;

  ProductToAdd({
    required this.name,
    required this.brand,
    required this.weight,
    required this.material,
  });
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _controllername = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllerweight = TextEditingController();
  final _controllermaterial = TextEditingController();

  XFile? _image;

  ProductToAdd productToAdd =
      ProductToAdd(brand: '', name: '', material: '', weight: 0);

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sikhye'),
          actions: [
            Consumer<ApplicationState>(builder: (context, appstate, _) {
              return IconButton(
                  icon: const Text('Save'),
                  onPressed: () {
                    productToAdd.name = _controllername.text;
                    productToAdd.brand = _controllerbrand.text;
                    productToAdd.weight = int.parse(_controllerweight.text);
                    print(_controllerweight.text);
                    productToAdd.material = _controllermaterial.text;
                    appstate.addProduct(productToAdd);
                    Navigator.pop(context);
                  });
            }),
          ],
        ),
        body: Form(
            child: ListView(
          children: [
            _buildPhotoArea(),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerbrand,
                    decoration: const InputDecoration(
                      hintText: '브랜드명',
                    ),
                  ),
                  TextFormField(
                    controller: _controllername,
                    decoration: const InputDecoration(
                      hintText: '상품명',
                    ),
                  ),
                  TextFormField(
                    controller: _controllerweight,
                    decoration: const InputDecoration(
                      hintText: '중량',
                    ),
                  ),
                  TextFormField(
                    controller: _controllermaterial,
                    decoration: const InputDecoration(
                      hintText: '재료',
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }

  Widget _buildPhotoArea() {
    // return Image.network(imageUrl);
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)),
          )
        : Container(
            width: 300,
            height: 300,
            child: Image.asset('assets/default-image.jpg'),
          );
  }
}
