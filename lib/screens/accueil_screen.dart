
import 'package:flutter/material.dart';
import '../data/donnees_fictives.dart';
import '../models/centre.dart';
import '../widgets/centre_card.dart';
import '../widgets/eligibility_banner.dart';
import 'detail_centre_screen.dart';
import 'historique_screen.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final TextEditingController rechercheController =
      TextEditingController();

  String recherche = '';
  String gouvernorat = 'Tous';

  List<Centre> get centresFiltres {
    return centres.where((centre) {
      final nomCorrespond = centre.nom
              .toLowerCase()
              .contains(recherche.toLowerCase()) ||
          centre.adresse
              .toLowerCase()
              .contains(recherche.toLowerCase());

      final gouvernoratCorrespond =
          gouvernorat == 'Tous' ||
          centre.gouvernorat == gouvernorat;

      return nomCorrespond && gouvernoratCorrespond;
    }).toList();
  }

  @override
  void dispose() {
    rechercheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final centresAffiches = centresFiltres;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.favorite, size: 27),
            SizedBox(width: 10),
            Text(
              'Tabarra3',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Historique',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoriqueScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bannière de sensibilisation
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: EligibilityBanner(
              message: 'Chaque don peut sauver une vie !',
            ),
          ),

          // Barre de recherche
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: TextField(
              controller: rechercheController,
              decoration: InputDecoration(
                hintText: 'Rechercher un centre...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFE53935),
                ),
                suffixIcon: recherche.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          rechercheController.clear();
                          setState(() {
                            recherche = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  recherche = value;
                });
              },
            ),
          ),

          // Filtre gouvernorat
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: DropdownButtonFormField<String>(
              value: gouvernorat,
              decoration: InputDecoration(
                labelText: 'Gouvernorat',
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Color(0xFFE53935),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Tous',
                  child: Text('Tous les gouvernorats'),
                ),
                DropdownMenuItem(
                  value: 'Bizerte',
                  child: Text('Bizerte'),
                ),
                DropdownMenuItem(
                  value: 'Tunis',
                  child: Text('Tunis'),
                ),
                DropdownMenuItem(
                  value: 'Sousse',
                  child: Text('Sousse'),
                ),
                DropdownMenuItem(
                  value: 'Nabeul',
                  child: Text('Nabeul'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  gouvernorat = value ?? 'Tous';
                });
              },
            ),
          ),

          // Titre et nombre de centres
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Centres de don de sang',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292929),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${centresAffiches.length} centres',
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Liste des centres
          Expanded(
            child: centresAffiches.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 55,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Aucun centre trouvé',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    itemCount: centresAffiches.length,
                    itemBuilder: (context, index) {
                      final centre = centresAffiches[index];

                      return CentreCard(
                        centre: centre,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailCentreScreen(
                                centre: centre,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
