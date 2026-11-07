import 'package:contact/App_screens/App_sheet.dart';
import 'package:contact/App_screens/App_card.dart';
import 'package:contact/util/App_model.dart';
import 'package:contact/util/App_Color.dart';
import 'package:contact/util/App_Photo.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ContactModel> contacts = [];

  Future<void> _addContact() async {
    final result = await showModalBottomSheet<ContactModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddContactSheet(),
    );
    if (result != null) {
      setState(() => contacts.add(result));
    }
  }
  Future<void> _editContact(int index) async {
    final result = await showModalBottomSheet<ContactModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddContactSheet(contact: contacts[index]),
    );
    if (result != null) {
      setState(() => contacts[index] = result);
    }
  }

  Future<void> _deleteAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all contacts?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      setState(() => contacts.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.home,
      floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (contacts.isNotEmpty) ...[
          FloatingActionButton(
            heroTag: 'deleteAll',
            onPressed: _deleteAll,
            backgroundColor: const Color(0xFFF33C3C),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          const SizedBox(height: 12),
        ],
        FloatingActionButton(
          heroTag: 'add',
          onPressed: _addContact,
          backgroundColor: const Color(0xFFFFF1D4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.add, color: Color(0xFF29384D)),
        ),
      ],
    ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Image.asset(AppPhoto.conest),
            ),
            Expanded(
              child: contacts.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppPhoto.haraka),
                    const SizedBox(height: 20),
                    const Text(
                      'There is No Contacts Added Here',
                      style: TextStyle(
                        color: Color(0xFFFFF1D4),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.62,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _editContact(index),
                    child: ContactCard(
                      contact: contacts[index],
                      onDelete: () => setState(() => contacts.removeAt(index)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
