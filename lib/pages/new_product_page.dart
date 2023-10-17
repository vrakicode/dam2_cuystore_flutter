import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:proyecto_flutter/services/firebase_service.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
class NewProductPage extends StatefulWidget {
   
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  
  final FirebaseService _firebaseService = FirebaseService();
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController descriptionController = TextEditingController();
  int maxCharacters = 500;
  List<MultiSelectItem<String>> categories = [];

  List<String> selectedCategories = [];
  Future<void> _agregarProducto() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        max: 100, 
        msg:'Subiendo producto...',
        completed: Completed(
          completedMsg: 'Producto agregado',
          completionDelay: 2500
        )
      );
      form.save();

      final Map<String, dynamic> formData = form.value;
      List<String> imageUrls = await _firebaseService.subirImagenes(selectedImages);
      
      try {
        await _firebaseService.agregarProducto(formData, imageUrls, selectedCategories);
        Fluttertoast.showToast(msg: 'Producto agregado');
      } finally {
        pd.close();
      }
      form.reset();     
      selectedCategories = [];
      selectedImages = [];
      descriptionController.clear();
      
      pd.close();
    }
  }
  @override
  void initState() {
    super.initState();
    categories = _buildMultiSelectItems();
  }

  List<MultiSelectItem<String>> _buildMultiSelectItems() {
    return [
      MultiSelectItem('Electrónica', 'Electrónica'),
      MultiSelectItem('Moda', 'Moda'),
      MultiSelectItem('Hogar y Jardín', 'Hogar y Jardín'),
      MultiSelectItem('Salud y Belleza', 'Salud y Belleza'),
      MultiSelectItem('Deportes y Aire Libre', 'Deportes y Aire Libre'),
      MultiSelectItem('Libros y Entretenimiento', 'Libros y Entretenimiento'),
      MultiSelectItem('Automóviles y Motocicletas', 'Automóviles y Motocicletas'),
      MultiSelectItem('Inmuebles', 'Inmuebles'),
      MultiSelectItem('Servicios', 'Servicios'),
      
    ];
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return  MultiSelectBottomSheet(
          items: categories,
          initialValue: selectedCategories,
          onConfirm: (values) {
            setState(() {
              selectedCategories = values;
            });},
          maxChildSize: 0.8,
        );
      },
    );
  }
  List<XFile> selectedImages = [];
  //Future<void> _agregarProducto
  Future<void> _pickImageFromSource(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        selectedImages.add(image);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Vender Producto',
        style: TextStyle(fontSize: 30),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(
                  width: 350,
                  child: FormBuilderTextField(
                    name: 'nombreProducto',
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                      
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 350,
                  child: FormBuilderTextField(
                    keyboardType: TextInputType.number,
                    name: 'precioProducto',
                    decoration: const InputDecoration(
                      labelText: 'Precio del Producto',
                      border: OutlineInputBorder(),
                      
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric()
                    ]),
                  ),
                ),
                
                const SizedBox(height: 10,),
                SizedBox(
                  width: 350,
                  child: FormBuilderTextField(
                    keyboardType: TextInputType.number,
                    name: 'stockProducto',
                    decoration: const InputDecoration(
                      labelText: 'Stock del Producto',
                      border: OutlineInputBorder(),
                      
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric()
                    ]),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 350,
                  child: FormBuilderDropdown(
                      name: 'estadoProducto',
                      decoration: const InputDecoration(
                        labelText: 'Estado del Producto',
                        border: OutlineInputBorder()
                      ),
                      //hint: Text('Selecciona una condición'),
                      validator: FormBuilderValidators.required(),
                      items: ['Nuevo', 'Usado']
                          .map((estado) => DropdownMenuItem(
                                value: estado,
                                child: Text(estado),
                              ))
                          .toList(),
                    
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 350,
                  child: FormBuilderTextField(
                    name: 'descripcionProducto',
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    maxLines: 5,
                    onChanged: (value){
                      setState(() {
                        
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Descripcion del Producto',
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffix: Text('${descriptionController.text.length}/$maxCharacters'),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(500)
                    ]),
                  ),
                ),
                const SizedBox(height:30 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        _showMultiSelect(context);
                      }, 
                      child: const Text("Seleccionar categorias")
                    ),
                    ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Elegir una opción"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Tomar una foto'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImageFromSource(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Elegir de la galería'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImageFromSource(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Subir Foto'),
                ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    try {
                      _agregarProducto();
                    } catch (error) {
                      Fluttertoast.showToast(msg: error.toString());
                    }
                  },
                  child: const Text('Agregar Producto'),
                ),

                const SizedBox(height:30 ,),
                // Mostrar imágenes seleccionadas
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Cambia esto según tus necesidades
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: selectedImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Image.file(
                        File(selectedImages[index].path),
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: 100.0,
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
          
        ],
      ),
    );
  }
}