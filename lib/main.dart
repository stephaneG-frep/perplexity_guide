import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/installation_screen.dart';
import 'screens/api_screen.dart';
import 'screens/prompts_screen.dart';
import 'screens/features_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/playground_screen.dart';
import 'screens/sonar_screen.dart';
import 'screens/apps_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/ai_agents_screen.dart';
import 'screens/splash_screen.dart';

class AppThemes {
  static ThemeData get darkTeal => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1B6B5E),
          secondary: Color(0xFF20D9A0),
          surface: Color(0xFF0C0C0F),
          onPrimary: Colors.white,
          onSurface: Color(0xFFE0F0EC),
        ),
        scaffoldBackgroundColor: const Color(0xFF0C0C0F),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1A1A1E)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(color: Color(0xFF161618), elevation: 2),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFF20D9A0)),
          trackColor: WidgetStateProperty.all(const Color(0xFF1B6B5E)),
        ),
      );

  static ThemeData get lightGrey => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0F7060),
          secondary: Color(0xFF0D9E80),
          surface: Color(0xFFF4F4F6),
          onPrimary: Colors.white,
          onSurface: Color(0xFF1A2A28),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F4F6),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFEBEBED)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEBEBED),
          foregroundColor: Color(0xFF1A2A28),
          elevation: 0,
        ),
        cardTheme: const CardThemeData(color: Color(0xFFFFFFFF), elevation: 2),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFF0F7060)),
          trackColor: WidgetStateProperty.all(const Color(0xFF0D9E80)),
        ),
      );
}

class ThemeConfig {
  final Color primary;
  final Color accent;
  final Color drawerBg;
  final Color divider;
  final Color selectedTile;
  final Color indicator;
  final Color footerText;
  final Color titleColor;
  final List<Color> headerGradient;
  final List<NavItem> navItems;

  const ThemeConfig({
    required this.primary,
    required this.accent,
    required this.drawerBg,
    required this.divider,
    required this.selectedTile,
    required this.indicator,
    required this.footerText,
    required this.titleColor,
    required this.headerGradient,
    required this.navItems,
  });

  static const darkTeal = ThemeConfig(
    primary: Color(0xFF1B6B5E),
    accent: Color(0xFF20D9A0),
    drawerBg: Color(0xFF1A1A1E),
    divider: Color(0xFF1A3530),
    selectedTile: Color(0xFF1B6B5E),
    indicator: Color(0xFF20D9A0),
    footerText: Color(0xFF5FCFB0),
    titleColor: Colors.white,
    headerGradient: [Color(0xFF000000), Color(0xFF0C2B26), Color(0xFF154F44)],
    navItems: [
      NavItem(icon: Icons.home_outlined,         label: 'Accueil',            color: Color(0xFF20D9A0)),
      NavItem(icon: Icons.download_outlined,     label: 'Installation',       color: Color(0xFF1B9E78)),
      NavItem(icon: Icons.code_outlined,         label: 'API & Code',         color: Color(0xFF17C490)),
      NavItem(icon: Icons.auto_awesome_outlined, label: 'Prompts',            color: Color(0xFF20D9A0)),
      NavItem(icon: Icons.star_outline,          label: 'Fonctionnalités',    color: Color(0xFF1B9E78)),
      NavItem(icon: Icons.chat_bubble_outline,   label: 'Chat Perplexity',    color: Color(0xFF20D9A0)),
      NavItem(icon: Icons.science_outlined,      label: 'Playground',         color: Color(0xFF1B9E78)),
      NavItem(icon: Icons.radar_outlined,        label: 'Sonar & Focus',      color: Color(0xFF20D9A0)),
      NavItem(icon: Icons.apps_outlined,         label: 'Applications',       color: Color(0xFF1B9E78)),
      NavItem(icon: Icons.quiz_outlined,         label: 'Quiz',               color: Color(0xFF17C490)),
      NavItem(icon: Icons.hub_outlined,           label: 'IA & Agents',        color: Color(0xFF20D9A0)),
    ],
  );

