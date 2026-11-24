
import 'package:flutter/material.dart';
import '../models/centre.dart';

class CentreCard extends StatelessWidget {
  final Centre centre;
  final VoidCallback onTap;

  const CentreCard({
    super.key,
    required this.centre,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const rouge = Color(0xFFE53935);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Nom et icone du centre
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5E5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.local_hospital,
                      color: rouge,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          centre.nom,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF292929),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 15,
                              color: rouge,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${centre.gouvernorat} - ${centre.adresse}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: rouge,
                  ),
                ],
              ),

              const SizedBox(height: 15),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // Horaires
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 18,
                    color: rouge,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      centre.horaires,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 9),

              // Telephone
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 18,
                    color: rouge,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    centre.telephone,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Groupes sanguins
              if (centre.groupesRecherches.isNotEmpty) ...[
                const Text(
                  'Groupes sanguins recherchés',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF555555),
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: centre.groupesRecherches.map((groupe) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5E5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        groupe,
                        style: const TextStyle(
                          color: rouge,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
