import 'package:flutter/material.dart';
import '../models/don.dart';

class HistoriqueScreen extends StatelessWidget {
  const HistoriqueScreen({super.key});

  static final List<Don> historique = [
    Don(
      date: DateTime(2026, 5, 10),
      typeDon: 'Sang total',
      centre: 'Centre de Transfusion de Bizerte',
    ),
    Don(
      date: DateTime(2026, 1, 15),
      typeDon: 'Plasma',
      centre: 'Centre de Santé Mateur',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des dons'),
      ),
      body: historique.isEmpty
          ? const Center(
              child: Text('Aucun don enregistré'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: historique.length,
              itemBuilder: (context, index) {
                final don = historique[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(don.typeDon),
                    subtitle: Text(
                      '${don.centre}\n'
                      'Date : ${don.date.day}/${don.date.month}/${don.date.year}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
