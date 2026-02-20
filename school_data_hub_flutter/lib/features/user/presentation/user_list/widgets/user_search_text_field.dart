import 'package:flutter/material.dart';

class UserSearchTextField extends StatefulWidget {
  final String hintText;
  final bool filtersOn;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onReset;

  const UserSearchTextField({
    required this.hintText,
    required this.filtersOn,
    required this.controller,
    required this.onChanged,
    required this.onReset,
    super.key,
  });

  @override
  State<UserSearchTextField> createState() => _UserSearchTextFieldState();
}

class _UserSearchTextFieldState extends State<UserSearchTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: widget.filtersOn
            ? IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: widget.onReset,
                color: Colors.black45,
              )
            : const Icon(Icons.search_outlined, color: Colors.black45),
        suffixIcon: const SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
