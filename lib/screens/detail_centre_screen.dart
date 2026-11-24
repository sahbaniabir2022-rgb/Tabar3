import 'package:flutter/material.dart';
import '../models/centre.dart';
import 'rendez_vous_screen.dart';

class DetailCentreScreen extends StatelessWidget {
  final Centre centre;

  const DetailCentreScreen({
    super.key,
    required this.centre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du centre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Icon(
              Icons.local_hospital,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              centre.nom,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text('Adresse'),
              subtitle: Text(
                '${centre.adresse}, ${centre.gouvernorat}',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.red),
              title: const Text('Téléphone'),
              subtitle: Text(centre.telephone),
            ),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.red),
              title: const Text('Horaires'),
              subtitle: Text(centre.horaires),
            ),
            const SizedBox(height: 15),
            const Text(
              'Groupes sanguins recherchés',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: centre.groupesRecherches.map((groupe) {
                return Chip(
                  label: Text(groupe),
                  backgroundColor: Colors.red.shade50,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: const Text('Prendre un rendez-vous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RendezVousScreen(
                      centre: centre,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
