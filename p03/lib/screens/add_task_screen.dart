import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  Priority _selectedPriority = Priority.medium; // Default

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _simpan() {
    // Validasi form (ngecek input kosong)
    if (_formKey.currentState!.validate()) {
      // Kalau valid, bikin task baru
      final taskBaru = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // ID unik
        title: _titleController.text,
        priority: _selectedPriority,
      );

      // Balikin ke layar list sambil bawa data taskBaru
      Navigator.pop(context, taskBaru);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // INPUT 1: Text (Judul)
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // INPUT 2: Dropdown (Prioritas)
              DropdownButtonFormField<Priority>(
                initialValue: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Prioritas',
                  border: OutlineInputBorder(),
                ),
                items: Priority.values.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p.name));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedPriority = val!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              FilledButton(
                onPressed: _simpan,
                child: const Text('Simpan Tugas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}