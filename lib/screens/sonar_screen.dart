import 'package:flutter/material.dart';
import '../app_theme.dart';

class SonarScreen extends StatefulWidget {
  const SonarScreen({super.key});
  @override
  State<SonarScreen> createState() => _SonarScreenState();
}

class _SonarScreenState extends State<SonarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) => Column(
        children: [
          Container(
            color: context.cardBg,
            child: TabBar(
              controller: _tab,
              labelColor: context.primary,
              unselectedLabelColor: context.onSurface.withValues(alpha: 0.5),
              indicatorColor: context.primary,
              tabs: const [
                Tab(text: 'Modèles Sonar'),
                Tab(text: 'API & Usage'),
                Tab(text: 'Focus modes'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _ModelsTab(),
                _ApiTab(),
                _FocusTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab 1 : Modèles Sonar ───────────────────────────────────────────────────

class _ModelsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    final c2 = context.secondary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Les modèles Sonar', context),
        _InfoCard(
          icon: Icons.search,
          color: c,
          title: 'Qu\'est-ce que Sonar ?',
          body: 'Sonar est la gamme de modèles de Perplexity optimisés pour la recherche '
              'web en temps réel. Chaque réponse cite ses sources avec des références '
              'vérifiables, contrairement aux LLMs classiques.',
        ),
        const SizedBox(height: 8),
        sectionTitle('Gamme Online (avec recherche)', context),
        _ModelCard(
          color: c,
          name: 'sonar',
          type: 'Online',
          ctx: '127K',
          note: 'Recherche rapide, usage quotidien',
        ),
        _ModelCard(
          color: c2,
          name: 'sonar-pro',
          type: 'Online',
          ctx: '200K',
          note: 'Recherches approfondies, 2 passes',
        ),
        _ModelCard(
          color: c,
          name: 'sonar-reasoning',
          type: 'Online + CoT',
          ctx: '127K',
          note: 'Raisonnement + sources web',
        ),
        _ModelCard(
          color: c2,
          name: 'sonar-reasoning-pro',
          type: 'Online + CoT',
          ctx: '200K',
          note: 'Raisonnement profond + multi-sources',
        ),
        const SizedBox(height: 8),
        sectionTitle('Modèle Offline (sans recherche)', context),
        _ModelCard(
          color: c,
          name: 'r1-1776',
          type: 'Offline',
          ctx: '128K',
          note: 'DeepSeek-R1 fine-tuné par Perplexity, sans biais',
        ),
        const SizedBox(height: 8),
        sectionTitle('Comparaison', context),
        _InfoCard(
          icon: Icons.compare_arrows_outlined,
          color: c2,
          title: 'Quand utiliser quel modèle ?',
          body: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tipRow(context, c, 'sonar → questions générales, résumés rapides'),
              _tipRow(context, c2, 'sonar-pro → recherche académique, sujets complexes'),
              _tipRow(context, c, 'sonar-reasoning → problèmes logiques avec sources'),
              _tipRow(context, c2, 'sonar-reasoning-pro → analyses approfondies multi-étapes'),
              _tipRow(context, c, 'r1-1776 → raisonnement sans accès web, privé'),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _tipRow(BuildContext ctx, Color c, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_right, color: c, size: 18),
            const SizedBox(width: 4),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      color: ctx.onSurface.withValues(alpha: 0.75),
                      fontSize: 13)),
            ),
          ],
        ),
      );
}

// ── Tab 2 : API & Usage ─────────────────────────────────────────────────────

