# Glowing Border Card

![Glowing Border Demo](glowing%20card.gif)

A premium, highly performant, and customizable glowing border animation for Flutter. This project demonstrates how to use `CustomPainter` and `PathMetrics` to create smooth, eye-catching "comet-style" border animations.

## ✨ Features

- **Smooth Animation**: Uses `PathMetrics` for high-performance perimeter tracing.
- **Customizable**: Control colors, border width, glow intensity, and rotation speed.
- **Dual Orbs**: Two independent glowing orbs that travel around the border simultaneously.
- **Neon Glow**: Multi-layered blur effects for a polished, premium look.

## 🚀 Getting Started

If you want to use this in your project, simply copy the `GlowingBorderCard` and `GlowingBorderPainter` classes from `lib/main.dart`.

### Usage Example

```dart
GlowingBorderCard(
  borderRadius: 20,
  // width: 340, // Optional: fixed width
  // height: 200, // Optional: fixed height
  glowColor1: Colors.cyan,
  glowColor2: Colors.magenta,
  backgroundColor: Color(0xFF0E0E1A),
  borderWidth: 2,
  glowSpread: 0.2, // Ratio based on border width
  runCount: 2, // Optional: Number of animation cycles (null for infinite)
  child: YourWidget(),
)
```

## 🧠 How it Works

For a detailed, line-by-line explanation of the code, including how `AnimatedBuilder` and `CustomPainter` work together, check out our [Concept Explanation](CONCEPT_EXPLANATION.md).

## 🛠 Tech Stack

- **Flutter**: UI Framework
- **Dart**: Programming Language
- **CustomPainter**: Low-level drawing
- **PathMetrics**: Advanced path manipulation
