import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, this.contact});

  final Contact? contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  bool _userEdited = false;
  Contact? _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editedContact!.name!;
      _emailController.text = _editedContact!.email!;
      _phoneController.text = _editedContact!.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedContact!.name ?? 'Novo Contato'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedContact!.name != null && _editedContact!.email != null && _editedContact!.phone != null) {
              Navigator.pop(context, _editedContact);
            } else if (_editedContact!.name == null) {
              FocusScope.of(context).requestFocus(_nameFocus);
            } else if (_editedContact!.email == null) {
              FocusScope.of(context).requestFocus(_emailFocus);
            } else if (_editedContact!.phone == null) {
              FocusScope.of(context).requestFocus(_phoneFocus);
            }
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact!.img != null ? FileImage(File(_editedContact!.img!)) : AssetImage('images/person.png') as ImageProvider,
                    ),
                  ),
                ),
                onTap: () {
                  ImagePicker().pickImage(source: ImageSource.camera).then((file) {
                    if (file == null) return;
                    setState(() {
                      _editedContact!.img = file.path;
                      _userEdited = true;
                    });
                  });
                },
              ),
              TextField(
                focusNode: _nameFocus,
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact!.name = text;
                  });
                },
              ),
              TextField(
                focusNode: _emailFocus,
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                focusNode: _phoneFocus,
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.phone = text;
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Descartar Alterações?'),
            content: Text('Caso saia as alterações serão perdidas.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Sair'),
              )
            ],
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
