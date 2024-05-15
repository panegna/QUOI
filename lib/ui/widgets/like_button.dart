import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Function(bool) onToggle;
  const LikeButton({super.key, required this.onToggle});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>{
  bool liked = false;

   void toggleButton() {
    setState(() {
      liked = !liked;
    });
    widget.onToggle(liked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      onTap: toggleButton,
      child: liked 
      ? const Icon(
        Icons.favorite,
        color:Colors.red,)
        : const Icon(Icons.favorite_outline),
    );
}
}