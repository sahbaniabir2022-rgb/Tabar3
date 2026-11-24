import 'package:flutter/material.dart';
import '../models/rendez_vous.dart';
import 'accueil_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final RendezVous rendezVous;

  const ConfirmationScreen({
    super.key,
    required this.rendezVous,
  });

  @override
  Widget build(BuildContext context) {
    final date = rendezVous.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 90,
            ),
            const SizedBox(height: 20),
            const Text(
              'Rendez-vous confirmé !',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    detail('Nom', rendezVous.nomComplet),
                    detail('Groupe sanguin', rendezVous.groupeSanguin),
                    detail('Centre', rendezVous.centre),
                    detail(
                      'Date',
                      '${date.day}/${date.month}/${date.year}',
                    ),
                    detail('Créneau', rendezVous.creneau),
                    detail('Type de don', rendezVous.typeDon),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AccueilScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Retour à l’accueil'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detail(String titre, String valeur) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              titre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(valeur)),
        ],
      ),
    );
  }
}
