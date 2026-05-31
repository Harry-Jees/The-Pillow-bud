import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../theme/theme_colors.dart';
import '../models/journal_entry.dart';
import '../providers/app_providers.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _uuid = const Uuid();

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
        builder: (ctx, setS) {
          final cardBg = Theme.of(ctx).cardColor;
          final textColor = Theme.of(ctx).colorScheme.onSurface;
          final primary = Theme.of(ctx).colorScheme.primary;
          return Dialog(
            backgroundColor: cardBg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New Journal Entry', style: TextStyle(fontFamily: 'Caveat', fontSize: 18, fontWeight: FontWeight.w500, color: textColor)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ctrl,
                    maxLines: 5,
                    minLines: 3,
                    autofocus: true,
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Write your thoughts...',
                      hintStyle: TextStyle(color: textColor.withValues(alpha: 0.35)),
                      filled: true,
                      fillColor: textColor.withValues(alpha: 0.04),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: textColor.withValues(alpha: 0.1))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: textColor.withValues(alpha: 0.1))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: primary)),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Text('Mood: ', style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: textColor.withValues(alpha: 0.6))),
                      ...['😤', '😢', '😌', '😊', '😄'].map((e) => GestureDetector(
                        onTap: () => setS(() => mood = e),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: mood == e ? primary.withValues(alpha: 0.25) : Colors.transparent,
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
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel', style: TextStyle(color: textColor.withValues(alpha: 0.5)))),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (ctrl.text.trim().isEmpty) return;
                          final entry = JournalEntry(id: _uuid.v4(), text: ctrl.text.trim(), mood: mood, date: DateTime.now());
                          ref.read(journalEntriesProvider.notifier).addEntry(entry);
                          Navigator.pop(ctx);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(journalEntriesProvider);
    final textColor = context.themeOnSurface;
    final cardBg = context.themeCard;

    return Scaffold(
      appBar: AppBar(title: const Text('My Journal')),
      body: entries.isEmpty
          ? Center(child: Text('No entries yet.\nTap + to start writing.', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: textColor.withValues(alpha: 0.35), height: 1.6)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (_, i) {
                final e = entries[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cardBg,
                    border: Border.all(color: textColor.withValues(alpha: 0.07)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(_formatDate(e.date), style: TextStyle(fontFamily: 'Nunito', fontSize: 11, color: textColor.withValues(alpha: 0.4))),
                      Text(e.mood, style: const TextStyle(fontSize: 16)),
                    ]),
                    const SizedBox(height: 8),
                    Text(e.text, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: 'Nunito', fontSize: 13, color: textColor.withValues(alpha: 0.7), height: 1.5)),
                  ]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewEntry,
        backgroundColor: context.themePrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
