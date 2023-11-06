import 'package:flutter/material.dart';

class ButtonsRowElement {
  const ButtonsRowElement({
    required this.label,
    required this.onPressed,
    required this.tooltip,
  });

  final String label;
  final VoidCallback onPressed;
  final String tooltip;
}

class ButtonsRow extends StatefulWidget {
  const ButtonsRow({
    super.key,
    required this.buttonValues,
    this.scrollDuration = 300,
    this.scrollStep = 400,
    this.padding = const EdgeInsets.all(8),
  });

  final double scrollStep;
  final int scrollDuration;
  final List<ButtonsRowElement> buttonValues;
  final EdgeInsets padding;

  @override
  State<ButtonsRow> createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollLeft() => scrollController.animateTo(
        scrollController.offset - widget.scrollStep >
                scrollController.position.minScrollExtent
            ? scrollController.offset - widget.scrollStep
            : 0,
        duration: Duration(milliseconds: widget.scrollDuration),
        curve: Curves.easeOutCubic,
      );

  void scrollRight() => scrollController.animateTo(
        scrollController.offset + widget.scrollStep <
                scrollController.position.maxScrollExtent
            ? scrollController.offset + widget.scrollStep
            : scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: widget.scrollDuration),
        curve: Curves.easeOutCubic,
      );

  Widget buttonBuilder(ButtonsRowElement element) => Padding(
        padding: widget.padding,
        child: Tooltip(
          message: element.tooltip,
          child: ElevatedButton(
            onPressed: element.onPressed,
            child: Text(element.label),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.buttonValues.length,
            itemBuilder: (context, index) =>
                buttonBuilder(widget.buttonValues[index]),
          ),
          Center(
            child: Row(
              children: [
                Padding(
                  padding: widget.padding,
                  child: ElevatedButton(
                    onPressed: scrollLeft,
                    child: const Icon(Icons.arrow_back_outlined),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: widget.padding,
                  child: ElevatedButton(
                    onPressed: scrollRight,
                    child: const Icon(Icons.arrow_forward_outlined),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