class _ApiTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    final c2 = context.secondary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Configurer l\'API Perplexity', context),
        _StepCard(
          step: 1,
          color: c,
          title: 'Obtenir une clé API',
          child: Text(
            'Créez un compte sur perplexity.ai → Settings → API → '
            'Generate API key. La clé commence par "pplx-".',
            style: TextStyle(
                color: context.onSurface.withValues(alpha: 0.8), fontSize: 13),
          ),
        ),
        _StepCard(
          step: 2,
          color: c,
          title: 'Installer le SDK (compatible OpenAI)',
          child: const CodeBlock(
            code: 'pip install openai',
          ),
        ),
        _StepCard(
          step: 3,
          color: c,
          title: 'Premier appel API — Python',
          child: const CodeBlock(
            code: 'from openai import OpenAI\n\n'
                'client = OpenAI(\n'
                '  api_key="pplx-votre_cle",\n'
                '  base_url="https://api.perplexity.ai"\n'
                ')\n\n'
                'response = client.chat.completions.create(\n'
                '  model="sonar",\n'
                '  messages=[\n'
                '    {"role": "system", "content": "Réponds avec des sources précises."},\n'
                '    {"role": "user", "content": "Quelle est l\'actualité en IA ce mois-ci ?"}\n'
                '  ]\n'
                ')\n\n'
                'print(response.choices[0].message.content)',
          ),
        ),
        _StepCard(
          step: 4,
          color: c,
          title: 'Accéder aux citations',
          child: const CodeBlock(
            code: '# Les sources sont dans la réponse\n'
                'result = response.choices[0].message\n'
                'print(result.content)  # texte avec [1], [2]...\n\n'
                '# Citations disponibles dans :\n'
                'citations = response.citations  # liste d\'URLs\n'
                'for i, url in enumerate(citations, 1):\n'
                '    print(f"[{i}] {url}")',
          ),
        ),
        const SizedBox(height: 8),
        sectionTitle('Streaming', context),
        _InfoCard(
          icon: Icons.stream_outlined,
          color: c2,
          title: 'Réponse en streaming',
          body: null,
          child: const CodeBlock(
            code: 'stream = client.chat.completions.create(\n'
                '  model="sonar-pro",\n'
                '  messages=[{"role": "user", "content": "Explique le Web 3.0"}],\n'
                '  stream=True\n'
                ')\n\n'
                'for chunk in stream:\n'
                '  delta = chunk.choices[0].delta.content\n'
                '  if delta:\n'
                '    print(delta, end="", flush=True)',
          ),
        ),
        const SizedBox(height: 8),
        sectionTitle('Tarification', context),
        _InfoCard(
          icon: Icons.attach_money,
          color: c,
          title: 'Prix par 1M tokens',
          body: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _priceRow(context, c, 'sonar',               '1\$',  '1\$'),
              _priceRow(context, c2, 'sonar-pro',          '3\$',  '15\$'),
              _priceRow(context, c, 'sonar-reasoning',     '1\$',  '5\$'),
              _priceRow(context, c2, 'sonar-reasoning-pro','2\$',  '8\$'),
              _priceRow(context, c, 'r1-1776',             '2\$',  '8\$'),
              const SizedBox(height: 4),
              Text('+ 5\$/1000 requêtes pour les modèles Online',
                  style: TextStyle(
                      color: context.onSurface.withValues(alpha: 0.55),
                      fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _priceRow(BuildContext ctx, Color c, String model, String input, String output) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(model,
                  style: TextStyle(
                      color: c, fontSize: 12, fontWeight: FontWeight.w600,
                      fontFamily: 'monospace')),
            ),
            Text('In: $input',
                style: TextStyle(
                    color: ctx.onSurface.withValues(alpha: 0.65), fontSize: 11)),
            const SizedBox(width: 10),
            Text('Out: $output',
                style: TextStyle(
                    color: ctx.onSurface.withValues(alpha: 0.65), fontSize: 11)),
          ],
        ),
      );
}

// ── Tab 3 : Focus modes ─────────────────────────────────────────────────────

