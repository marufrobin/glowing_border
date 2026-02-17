import 'package:flutter/material.dart';

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

/// A card widget with two glowing border orbs that start at opposite corners
/// (top-left and bottom-right) and travel around the entire border simultaneously.
class GlowingBorderCard extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? glowColor1; // Travels from bottom-right → clockwise
  final Color? glowColor2; // Travels from top-left → clockwise (opposite start)
  final Color? backgroundColor;
  final double borderWidth;
  final double glowSpread;
  final Duration animationDuration;
  final Duration? startDelay;
  final int? runCount;
  final Widget? child;

  const GlowingBorderCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.glowColor1,
    this.glowColor2,
    this.backgroundColor,
    this.borderWidth = 2,
    this.glowSpread = 8,
    this.animationDuration = const Duration(milliseconds: 2500),
    this.startDelay,
    this.runCount,
    this.child,
  });

  @override
  State<GlowingBorderCard> createState() => _GlowingBorderCardState();
}

class _GlowingBorderCardState extends State<GlowingBorderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = true;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _initAnimation();
  }

  Future<void> _initAnimation() async {
    if (widget.startDelay != null) {
      await Future.delayed(widget.startDelay!);
    }

    if (!mounted) return;

    setState(() {
      _isStarted = true;
    });

    if (widget.runCount != null) {
      _controller.repeat(count: widget.runCount);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        }
      });
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedGlow1 = widget.glowColor1 ?? theme.colorScheme.primary;
    final resolvedGlow2 = widget.glowColor2 ?? theme.colorScheme.tertiary;
    final resolvedBg = widget.backgroundColor ?? theme.colorScheme.surface;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: (_isStarted && _isVisible) ? 1.0 : 0.0,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, glowOpacity, child) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: GlowingBorderPainter(
                progress: _animation.value,
                glowColor1: resolvedGlow1,
                glowColor2: resolvedGlow2,
                borderRadius: widget.borderRadius,
                borderWidth: widget.borderWidth,
                glowSpread: widget.glowSpread,
                glowOpacity: glowOpacity,
              ),
              child: child,
            );
          },
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: resolvedBg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: widget.child,
      ),
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0 (full loop)
  final Color glowColor1;
  final Color glowColor2;
  final double borderRadius;
  final double borderWidth;
  final double glowSpread;
  final double glowOpacity;

  GlowingBorderPainter({
    required this.progress,
    required this.glowColor1,
    required this.glowColor2,
    required this.borderRadius,
    required this.borderWidth,
    required this.glowSpread,
    required this.glowOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLen = metrics.length;

    // ── 1. Draw the dim base border ──────────────────────────────────────────
    final basePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(rrect, basePaint);

    // If glow is fully invisible, skip drawing orbs and trails
    if (glowOpacity <= 0) return;

    // ── 2. Draw each orb with its glow trail ─────────────────────────────────
    void drawOrb(double t, Color color) {
      final double normalizedT = t % 1.0;
      final double distance = normalizedT * totalLen;

      // Extract trail path (last ~15% of the perimeter)
      const double trailFraction = 0.15;
      final double trailLen = totalLen * trailFraction;

      final Path trailPath = Path();
      if (distance >= trailLen) {
        trailPath.addPath(
          metrics.extractPath(distance - trailLen, distance),
          Offset.zero,
        );
      } else {
        // Handle wrap around: part from end of path + part from start of path
        trailPath.addPath(
          metrics.extractPath(totalLen - (trailLen - distance), totalLen),
          Offset.zero,
        );
        trailPath.addPath(metrics.extractPath(0, distance), Offset.zero);
      }

      // ── Glow trail layers (Optimized) ──────────────────────────────────────
      // Outer soft glow
      final Paint glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = glowSpread * 2.5
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 1.2)
        ..color = color.withValues(alpha: 0.15 * glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // Middle vibrant glow
      glowPaint
        ..strokeWidth = glowSpread * 1.2
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 0.5)
        ..color = color.withValues(alpha: 0.4 * glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // Core leading line
      glowPaint
        ..strokeWidth = borderWidth * 1.5
        ..maskFilter = null
        ..color = color.withValues(alpha: glowOpacity);
      canvas.drawPath(trailPath, glowPaint);

      // ── Orb Head ───────────────────────────────────────────────────────────
      final tangent = metrics.getTangentForOffset(distance);
      if (tangent != null) {
        final pos = tangent.position;

        // Soft head glow
        final Paint headPaint = Paint()
          ..color = color.withValues(alpha: 0.6 * glowOpacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSpread * 0.8);
        canvas.drawCircle(pos, glowSpread, headPaint);

        // White core
        headPaint
          ..color = Colors.white.withValues(alpha: glowOpacity)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
        canvas.drawCircle(pos, borderWidth * 1.5, headPaint);

        // Pure white spike
        canvas.drawCircle(
          pos,
          borderWidth * 0.8,
          Paint()..color = Colors.white.withValues(alpha: glowOpacity),
        );
      }
    }

    // Orb 1: starts halfway (bottom-right)
    drawOrb(progress + 0.5, glowColor1);

    // Orb 2: starts at beginning (top-left)
    drawOrb(progress, glowColor2);
  }

  @override
  bool shouldRepaint(GlowingBorderPainter old) => old.progress != progress;
}
