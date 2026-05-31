import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        Text(
          'Bud is thinking',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(width: 8),
        ...List.generate(3, (i) => _Dot(controller: _c, index: i)),
      ],
    );
  }
}

class _Dot extends AnimatedWidget {
  final int index;

  const _Dot({
    required AnimationController controller,
    required this.index,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final delay = index * 200;
    final value = ((animation.value * 600 + delay) % 600) / 600;
    final opacity = 0.4 + (value * 0.6);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: context.themePrimary.withValues(alpha: opacity),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