class _FocusTab extends StatelessWidget {
  static final _modes = [
    _FocusMode(
      icon: Icons.public_outlined,
      title: 'Web (défaut)',
      description: 'Recherche sur l\'ensemble du web. Mode généraliste adapté '
          'à toutes les questions d\'actualité et de connaissance générale.',
      example: '"Quelles sont les dernières nouvelles en IA ?"',
    ),
    _FocusMode(
      icon: Icons.school_outlined,
      title: 'Academic',
      description: 'Recherche dans les publications scientifiques et académiques. '
          'Cible PubMed, arXiv, Semantic Scholar et autres bases de données scientifiques.',
      example: '"Études récentes sur les effets de la méditation sur le stress"',
    ),
    _FocusMode(
      icon: Icons.newspaper_outlined,
      title: 'News',
      description: 'Recherche dans les sources d\'actualité récentes. '
          'Idéal pour suivre les événements en cours et l\'actualité mondiale.',
      example: '"Actualités économiques des 48 dernières heures"',
    ),
    _FocusMode(
      icon: Icons.edit_note_outlined,
      title: 'Writing',
      description: 'Mode orienté rédaction sans recherche web active. '
          'Le modèle se concentre sur la qualité de l\'écriture plutôt que sur les sources.',
      example: '"Écris un article de blog sur les tendances du e-commerce"',
    ),
    _FocusMode(
      icon: Icons.calculate_outlined,
      title: 'Wolfram Alpha',
      description: 'Intégration avec Wolfram Alpha pour les calculs mathématiques, '
          'scientifiques et les données factuelles vérifiables.',
      example: '"Calcule la distance de la Terre à Mars aujourd\'hui"',
    ),
    _FocusMode(
      icon: Icons.play_circle_outline,
      title: 'YouTube',
      description: 'Recherche et résumé de vidéos YouTube. '
          'Perplexity analyse le contenu des vidéos et fournit des résumés avec timestamps.',
      example: '"Résume cette vidéo YouTube : [URL]"',
    ),
    _FocusMode(
      icon: Icons.forum_outlined,
      title: 'Reddit',
      description: 'Recherche dans les discussions Reddit. '
          'Idéal pour trouver des avis d\'utilisateurs, des retours d\'expérience '
          'et des recommandations communautaires.',
      example: '"Meilleurs frameworks backend selon Reddit en 2025"',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.primary;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        sectionTitle('Modes de recherche ciblée', context),
        _InfoCard(
          icon: Icons.filter_alt_outlined,
          color: c,
          title: 'Qu\'est-ce qu\'un Focus mode ?',
          body: 'Les Focus modes permettent de restreindre la recherche Perplexity '
              'à des sources spécifiques. Disponibles dans l\'interface web et mobile, '
              'certains sont aussi accessibles via l\'API.',
        ),
        const SizedBox(height: 8),
        ..._modes.asMap().entries.map((e) => _FocusCard(
              mode: e.value,
              color: context.palette[e.key % context.palette.length],
            )),
        const SizedBox(height: 8),
        sectionTitle('Focus via l\'API', context),
        _InfoCard(
          icon: Icons.code_outlined,
          color: context.secondary,
          title: 'Paramètre search_domain_filter',
          body: null,
          child: const CodeBlock(
            code: '# Restreindre à des domaines spécifiques\n'
                'response = client.chat.completions.create(\n'
                '  model="sonar-pro",\n'
                '  messages=[{"role": "user",\n'
                '    "content": "Dernières recherches sur GPT-4"}],\n'
                '  extra_body={\n'
                '    "search_domain_filter": ["arxiv.org", "openai.com"],\n'
                '    "search_recency_filter": "week"\n'
                '  }\n'
                ')',
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _FocusCard extends StatefulWidget {
  final _FocusMode mode;
  final Color color;
  const _FocusCard({required this.mode, required this.color});

  @override
  State<_FocusCard> createState() => _FocusCardState();
}

class _FocusCardState extends State<_FocusCard> {
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
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(widget.mode.icon, color: c, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.mode.title,
                        style: TextStyle(
                            color: c,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
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
                  Text(widget.mode.description,
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.8),
                          fontSize: 13,
                          height: 1.5)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: c.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.format_quote, color: c, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(widget.mode.example,
                              style: TextStyle(
                                  color: c,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ── Shared widgets ──────────────────────────────────────────────────────────

class _FocusMode {
  final IconData icon;
  final String title;
  final String description;
  final String example;

  const _FocusMode({
    required this.icon,
    required this.title,
    required this.description,
    required this.example,
  });
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? body;
  final Widget? child;

  const _InfoCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
            ],
          ),
          if (body != null) ...[
            const SizedBox(height: 10),
            Text(body!,
                style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.8),
                    fontSize: 13,
                    height: 1.5)),
          ],
          if (child != null) ...[
            const SizedBox(height: 10),
            child!,
          ],
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final Color color;
  final String name;
  final String type;
  final String ctx;
  final String note;

  const _ModelCard({
    required this.color,
    required this.name,
    required this.type,
    required this.ctx,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'monospace')),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(type,
                style: TextStyle(color: color, fontSize: 10)),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(ctx,
                style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.6),
                    fontSize: 10)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(note,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.55),
                    fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int step;
  final Color color;
  final String title;
  final Widget child;

  const _StepCard({
    required this.step,
    required this.color,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$step',
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                const SizedBox(height: 8),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
