import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../theme/theme_colors.dart';
import '../widgets/daily_quote_widget.dart';
import 'chat_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameAsync = ref.watch(userNameProvider);
    final userName = userNameAsync.valueOrNull ?? 'Friend';

    return Scaffold(
      backgroundColor: context.themeBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hey, $userName",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: context.themeOnSurface,
                    ),
                  ),
                  Icon(Icons.settings, color: context.themeOnSurface.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 20),
              const DailyQuoteWidget(),
              Text(
                "Quick Actions",
                style: TextStyle(color: context.themeOnSurface.withValues(alpha: 0.5), fontSize: 14),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildFeatureCard(context, Icons.self_improvement, "Meditate"),
                  _buildFeatureCard(context, Icons.air, "Breathe"),
                  _buildFeatureCard(context, Icons.videogame_asset, "Play Game"),
                  _buildFeatureCard(context, Icons.chat_bubble_outline, "Talk to Bud", 
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()))
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildMoodCheckInSection(context),
              const SizedBox(height: 24),
              Text("Your Stats", style: TextStyle(color: context.themeOnSurface.withValues(alpha: 0.5))),
              const SizedBox(height: 12),
              _buildStatsRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String label, {VoidCallback? onTap}) {
    final primary = context.themePrimary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [primary, primary.withValues(alpha: 0.7)]),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCheckInSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeOnSurface.withValues(alpha: 0.04),
        border: Border.all(color: context.themeOnSurface.withValues(alpha: 0.07)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text("How are you feeling?", style: TextStyle(color: context.themeOnSurface)),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("😤"), Text("😢"), Text("😌"), Text("😊"), Text("😄")],
          )
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [Text("🔥 7-day streak", style: TextStyle(color: context.themePrimary))],
    );
  }
}