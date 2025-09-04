import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  final String noteId;

  const NoteDetailPage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Note Detail Page',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Note ID: $noteId',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'This page will show detailed note content,\nediting capabilities, and related tasks.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
