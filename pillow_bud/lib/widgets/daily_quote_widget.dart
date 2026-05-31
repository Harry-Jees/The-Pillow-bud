import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../services/quote_service.dart';
import '../theme/theme_colors.dart';

class DailyQuoteWidget extends StatefulWidget {
  const DailyQuoteWidget({super.key});

  @override
  State<DailyQuoteWidget> createState() => _DailyQuoteWidgetState();
}

class _DailyQuoteWidgetState extends State<DailyQuoteWidget> {
  late Quote _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = QuoteService.getDailyQuote();
  }

  void _refreshQuote() {
    setState(() {
      _currentQuote = QuoteService.getRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.themePrimary;
    final onSurface = context.themeOnSurface;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            border: Border.all(color: primary.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                _currentQuote.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "— ${_currentQuote.author}",
                style: TextStyle(
                  fontSize: 12,
                  color: primary.withValues(alpha: 0.8),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh, color: onSurface.withValues(alpha: 0.6)),
                    onPressed: _refreshQuote,
                  ),
                  Icon(Icons.favorite_border, color: onSurface.withValues(alpha: 0.6)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}