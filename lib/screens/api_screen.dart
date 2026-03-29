import 'package:flutter/material.dart';
import '../app_theme.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});
  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, child) => Column(
        children: [
          Container(
            color: context.cardBg,
            child: TabBar(
              controller: _tabController,
              indicatorColor: context.accentLight,
              labelColor: context.accentLight,
              unselectedLabelColor: context.onSurface.withValues(alpha: 0.4),
              tabs: const [Tab(text: 'Python'), Tab(text: 'cURL')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_PythonExamples(), _CurlExamples()],
            ),
          ),
        ],
      ),
    );
  }
}

class _PythonExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _sectionLabel('Appel simple', context),
        const CodeBlock(
          title: 'Python — Appel simple',
          code: '''from openai import OpenAI

client = OpenAI(
    api_key="pplx-...",
    base_url="https://api.perplexity.ai",
)

response = client.chat.completions.create(
    model="sonar-pro",
    messages=[{"role": "user", "content": "Quelles sont les dernières nouvelles en IA ?"}],
)
print(response.choices[0].message.content)''',
        ),
        _sectionLabel('Avec recherche web', context),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.tipBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: context.tipBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.travel_explore, color: context.accentLight, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Les modèles sonar et sonar-pro incluent automatiquement la recherche '
                  'web en temps réel. Les résultats incluent un champ citations avec les URLs sources.',
                  style: TextStyle(color: context.tipText, fontSize: 13, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const CodeBlock(
          title: 'Python — Avec recherche web (sonar-pro)',
          code: '''response = client.chat.completions.create(
    model="sonar-pro",
    messages=[
        {"role": "user", "content": "Quels sont les événements récents en espace ?"},
    ],
)

# Contenu de la réponse
print(response.choices[0].message.content)

# Citations (si disponibles dans l'attribut)
# Note: les citations sont dans response.citations si le SDK les expose
# Sinon, accédez via l'API HTTP directe''',
        ),
        _sectionLabel('Récupérer les citations', context),
        const CodeBlock(
          title: 'Python — Citations via HTTP',
          code: r'''import requests

response = requests.post(
    "https://api.perplexity.ai/chat/completions",
    headers={
        "Authorization": "Bearer pplx-...",
        "Content-Type": "application/json",
    },
    json={
        "model": "sonar-pro",
        "messages": [{"role": "user", "content": "Actualités IA du jour"}],
    },
)

data = response.json()
content = data["choices"][0]["message"]["content"]
citations = data.get("citations", [])

print("Réponse:", content)
print("\nSources:")
for i, url in enumerate(citations, 1):
    print(f"  [{i}] {url}")''',
        ),
        _sectionLabel('Streaming', context),
        const CodeBlock(
          title: 'Python — Streaming',
          code: r'''stream = client.chat.completions.create(
    model="sonar",
    messages=[{"role": "user", "content": "Explique le machine learning"}],
    stream=True,
)

for chunk in stream:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="", flush=True)''',
        ),
        _sectionLabel('Avec système prompt', context),
        const CodeBlock(
          title: 'Python — System prompt',
          code: '''response = client.chat.completions.create(
    model="sonar-pro",
    messages=[
        {
            "role": "system",
            "content": "Tu es un expert en technologie. Réponds avec des sources fiables.",
        },
        {"role": "user", "content": "Explique les transformers en IA"},
    ],
)
print(response.choices[0].message.content)''',
        ),
      ],
    );
  }
}

class _CurlExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _sectionLabel('Appel simple', context),
        const CodeBlock(
          title: 'cURL — Appel basique',
          code: r'''curl -X POST https://api.perplexity.ai/chat/completions \
  -H "Authorization: Bearer pplx-..." \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar-pro",
    "messages": [
      {"role": "user", "content": "Quelles sont les dernières nouvelles en IA ?"}
    ]
  }' ''',
        ),
        _sectionLabel('Avec recherche web', context),
        const CodeBlock(
          title: 'cURL — Réponse avec citations',
          code: r'''curl -X POST https://api.perplexity.ai/chat/completions \
  -H "Authorization: Bearer pplx-..." \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar-pro",
    "messages": [
      {
        "role": "system",
        "content": "Cite toujours tes sources."
      },
      {
        "role": "user",
        "content": "Actualités récentes en exploration spatiale"
      }
    ]
  }' | jq '{
    content: .choices[0].message.content,
    citations: .citations
  }' ''',
        ),
        _sectionLabel('Récupérer les citations', context),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.tipBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: context.tipBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.format_quote, color: context.accentLight, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Le champ "citations" dans la réponse JSON contient la liste des URLs '
                  'utilisées pour générer la réponse. Disponible uniquement avec les modèles sonar.',
                  style: TextStyle(color: context.tipText, fontSize: 13, height: 1.5),
                ),
              ),
            ],
          ),
        ),
        const CodeBlock(
          title: 'JSON réponse — Structure avec citations',
          code: '''{
  "id": "...",
  "model": "sonar-pro",
  "choices": [{
    "message": {
      "role": "assistant",
      "content": "Les dernières avancées en IA incluent..."
    }
  }],
  "citations": [
    "https://techcrunch.com/article/...",
    "https://arxiv.org/abs/...",
    "https://openai.com/blog/..."
  ],
  "usage": {
    "prompt_tokens": 25,
    "completion_tokens": 180,
    "total_tokens": 205
  }
}''',
        ),
        _sectionLabel('Streaming', context),
        const CodeBlock(
          title: 'cURL — Streaming SSE',
          code: r'''curl -X POST https://api.perplexity.ai/chat/completions \
  -H "Authorization: Bearer pplx-..." \
  -H "Content-Type: application/json" \
  --no-buffer \
  -d '{
    "model": "sonar",
    "stream": true,
    "messages": [
      {"role": "user", "content": "Explique le deep learning en détail"}
    ]
  }' ''',
        ),
      ],
    );
  }
}

Widget _sectionLabel(String text, BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(text,
          style: TextStyle(
              color: context.accentLight, fontSize: 14, fontWeight: FontWeight.w600)),
    );
