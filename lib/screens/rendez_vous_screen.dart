import 'package:flutter/material.dart';
import '../models/centre.dart';
import '../models/rendez_vous.dart';
import 'confirmation_screen.dart';

class RendezVousScreen extends StatefulWidget {
  final Centre centre;

  const RendezVousScreen({
    super.key,
    required this.centre,
  });

  @override
  State<RendezVousScreen> createState() => _RendezVousScreenState();
}

class _RendezVousScreenState extends State<RendezVousScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();

  String groupeSanguin = 'A+';
  String creneau = 'Matin';
  String typeDon = 'Sang total';
  DateTime? dateChoisie;
  bool conditionsAcceptees = false;

  final groupes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  Future<void> choisirDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        dateChoisie = date;
      });
    }
  }

  void confirmerRendezVous() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (dateChoisie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez choisir une date'),
        ),
      );
      return;
    }

    if (!conditionsAcceptees) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez accepter les conditions'),
        ),
      );
      return;
    }

    final rendezVous = RendezVous(
      nomComplet: nomController.text.trim(),
      groupeSanguin: groupeSanguin,
      centre: widget.centre.nom,
      date: dateChoisie!,
      creneau: creneau,
      typeDon: typeDon,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmationScreen(
          rendezVous: rendezVous,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre rendez-vous'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Centre : ${widget.centre.nom}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nomController,
              decoration: const InputDecoration(
                labelText: 'Nom et prénom',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().length < 3) {
                  return 'Entrez un nom d’au moins 3 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: groupeSanguin,
              decoration: const InputDecoration(
                labelText: 'Groupe sanguin',
                border: OutlineInputBorder(),
              ),
              items: groupes.map((groupe) {
                return DropdownMenuItem(
                  value: groupe,
                  child: Text(groupe),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  groupeSanguin = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: typeDon,
              decoration: const InputDecoration(
                labelText: 'Type de don',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Sang total',
                  child: Text('Sang total'),
                ),
                DropdownMenuItem(
                  value: 'Plasma',
                  child: Text('Plasma'),
                ),
                DropdownMenuItem(
                  value: 'Plaquettes',
                  child: Text('Plaquettes'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  typeDon = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: choisirDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                dateChoisie == null
                    ? 'Choisir une date'
                    : '${dateChoisie!.day}/${dateChoisie!.month}/${dateChoisie!.year}',
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: creneau,
              decoration: const InputDecoration(
                labelText: 'Créneau horaire',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Matin',
                  child: Text('Matin'),
                ),
                DropdownMenuItem(
                  value: 'Après-midi',
                  child: Text('Après-midi'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  creneau = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: conditionsAcceptees,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'Je confirme avoir 18 ans ou plus et être en bonne santé.',
              ),
              onChanged: (value) {
                setState(() {
                  conditionsAcceptees = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: confirmerRendezVous,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Confirmer le rendez-vous'),
            ),
          ],
        ),
      ),
    );
  }
}
