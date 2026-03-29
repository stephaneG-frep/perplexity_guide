import 'package:flutter/material.dart';
import '../app_theme.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  static final _features = [
    _Feature(
      icon: Icons.travel_explore,
      title: 'Recherche web en temps réel',
      description:
          'Les modèles sonar et sonar-pro ont accès à Internet et fournissent des résultats actualisés en temps réel.',
      tips: [
        'Accès à Internet intégré nativement',
        'Résultats toujours à jour',
        'Aucune date de coupure des connaissances',
        'Idéal pour les actualités et tendances',
      ],
    ),
    _Feature(
      icon: Icons.format_quote,
      title: 'Citations automatiques',
      description:
          'Chaque réponse inclut automatiquement les sources utilisées, disponibles dans le champ "citations" de la réponse JSON.',
      tips: [
        'Liste d\'URLs sources dans la réponse',
        'Vérification facile des informations',
        'Transparence sur les données utilisées',
        'Accessible via data["citations"]',
      ],
    ),
    _Feature(
      icon: Icons.radar,
      title: 'Modèles Sonar',
      description:
          'Architecture Sonar optimisée spécifiquement pour la recherche et la synthèse d\'informations web.',
      tips: [
        'sonar-pro : le plus puissant',
        'sonar : rapide et efficace',
        'Optimisé pour la recherche en ligne',
        'Synthèse intelligente des sources',
      ],
    ),
    _Feature(
      icon: Icons.api,
      title: 'API Compatible OpenAI',
      description:
          'L\'API Perplexity est 100% compatible avec le format OpenAI. Migrez facilement depuis GPT.',
      tips: [
        'Utilise le SDK openai Python/JS directement',
        'Migration facile depuis GPT ou autres LLMs',
        'Même format de requêtes et réponses',
        'Support streaming identique',
      ],
    ),
    _Feature(
      icon: Icons.psychology_outlined,
      title: 'Raisonnement avancé',
      description:
          'Les modèles sonar-reasoning et sonar-reasoning-pro intègrent un raisonnement Chain of Thought pour les analyses complexes.',
      tips: [
        'sonar-reasoning-pro : CoT + recherche web',
        'Idéal pour les problèmes complexes',
        'Décomposition structurée des réponses',
        'Meilleure précision sur les tâches difficiles',
      ],
    ),
    _Feature(
      icon: Icons.memory,
      title: 'Contexte étendu',
      description:
          'Fenêtre de contexte large pour traiter de longs documents, bases de code entières et conversations étendues.',
      tips: [
        'Analyse de longs documents',
        'Conversations étendues sans perte de contexte',
        'Traitement de bases de code complètes',
        'Résumé de textes volumineux',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, child) => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _features.length,
        itemBuilder: (context, i) => _FeatureCard(
          feature: _features[i],
          color: context.palette[i % context.palette.length],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final _Feature feature;
  final Color color;
  const _FeatureCard({required this.feature, required this.color});
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.feature.icon, color: widget.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.feature.title,
                        style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                      color: widget.color, size: 20),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: widget.color.withValues(alpha: 0.2)),
                  Text(widget.feature.description,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.8),
                          fontSize: 13,
                          height: 1.5)),
                  const SizedBox(height: 10),
                  ...widget.feature.tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_right, color: widget.color, size: 18),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(tip,
                                  style: TextStyle(
                                      color: context.onSurface.withValues(alpha: 0.7),
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tips;
  const _Feature(
      {required this.icon,
      required this.title,
      required this.description,
      required this.tips});
}
