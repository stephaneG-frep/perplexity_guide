import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  static final _apps = [
    _App(
      icon: Icons.search_rounded,
      title: 'Perplexity — Application officielle',
      category: 'Officiel Perplexity',
      description:
          'L\'application mobile officielle de Perplexity pour iOS et Android. '
          'Recherche web avec IA, citations sources, Focus modes, '
          'historique des conversations et Discover (fil d\'actualité IA).',
      tips: [
        'iOS : App Store → "Perplexity — Ask Anything"',
        'Android : Play Store → "Perplexity"',
        'Gratuit avec 5 requêtes Pro/jour',
        'Pro : 20\$/mois — requêtes illimitées avec sonar-pro',
        'Discover : fil d\'actualité généré par IA',
      ],
    ),
    _App(
      icon: Icons.desktop_mac_outlined,
      title: 'Perplexity for Mac',
      category: 'Officiel Perplexity',
      description:
          'Application desktop native pour macOS avec raccourci clavier global. '
          'Permet de poser des questions à Perplexity depuis n\'importe quelle '
          'application sans changer de fenêtre.',
      tips: [
        'Téléchargement : perplexity.ai/download',
        'Raccourci global configurable (ex: Cmd+Shift+P)',
        'Interface flottante sur toutes les apps',
        'Historique synchronisé avec l\'app mobile',
        'Gratuit avec compte Perplexity',
      ],
    ),
    _App(
      icon: Icons.hub_outlined,
      title: 'Perplexity API — Intégrations',
      category: 'Développement',
      description:
          'L\'API Perplexity (base_url: api.perplexity.ai) est compatible OpenAI. '
          'Elle s\'intègre facilement dans n\'importe quel outil '
          'qui supporte un endpoint OpenAI personnalisé.',
      tips: [
        'Compatible avec le SDK OpenAI (Python, Node.js)',
        'Intégrable dans LangChain, LlamaIndex',
        'Utilisable dans Continue.dev, Cursor',
        'Clé API : perplexity.ai → Settings → API',
        'Format : clé commence par "pplx-"',
      ],
    ),
    _App(
      icon: Icons.edit_outlined,
      title: 'Cursor avec Perplexity',
      category: 'Développement',
      description:
          'Configurez Cursor (éditeur IA) pour utiliser les modèles Perplexity. '
          'sonar-reasoning-pro est particulièrement efficace pour les recherches '
          'de documentation et d\'API en temps réel.',
      tips: [
        'Cursor Settings → Models → Custom',
        'Base URL : https://api.perplexity.ai',
        'Model : sonar-pro ou sonar-reasoning',
        'Idéal pour chercher de la doc à jour pendant le code',
        'Téléchargement : cursor.sh',
      ],
    ),
    _App(
      icon: Icons.extension_outlined,
      title: 'Continue.dev avec Perplexity',
      category: 'Développement',
      description:
          'Extension VS Code open source configurable avec l\'API Perplexity. '
          'Combine l\'assistance au code et la recherche web '
          'en temps réel dans votre éditeur.',
      tips: [
        'Extension VS Code : "Continue"',
        'config.json : provider "openai" + base_url Perplexity',
        'Parfait pour la recherche de packages et d\'erreurs',
        'Open source : github.com/continuedev/continue',
        'Gratuit avec votre clé API Perplexity',
      ],
    ),
    _App(
      icon: Icons.auto_stories_outlined,
      title: 'Notion + Perplexity',
      category: 'Productivité',
      description:
          'Intégrez Perplexity dans votre workflow Notion via l\'API '
          'pour enrichir automatiquement vos notes avec des recherches '
          'citées et des résumés de sources fiables.',
      tips: [
        'Via API : connecteur Make ou Zapier → Perplexity API',
        'Enrichissement automatique de notes de veille',
        'Résumé d\'articles avec citations',
        'Idéal pour la veille technologique',
        'Template : prompt → Perplexity → Notion database',
      ],
    ),
    _App(
      icon: Icons.chat_outlined,
      title: 'Slack / Teams + Perplexity',
      category: 'Productivité',
      description:
          'Intégrez un bot Perplexity dans vos canaux Slack ou Teams '
          'pour répondre aux questions d\'équipe avec des sources vérifiées '
          'en temps réel.',
      tips: [
        'Slack App Directory → Perplexity AI (bot officiel)',
        'Ou créer un bot custom via l\'API Perplexity',
        'Mention @perplexity dans un canal',
        'Réponses avec sources directement dans le fil',
        'Utile pour les équipes de veille et support',
      ],
    ),
    _App(
      icon: Icons.psychology_outlined,
      title: 'LangChain + Perplexity',
      category: 'Développement',
      description:
          'Intégrez Perplexity comme LLM dans vos pipelines LangChain '
          'pour combiner recherche web en temps réel et chaînes de traitement '
          'de documents complexes.',
      tips: [
        'pip install langchain-openai',
        'ChatOpenAI(base_url="https://api.perplexity.ai", model="sonar")',
        'Idéal pour les agents RAG avec sources web',
        'Combine bien avec les vector stores locaux',
        'Documentation : python.langchain.com',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) => ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _apps.length,
        itemBuilder: (context, i) => _AppCard(
          app: _apps[i],
          color: context.palette[i % context.palette.length],
        ),
      ),
    );
  }
}

class _AppCard extends StatefulWidget {
  final _App app;
  final Color color;
  const _AppCard({required this.app, required this.color});

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withValues(alpha: 0.3)),
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
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.app.icon, color: c, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.app.title,
                            style: TextStyle(
                                color: c,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: c.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(widget.app.category,
                              style: TextStyle(
                                  color: c,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                      color: c, size: 20),
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
                  Divider(color: c.withValues(alpha: 0.2)),
                  Text(widget.app.description,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.8),
                          fontSize: 13,
                          height: 1.5)),
                  const SizedBox(height: 10),
                  ...widget.app.tips.map((tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_right, color: c, size: 18),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(tip,
                                  style: TextStyle(
                                      color: context.onSurface
                                          .withValues(alpha: 0.7),
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

class _App {
  final IconData icon;
  final String title;
  final String category;
  final String description;
  final List<String> tips;

  const _App({
    required this.icon,
    required this.title,
    required this.category,
    required this.description,
    required this.tips,
  });
}
