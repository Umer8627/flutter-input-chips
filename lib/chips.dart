
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_chips_textfield/provider/chips_provider.dart';
import 'package:provider/provider.dart';

class InputChips extends StatefulWidget {
  const InputChips({super.key});

  @override
  State<InputChips> createState() => _InputChipsState();
}

class _InputChipsState extends State<InputChips> {
  final _chipController = TextEditingController();
  final focusNode = FocusNode();
  final focusKeyboard = FocusNode();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Input Chips',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Consumer<ChipsProvider>(builder: (context, chipsProvider, child) {
            return RawKeyboardListener(
               // A widget that calls a callback whenever the user presses or releases a key on a keyboard
              focusNode: focusKeyboard,
              onKey: (key) {
                if (_chipController.text.isEmpty && key is RawKeyDownEvent &&
                    key.logicalKey == LogicalKeyboardKey.backspace) {
                  if (chipsProvider.chips.isNotEmpty) {
                    chipsProvider.removeChip(
                        lastChip: chipsProvider.chips.last);
                  }
                } else if (key.logicalKey == LogicalKeyboardKey.space) {
                  if (_chipController.text.isNotEmpty &&
                      _chipController.text != ' ') {
                    chipsProvider.addChip(newChip: _chipController.text);
                    _chipController.clear();
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      focusNode.requestFocus();
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      isFocused: focusNode.hasFocus,
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ...chipsProvider.chips.map(
                            (value) => Chip(
                              shadowColor: Colors.purple,
                              elevation: 4,
                              label: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              onDeleted: () {
                                chipsProvider.removeChip(lastChip: value);
                              },
                              deleteIcon:
                                  const Icon(Icons.close, color: Colors.purple),
                            ),
                          ),
                          const SizedBox(width: 5),
                          EditableText(
                            focusNode: focusNode,
                            backgroundCursorColor: Colors.transparent,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            controller: _chipController,
                            // maxLines: null,
                            forceLine: false,
                            onChanged: (value) {
                              // In case you don't want to use the space keyboard key you can use other keys like this
                              /*
                              if (value.isEmpty) return;
                              final lastCharacter = value.characters.last;
                              if (lastCharacter == ',') {
                                final word =
                                    value.substring(0, value.length - 1);
                                chipsProvider.addChip(
                                    newChip: word);
                                _chipController.clear();
                              }
                              */ 
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusKeyboard.dispose();
    _chipController.dispose();
    super.dispose();
  }
}
