import 'package:flutter/material.dart';
import '../app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static final _questions = [
    // ── Fondamentaux ─────────────────────────────────────────────────────
    _Question(
      question: 'Quelle est la principale différence entre Perplexity et ChatGPT ?',
      options: [
        'Perplexity est gratuit, ChatGPT est payant',
        'Perplexity effectue des recherches web en temps réel et cite ses sources',
        'Perplexity génère des images, ChatGPT non',
        'Perplexity utilise un modèle propriétaire unique',
      ],
      correct: 1,
      explanation: 'Perplexity est un moteur de recherche conversationnel : '
          'chaque réponse est basée sur des recherches web en temps réel '
          'avec des citations vérifiables. ChatGPT utilise des données d\'entraînement statiques.',
    ),
    _Question(
      question: 'Comment s\'appelle la gamme de modèles de Perplexity optimisés pour la recherche web ?',
      options: ['Nexus', 'Sonar', 'Radar', 'Signal'],
      correct: 1,
      explanation: 'Les modèles Sonar sont les modèles de Perplexity avec accès '
          'à la recherche web en temps réel. Ils existent en plusieurs variantes : '
          'sonar, sonar-pro, sonar-reasoning, sonar-reasoning-pro.',
    ),
    _Question(
      question: 'Quel modèle Perplexity fonctionne sans accès internet (offline) ?',
      options: ['sonar-offline', 'sonar-local', 'r1-1776', 'perplexity-base'],
      correct: 2,
      explanation: 'r1-1776 est une version de DeepSeek-R1 fine-tunée par Perplexity '
          'sans accès web. Le nom "1776" fait référence à la Déclaration d\'Indépendance '
          'américaine, symbolisant la liberté de biais.',
    ),
    _Question(
      question: 'Quelle est la taille du contexte de sonar-pro ?',
      options: ['32 000 tokens', '64 000 tokens', '127 000 tokens', '200 000 tokens'],
      correct: 3,
      explanation: 'sonar-pro dispose d\'une fenêtre de contexte de 200 000 tokens, '
          'la plus grande de la gamme Sonar. Il effectue aussi 2 passes de recherche '
          'pour des réponses plus approfondies.',
    ),
    // ── API & Technique ──────────────────────────────────────────────────
    _Question(
      question: 'Quel est le base URL de l\'API Perplexity ?',
      options: [
        'https://api.perplexity.com',
        'https://perplexity.ai/api/v1',
        'https://api.perplexity.ai',
        'https://api.pplx.ai/v1',
      ],
      correct: 2,
      explanation: 'Le base URL officiel est https://api.perplexity.ai. '
          'L\'API est compatible avec le SDK OpenAI — '
          'utilisez base_url="https://api.perplexity.ai" avec votre clé "pplx-...".',
    ),
    _Question(
      question: 'Par quelle séquence commence une clé API Perplexity ?',
      options: ['sk-', 'pplx-', 'prx-', 'api-'],
      correct: 1,
      explanation: 'Les clés API Perplexity commencent par "pplx-". '
          'Elles sont générées depuis perplexity.ai → Settings → API Keys.',
    ),
    _Question(
      question: 'Où Perplexity fournit-il les URLs des sources dans la réponse API ?',
      options: [
        'Dans le champ message.sources',
        'Dans response.citations',
        'Dans response.metadata.links',
        'Perplexity ne fournit pas les URLs via API',
      ],
      correct: 1,
      explanation: 'Les citations sont disponibles dans response.citations, '
          'une liste d\'URLs correspondant aux numéros [1], [2]... '
          'qui apparaissent dans le texte de la réponse.',
    ),
    _Question(
      question: 'Quel paramètre API permet de restreindre la recherche à des domaines spécifiques ?',
      options: [
        'domain_filter',
        'search_domain_filter',
        'allowed_sources',
        'restrict_to',
      ],
      correct: 1,
      explanation: 'Le paramètre search_domain_filter (dans extra_body) '
          'permet de restreindre la recherche à des domaines précis. '
          'Exemple : search_domain_filter=["arxiv.org", "nature.com"].',
    ),
    _Question(
      question: 'Quel paramètre API limite la recherche aux résultats récents ?',
      options: [
        'date_filter: "recent"',
        'search_recency_filter: "week"',
        'max_age_days: 7',
        'fresh_results: true',
      ],
      correct: 1,
      explanation: 'search_recency_filter accepte "hour", "day", "week" ou "month". '
          'Il est passé dans extra_body lors de l\'appel API. '
          'Très utile pour les questions d\'actualité.',
    ),
    // ── Focus modes ──────────────────────────────────────────────────────
    _Question(
      question: 'Quel Focus mode Perplexity cible les publications scientifiques ?',
      options: ['Web', 'Scholar', 'Academic', 'Research'],
      correct: 2,
      explanation: 'Le Focus mode "Academic" recherche dans les bases de données '
          'scientifiques : PubMed, arXiv, Semantic Scholar. '
          'Idéal pour les recherches bibliographiques.',
    ),
    _Question(
      question: 'Quel Focus mode permet de résumer une vidéo YouTube ?',
      options: ['Video', 'Media', 'YouTube', 'Stream'],
      correct: 2,
      explanation: 'Le Focus mode "YouTube" permet à Perplexity d\'analyser '
          'et de résumer des vidéos YouTube, y compris avec des timestamps. '
          'Il faut fournir l\'URL de la vidéo dans le prompt.',
    ),
    // ── Tarification & usage ─────────────────────────────────────────────
    _Question(
      question: 'Quel est le modèle le moins cher de l\'API Perplexity ?',
      options: ['r1-1776', 'sonar-pro', 'sonar', 'sonar-reasoning'],
      correct: 2,
      explanation: '"sonar" est le moins cher à ~1\$/1M tokens en entrée et sortie. '
          'Il est adapté aux usages à fort volume avec recherche web simple.',
    ),
    // ── Bonnes pratiques prompts ─────────────────────────────────────────
    _Question(
      question: 'Comment tirer le meilleur parti des citations Perplexity dans un prompt ?',
      options: [
        'Ne pas mentionner les sources, Perplexity les ajoute toujours',
        'Demander explicitement "avec sources" ou "cite tes références"',
        'Utiliser uniquement sonar-pro pour avoir des sources',
        'Les sources ne sont disponibles que via l\'application officielle',
      ],
      correct: 1,
      explanation: 'Bien que Perplexity cite souvent ses sources automatiquement, '
          'préciser "cite tes références" ou "avec sources académiques" '
          'oriente le modèle vers plus de rigueur et de pertinence dans les citations.',
    ),
    _Question(
      question: 'Quelle formulation de prompt donne les meilleurs résultats avec sonar-reasoning ?',
      options: [
        '"Réponds rapidement à..."',
        '"Raisonne étape par étape et appuie-toi sur des sources récentes pour..."',
        '"Sois bref sur..."',
        '"Cherche sur Google..."',
      ],
      correct: 1,
      explanation: 'sonar-reasoning combine Chain-of-Thought et recherche web. '
          'Lui demander de "raisonner étape par étape" active pleinement '
          'ses capacités de décomposition logique avec sources vérifiées.',
    ),
    _Question(
      question: 'Quelle est la bonne pratique pour une recherche académique avec Perplexity ?',
      options: [
        'Utiliser le mode Web avec un prompt très court',
        'Utiliser sonar-pro en Focus Academic avec une question précise et un contexte clair',
        'Utiliser r1-1776 qui a plus de connaissances académiques',
        'Perplexity n\'est pas adapté à la recherche académique',
      ],
      correct: 1,
      explanation: 'Pour la recherche académique : '
          '1) choisissez sonar-pro (contexte 200K, double recherche) '
          '2) activez le Focus mode Academic '
          '3) formulez une question précise avec le domaine d\'étude.',
    ),
    _Question(
      question: 'Que signifie "Discover" dans l\'application Perplexity ?',
      options: [
        'Un moteur de recherche d\'images',
        'Un fil d\'actualité généré par IA avec résumés sourcés',
        'La fonctionnalité de découverte de nouvelles APIs',
        'Le mode de recherche avancée',
      ],
      correct: 1,
      explanation: '"Discover" est le fil d\'actualité de Perplexity : '
          'une sélection d\'articles d\'actualité résumés par l\'IA avec sources, '
          'organisés par thèmes. Accessible depuis l\'app mobile et le site web.',
    ),
  ];

  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered = false;
  bool _finished = false;

  void _answer(int choice) {
    if (_answered) return;
    setState(() {
      _selected = choice;
      _answered = true;
      if (_questions[_index].correct == choice) _score++;
    });
  }

  void _next() {
    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
        _selected = null;
        _answered = false;
      });
    } else {
      setState(() => _finished = true);
    }
  }

  void _restart() {
    setState(() {
      _index = 0;
      _score = 0;
      _selected = null;
      _answered = false;
      _finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, child) {
        if (_finished) {
          return _ResultPage(score: _score, total: _questions.length, onRestart: _restart);
        }
        final q = _questions[_index];
        final c = context.primary;
        final c2 = context.secondary;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${_index + 1} / ${_questions.length}',
                      style: TextStyle(
                          color: context.onSurface.withValues(alpha: 0.6),
                          fontSize: 13)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_index + 1) / _questions.length,
                        backgroundColor: c.withValues(alpha: 0.15),
                        color: c,
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Icon(Icons.star, color: c2, size: 16),
                      const SizedBox(width: 4),
                      Text('$_score',
                          style: TextStyle(
                              color: c2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: context.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: c.withValues(alpha: 0.3)),
                ),
                child: Text(q.question,
                    style: TextStyle(
                        color: context.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.4)),
              ),
              const SizedBox(height: 16),
              ...List.generate(q.options.length, (i) {
                Color borderColor = c.withValues(alpha: 0.2);
                Color bgColor = context.cardBg;
                Color textColor = context.onSurface.withValues(alpha: 0.85);
                IconData? trailingIcon;

                if (_answered) {
                  if (i == q.correct) {
                    borderColor = Colors.green;
                    bgColor = Colors.green.withValues(alpha: 0.12);
                    textColor = Colors.green;
                    trailingIcon = Icons.check_circle_outline;
                  } else if (i == _selected && i != q.correct) {
                    borderColor = Colors.red;
                    bgColor = Colors.red.withValues(alpha: 0.1);
                    textColor = Colors.red.shade300;
                    trailingIcon = Icons.cancel_outlined;
                  }
                }

                return GestureDetector(
                  onTap: () => _answer(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: (_answered && i == q.correct)
                                ? Colors.green.withValues(alpha: 0.2)
                                : c.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(String.fromCharCode(65 + i),
                                style: TextStyle(
                                    color: (_answered && i == q.correct)
                                        ? Colors.green
                                        : c,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(q.options[i],
                              style: TextStyle(color: textColor, fontSize: 14)),
                        ),
                        if (trailingIcon != null)
                          Icon(trailingIcon,
                              color: i == q.correct
                                  ? Colors.green
                                  : Colors.red.shade300,
                              size: 20),
                      ],
                    ),
                  ),
                );
              }),
              if (_answered) ...[
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: c.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: c, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(q.explanation,
                            style: TextStyle(
                                color: context.onSurface.withValues(alpha: 0.8),
                                fontSize: 13,
                                height: 1.5)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      _index < _questions.length - 1
                          ? 'Question suivante →'
                          : 'Voir les résultats',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const _ResultPage({
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = score / total;
    final c = context.primary;
    final c2 = context.secondary;

    final (emoji, label, comment) = ratio >= 0.9
        ? ('🏆', 'Excellent !', 'Maîtrise parfaite de Perplexity !')
        : ratio >= 0.7
            ? ('⭐', 'Très bien !', 'Bonne connaissance, quelques points à revoir')
            : ratio >= 0.5
                ? ('👍', 'Pas mal !', 'Continuez à explorer le guide')
                : ('📚', 'À revoir', 'Relisez les sections du guide et réessayez');

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(label,
                style: TextStyle(
                    color: c, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(comment,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: context.onSurface.withValues(alpha: 0.7),
                    fontSize: 15)),
            const SizedBox(height: 32),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: c, width: 4),
                color: c.withValues(alpha: 0.08),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$score / $total',
                      style: TextStyle(
                          color: c,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  Text('${(ratio * 100).round()}%',
                      style: TextStyle(
                          color: c2,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: ratio,
                backgroundColor: c.withValues(alpha: 0.15),
                color: c,
                minHeight: 12,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh),
                label: const Text('Recommencer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Question {
  final String question;
  final List<String> options;
  final int correct;
  final String explanation;

  const _Question({
    required this.question,
    required this.options,
    required this.correct,
    required this.explanation,
  });
}
