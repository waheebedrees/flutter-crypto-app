import 'package:flutter/material.dart';

class ChartLoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'loading...',
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const AnimatedButton({
    Key? key,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color:
              _isPressed ? widget.color.withValues(alpha: 0.8) : widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
