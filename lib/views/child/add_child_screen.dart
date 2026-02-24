// lib/views/child/add_child_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_widgets.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  int _selectedEmoji = 0;
  int _selectedColor = 0;
  String _gender = 'Female';
  bool _saving = false;

  final _emojis = ['👶', '🧒', '👦', '👧', '🧑', '🐣', '🦊', '🐨', '🐼', '🐸'];
  final _colors = [
    const Color(0xFFFFB6C1),
    const Color(0xFF87CEFA),
    const Color(0xFFFFD700),
    const Color(0xFFE0FFE0),
    const Color(0xFFFFE4E1),
    const Color(0xFFDDA0DD),
  ];

  void _save() {
    setState(() => _saving = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _saving = false);
      Get.back();
      Get.snackbar('Success! 🎉', 'Child added successfully', backgroundColor: AppColors.green, colorText: AppColors.textPrimary, borderRadius: 12, margin: const EdgeInsets.all(16));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Child'), leading: const BackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _colors[_selectedColor].withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: _colors[_selectedColor], width: 3),
                    ),
                    child: Center(child: Text(_emojis[_selectedEmoji], style: const TextStyle(fontSize: 50))),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle),
                    child: const Icon(Icons.edit_rounded, color: Colors.white, size: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Choose Avatar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_emojis.length, (i) => GestureDetector(
                onTap: () => setState(() => _selectedEmoji = i),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _selectedEmoji == i ? AppColors.pink.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _selectedEmoji == i ? AppColors.pink : Colors.transparent, width: 2),
                  ),
                  child: Center(child: Text(_emojis[i], style: const TextStyle(fontSize: 24))),
                ),
              )),
            ),
            const SizedBox(height: 20),
            const Text('Choose Color', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: List.generate(_colors.length, (i) => GestureDetector(
                onTap: () => setState(() => _selectedColor = i),
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: _colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(color: _selectedColor == i ? Colors.black : Colors.transparent, width: 2),
                  ),
                  child: _selectedColor == i ? const Icon(Icons.check, size: 16, color: Colors.black54) : null,
                ),
              )),
            ),
            const SizedBox(height: 24),
            TextFormField(decoration: const InputDecoration(labelText: "Child's Name *", prefixIcon: Icon(Icons.child_care_rounded), hintText: 'e.g. Emma Rose')),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date of Birth *', prefixIcon: Icon(Icons.cake_rounded), suffixIcon: Icon(Icons.calendar_today_outlined)),
              readOnly: true,
              onTap: () async {
                await showDatePicker(context: context, initialDate: DateTime(2022), firstDate: DateTime(2015), lastDate: DateTime.now());
              },
            ),
            const SizedBox(height: 16),
            const Text('Gender', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: ['Female', 'Male', 'Other'].map((g) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _gender = g),
                  child: Container(
                    margin: EdgeInsets.only(right: g != 'Other' ? 10 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _gender == g ? AppColors.pink.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _gender == g ? AppColors.pink : Colors.grey.withOpacity(0.3), width: 1.5),
                    ),
                    child: Center(child: Text(g, style: TextStyle(color: _gender == g ? AppColors.pink : AppColors.textSecondary, fontWeight: FontWeight.w500))),
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Weight (kg)', prefixIcon: Icon(Icons.monitor_weight_outlined)))),
              const SizedBox(width: 12),
              Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Height (cm)', prefixIcon: Icon(Icons.height_rounded)))),
            ]),
            const SizedBox(height: 16),
            TextFormField(decoration: const InputDecoration(labelText: 'Blood Type', prefixIcon: Icon(Icons.bloodtype_outlined))),
            const SizedBox(height: 32),
            GradientButton(label: _saving ? 'Saving...' : 'Add Child 🎉', onTap: _saving ? () {} : _save),
          ],
        ),
      ),
    );
  }
}