  static const lightGrey = ThemeConfig(
    primary: Color(0xFF0F7060),
    accent: Color(0xFF0D9E80),
    drawerBg: Color(0xFFEBEBED),
    divider: Color(0xFFDDEAE8),
    selectedTile: Color(0xFF0F7060),
    indicator: Color(0xFF0D9E80),
    footerText: Color(0xFF0F6050),
    titleColor: Colors.white,
    headerGradient: [Color(0xFF0F7060), Color(0xFF159E84), Color(0xFF20D9A0)],
    navItems: [
      NavItem(icon: Icons.home_outlined,         label: 'Accueil',            color: Color(0xFF0F7060)),
      NavItem(icon: Icons.download_outlined,     label: 'Installation',       color: Color(0xFF0D9E80)),
      NavItem(icon: Icons.code_outlined,         label: 'API & Code',         color: Color(0xFF0F7060)),
      NavItem(icon: Icons.auto_awesome_outlined, label: 'Prompts',            color: Color(0xFF159E84)),
      NavItem(icon: Icons.star_outline,          label: 'Fonctionnalités',    color: Color(0xFF0F7060)),
      NavItem(icon: Icons.chat_bubble_outline,   label: 'Chat Perplexity',    color: Color(0xFF0D9E80)),
      NavItem(icon: Icons.science_outlined,      label: 'Playground',         color: Color(0xFF0F7060)),
      NavItem(icon: Icons.radar_outlined,        label: 'Sonar & Focus',      color: Color(0xFF0D9E80)),
      NavItem(icon: Icons.apps_outlined,         label: 'Applications',       color: Color(0xFF0F7060)),
      NavItem(icon: Icons.quiz_outlined,         label: 'Quiz',               color: Color(0xFF159E84)),
      NavItem(icon: Icons.hub_outlined,           label: 'IA & Agents',        color: Color(0xFF0F7060)),
    ],
  );
}

void main() {
  runApp(const PerplexityGuideApp());
}

class PerplexityGuideApp extends StatelessWidget {
  const PerplexityGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Perplexity Guide',
          debugShowCheckedModeBanner: false,
          theme: theme == AppTheme.darkTeal ? AppThemes.darkTeal : AppThemes.lightGrey,
          home: const SplashScreen(),
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    InstallationScreen(),
    ApiScreen(),
    PromptsScreen(),
    FeaturesScreen(),
    ChatScreen(),
    PlaygroundScreen(),
    SonarScreen(),
    AppsScreen(),
    QuizScreen(),
    AiAgentsScreen(),
  ];

  static const _titles = [
    'Accueil',
    'Installation',
    'API & Code',
    'Prompts',
    'Fonctionnalités',
    'Chat Perplexity',
    'Playground',
    'Sonar & Focus',
    'Applications',
    'Quiz',
    'IA & Agents',
  ];

  ThemeConfig get _cfg =>
      themeNotifier.value == AppTheme.darkTeal ? ThemeConfig.darkTeal : ThemeConfig.lightGrey;

  @override
  void initState() {
    super.initState();
    perplexityNavIndex.addListener(_onNavChange);
  }

  @override
  void dispose() {
    perplexityNavIndex.removeListener(_onNavChange);
    super.dispose();
  }

  void _onNavChange() {
    if (perplexityNavIndex.value != _currentIndex) {
      setState(() => _currentIndex = perplexityNavIndex.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (context, _, child) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            _titles[_currentIndex],
            style: TextStyle(fontWeight: FontWeight.bold, color: _cfg.titleColor),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _cfg.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Switch(
                value: themeNotifier.value == AppTheme.lightGrey,
                onChanged: (v) => themeNotifier.value =
                    v ? AppTheme.lightGrey : AppTheme.darkTeal,
                activeThumbColor: const Color(0xFF0F7060),
                activeTrackColor: const Color(0xFF0D9E80),
                inactiveThumbColor: const Color(0xFF20D9A0),
                inactiveTrackColor: const Color(0xFF1B6B5E),
              ),
            ),
          ],
        ),
        drawer: _buildDrawer(context),
        body: _screens[_currentIndex],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final cfg = _cfg;
    return Drawer(
      backgroundColor: cfg.drawerBg,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: cfg.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/mon_logo.jpeg',
                        width: 110,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Perplexity Guide',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Guide complet Perplexity AI',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: cfg.navItems.length,
              itemBuilder: (context, index) {
                final item = cfg.navItems[index];
                final isSelected = _currentIndex == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? cfg.selectedTile.withValues(alpha: 0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(item.icon,
                        color: isSelected ? item.color : item.color.withValues(alpha: 0.5)),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        color: isSelected
                            ? item.color
                            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: cfg.indicator,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() => _currentIndex = index);
                      perplexityNavIndex.value = index;
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(color: cfg.divider, height: 1),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('v2.0 • Perplexity AI Guide',
                  style: TextStyle(color: cfg.footerText, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final Color color;
  const NavItem({required this.icon, required this.label, required this.color});
}
