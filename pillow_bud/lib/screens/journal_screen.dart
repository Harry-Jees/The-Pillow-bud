import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../models/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _uuid = const Uuid();
  final List<JournalEntry> _entries = [];

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    if (DateFormat('yyyyMMdd').format(d) == DateFormat('yyyyMMdd').format(now)) return 'Today';
    if (DateFormat('yyyyMMdd').format(d) == DateFormat('yyyyMMdd').format(now.subtract(const Duration(days: 1)))) return 'Yesterday';
    return DateFormat('MMM d').format(d);
  }

  void _showNewEntry() {
    final ctrl = TextEditingController();
    String mood = '😌';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Dialog(
          backgroundColor: AppColors.cardDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Journal Entry', style: TextStyle(fontFamily: 'Lora', fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimaryDark)),
                const SizedBox(height: 16),
                TextField(
                  controller: ctrl,
                  maxLines: 5, minLines: 3,
                  autofocus: true,
                  style: const TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: AppColors.textPrimaryDark),
                  decoration: InputDecoration(
                    hintText: 'Write your thoughts...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.35)),
                    filled: true, fillColor: Colors.white.withOpacity(0.04),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text('Mood: ', style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.6))),
                    ...['😤','😢','😌','😊','😄'].map((e) => GestureDetector(
                      onTap: () => setS(() => mood = e),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: mood == e ? AppColors.primary.withOpacity(0.25) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(e, style: const TextStyle(fontSize: 20)),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: TextStyle(color: Colors.white.withOpacity(0.5)))),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (ctrl.text.trim().isEmpty) return;
                        setState(() => _entries.insert(0, JournalEntry(id: _uuid.v4(), text: ctrl.text.trim(), mood: mood, date: DateTime.now())));
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: const Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Journal')),
      body: _entries.isEmpty
          ? Center(child: Text('No entries yet.\nTap + to start writing.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: Colors.white.withOpacity(0.35), height: 1.6)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _entries.length,
              itemBuilder: (_, i) {
                final e = _entries[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    border: Border.all(color: Colors.white.withOpacity(0.07)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(_formatDate(e.date), style: TextStyle(fontFamily: 'DM Sans', fontSize: 11, color: Colors.white.withOpacity(0.4))),
                      Text(e.mood, style: const TextStyle(fontSize: 16)),
                    ]),
                    const SizedBox(height: 8),
                    Text(e.text, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: 'DM Sans', fontSize: 13, color: Colors.white.withOpacity(0.7), height: 1.5)),
                  ]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewEntry,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
