import 'package:contact/App_screens/App_sheet.dart';
import 'package:contact/util/App_Photo.dart';
import 'package:contact/util/App_model.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;

  const ContactCard({super.key, required this.contact, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D4),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // الصورة + الاسم
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                contact.image == null
                    ? Container(
                  color: const Color(0xFF29384D),
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(AppPhoto.sora),
                )
                    : Image.file(contact.image!, fit: BoxFit.cover),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1D4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      contact.name,
                      style: const TextStyle(
                        color: Color(0xFF29384D),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // الإيميل والرقم وزرار Delete
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _infoRow(Icons.email, contact.email),
                const SizedBox(height: 6),
                _infoRow(Icons.phone, contact.phone),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, size: 14, color: Colors.white),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF33C3C),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF29384D)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF29384D), fontSize: 10),
          ),
        ),
      ],
    );
  }
}