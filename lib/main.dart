import 'package:flutter/material.dart';

import 'glowing_border_card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing Border',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B7FE3),
          brightness: Brightness.dark,
          primary: const Color(0xFF00F5FF),
          tertiary: const Color(0xFFFF00AA),
          surface: const Color(0xFF0E0E1A),
        ),
      ),
      home: const CardDemoScreen(),
    );
  }
}

class CardDemoScreen extends StatelessWidget {
  const CardDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Container(
        padding: .all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GLOWING BORDER',
              style: TextStyle(
                color: Color(0xFF6B7FE3),
                fontSize: 11,
                letterSpacing: 6,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 40),
            GlowingBorderCard(
              borderRadius: 20,
              runCount: 2,
              startDelay: Duration(seconds: 10),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00F5FF), Color(0xFF6B7FE3)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.bolt,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            3,
                            (i) => Container(
                              margin: const EdgeInsets.only(left: 4),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == 0
                                    ? const Color(0xFF00F5FF)
                                    : Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Neural Interface',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Active connection established',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 13,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Second card with different colors
            GlowingBorderCard(
              width: 340,
              height: 180,
              borderRadius: 16,
              glowColor1: const Color(0xFFFFAA00), // gold from bottom-right
              glowColor2: const Color(0xFF00FF88), // green from top-left
              backgroundColor: const Color(0xFF0C0F0E),
              borderWidth: 1.5,
              glowSpread: 0.1,
              animationDuration: const Duration(milliseconds: 2200),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SYSTEM STATUS',
                      style: TextStyle(
                        color: const Color(0xFF00FF88).withValues(alpha: 0.7),
                        fontSize: 10,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Systems Go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(
                              0xFF00FF88,
                            ).withValues(alpha: 0.15),
                            border: Border.all(
                              color: const Color(
                                0xFF00FF88,
                              ).withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'ONLINE',
                            style: TextStyle(
                              color: Color(0xFF00FF88),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
