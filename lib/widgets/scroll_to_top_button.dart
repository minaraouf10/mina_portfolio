import 'package:flutter/material.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollToTopButton({
    super.key,
    required this.scrollController,
  });

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController.hasClients) {
      final offset = widget.scrollController.offset;
      if (offset > 300 && !_isVisible) {
        setState(() => _isVisible = true);
      } else if (offset <= 300 && _isVisible) {
        setState(() => _isVisible = false);
      }
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedScale(
      scale: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
      child: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        mini: true,
        tooltip: 'Scroll to top',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
