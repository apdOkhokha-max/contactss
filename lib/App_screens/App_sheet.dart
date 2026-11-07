import 'package:contact/util/App_Photo.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:contact/util/App_model.dart';


class AddContactSheet extends StatefulWidget {
  final ContactModel? contact;
  const AddContactSheet({super.key,this.contact});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }/////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    final c = widget.contact;
    if (c != null) {
      _nameController.text = c.name;
      _emailController.text = c.email;
      _phoneController.text = c.phone;
      _image = c.image;
    }
  }
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF29384D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ListenableBuilder(
                  listenable: Listenable.merge([
                    _nameController,
                    _emailController,
                    _phoneController,
                  ]),
                  builder: (context, _) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFFFF1D4)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _image == null
                                  ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(AppPhoto.sora),
                              )
                                  : Image.file(_image!, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _nameController.text.isEmpty
                                    ? 'User Name'
                                    : _nameController.text,
                                style: const TextStyle(color: Color(0xFFFFF1D4)),
                              ),
                              const Divider(color: Colors.grey),
                              Text(
                                _emailController.text.isEmpty
                                    ? 'example@email.com'
                                    : _emailController.text,
                                style: const TextStyle(color: Color(0xFFFFF1D4)),
                              ),
                              const Divider(color: Colors.grey),
                              Text(
                                _phoneController.text.isEmpty
                                    ? '+200000000000'
                                    : _phoneController.text,
                                style: const TextStyle(color: Color(0xFFFFF1D4)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),

                _field(
                  controller: _nameController,
                  hint: 'Enter User Name',
                  type: TextInputType.name,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                ),
                const SizedBox(height: 8),
                _field(
                  controller: _emailController,
                  hint: 'Enter User Email',
                  type: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                _field(
                  controller: _phoneController,
                  hint: 'Enter User Phone',
                  type: TextInputType.phone,
                  validator: (v) =>
                  (v == null || v.trim().length < 10) ? 'Invalid phone' : null,
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          ContactModel(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            image: _image,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF1D4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Enter user',
                      style: TextStyle(color: Color(0xFF29384D), fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required TextInputType type,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      style: const TextStyle(color: Color(0xFFFFF1D4)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFFFF1D4), fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFB8B0A0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFF1D4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}