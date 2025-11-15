// ignore_for_file: avoid_print
library print_map;

/// Prints any value with colored output.
///
/// Supports printing of Maps, Lists, and primitive types with the following color scheme:
/// - `String`: White
/// - `int`: Green
/// - `double`: Yellow
/// - `bool`: Magenta
/// - `null`: Cyan
///
/// Maps and Lists are printed with proper indentation and structure.
void printMap(
  dynamic value, {
  String? header,
  String? footer,
  bool timestamp = false,
}) {
  final prefix = timestamp ? _MapPrinter.timestampPrefix() : '';

  if (header != null && header.isNotEmpty) {
    print('$prefix$header');
  }
  if (value is Map) {
    _MapPrinter._printMap(value, i: 0);
  } else if (value is List) {
    _MapPrinter._printList(value);
  } else if (value is String) {
    print(_MapPrinter._white(value.isEmpty ? "''" : "'$value'"));
  } else if (value is int) {
    print(_MapPrinter._green('$value'));
  } else if (value is double) {
    print(_MapPrinter._yellow('$value'));
  } else if (value is bool) {
    print(_MapPrinter._magenta('$value'));
  } else if (value == null) {
    print(_MapPrinter._cyan('null'));
  }

  if (footer != null && footer.isNotEmpty) {
    print('$prefix$footer');
  }
}

/// Internal helper class that handles the printing logic for maps, lists, and primitive values.
/// This class uses ANSI color codes to colorize output in the terminal.
class _MapPrinter {
  /// Applies ANSI color codes to the given text.
  ///
  /// [text] is the string to be colored.
  /// [colorCode] is the ANSI color code (e.g., '37' for white, '32' for green).
  /// Returns the text wrapped with ANSI escape sequences for coloring.
  static String _colorize(String text, String colorCode) => '\x1B[${colorCode}m$text\x1B[0m';

  /// Returns the text in white color (used for strings).
  static String _white(String text) => _colorize(text, '37');

  /// Returns the text in yellow color (used for doubles).
  static String _yellow(String text) => _colorize(text, '33');

  /// Returns the text in magenta color (used for booleans).
  static String _magenta(String text) => _colorize(text, '35');

  /// Returns the text in cyan color (used for null values).
  static String _cyan(String text) => _colorize(text, '36');

  /// Returns the text in green color (used for integers).
  static String _green(String text) => _colorize(text, '32');

  /// Returns the text in blue color (currently unused, reserved for future use).
  // static String _blue(String text) => _colorize(text, '34');

  static String timestampPrefix() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    String three(int n) => n.toString().padLeft(3, '0');
    final time = '${two(now.hour)}:${two(now.minute)}:${two(now.second)}.${three(now.millisecond)}';
    return '[$time] ';
  }

  /// Prints a list with appropriate formatting.
  ///
  /// Determines if the list is homogeneous (contains only one type) or heterogeneous (mixed types).
  /// Homogeneous lists are printed in a compact format, while heterogeneous lists are printed
  /// with each element on a separate line.
  ///
  /// [list] is the list to be printed.
  static void _printList(List list) {
    final bool isHomo = _isHomogenuos(list);
    if (list.isEmpty) {
      print('[]');
    } else if (isHomo) {
      _printListHomogenuos(list, 0);
    } else {
      print('[');
      _printListNotHomogenuos(list, 0);
      print('],');
    }
  }

  /// Prints a map with proper indentation and formatting.
  ///
  /// Recursively processes nested maps and lists, applying appropriate colors to primitive values.
  /// Each nesting level increases the indentation by one level (4 spaces).
  ///
  /// [json] is the map to be printed.
  /// [i] is the current indentation level (0 for root level).
  static void _printMap(Map json, {required int i}) {
    final preSpace = _generateSpaces(i);
    final space = _generateSpaces(i + 1);

    if (i == 0) print('$preSpace{');
    json.forEach((k, v) {
      String value = v.toString();
      bool canPrint = true;

      if (v is Map) {
        canPrint = false;
        if (v.isNotEmpty) {
          print('$space$k: {');
          _printMap(v, i: i + 1);
        } else {
          value = '{}';
        }
      }

      if (v is String) {
        if (v == '') {
          value = "''";
        } else {
          value = "'$v'";
        }
        value = _white(value);
      }

      if (v is List) {
        if (v.isNotEmpty) {
          canPrint = false;
          final bool isHomo = _isHomogenuos(v);
          if (isHomo) {
            _printListHomogenuos(v, i + 1, key: k.toString());
          } else {
            print('$space$k: [');
            _printListNotHomogenuos(v, i + 1);
            print('$space],');
          }
        } else {
          value = '[]';
        }
      }

      if (v is int) value = _green('$v');
      if (v is double) value = _yellow('$v');
      if (v is bool) value = _magenta('$v');
      if (v == null) value = _cyan('null');

      if (canPrint) print('$space$k: $value,');
    });
    print('$preSpace},');
  }

  /// Generates indentation spaces for the current nesting level.
  ///
  /// Each level of indentation consists of 4 spaces.
  ///
  /// [tabs] is the number of indentation levels.
  /// Returns a string containing the appropriate number of spaces.
  static String _generateSpaces(int tabs) {
    final spaces = StringBuffer();
    for (var i = 0; i < tabs; i++) {
      spaces.write('    ');
    }

    return spaces.toString();
  }

  /// Checks if a list contains only one type of element (homogeneous).
  ///
  /// A list is considered homogeneous if all elements are of the same type.
  /// Note: int and double are treated as the same type (number).
  ///
  /// [json] is the list to check.
  /// Returns `true` if the list contains only one type, `false` otherwise.
  static bool _isHomogenuos(List json) {
    int types = 0;
    bool isString = false;
    bool isMap = false;
    bool isNumber = false;
    bool isBool = false;
    bool isList = false;
    bool isNull = false;

    for (final dynamic item in json) {
      if (item is Map && !isMap) {
        isMap = true;
        types++;
      }
      if (item is String && !isString) {
        isString = true;
        types++;
      }
      if (item is List && !isList) {
        isList = true;
        types++;
      }

      if ((item is int || item is double) && !isNumber) {
        isNumber = true;
        types++;
      }
      if (item is bool && !isBool) {
        isBool = true;
        types++;
      }
      if (item == null && !isNull) {
        isNull = true;
        types++;
      }
    }

    if (types == 1) return true;
    return false;
  }

  /// Prints a heterogeneous list (contains mixed types) with each element on a separate line.
  ///
  /// Each element is indented and printed according to its type. Nested structures
  /// (maps and lists) are recursively processed.
  ///
  /// [list] is the list to be printed.
  /// [i] is the current indentation level.
  static void _printListNotHomogenuos(List list, int i) {
    final space = _generateSpaces(i + 1);

    for (final dynamic item in list) {
      String value = item.toString();
      bool canPrint = true;

      if (item is Map) {
        if (item.isNotEmpty) {
          canPrint = false;
          print('$space{');
          _printMap(item, i: i + 1);
        } else {
          value = '{}';
        }
      }

      if (item is String) {
        if (item == '') {
          value = "''";
        } else {
          value = "'$item'";
        }
        value = _white(value);
      }

      if (item is List) {
        if (item.isNotEmpty) {
          canPrint = false;
          final bool isHomo = _isHomogenuos(item);
          if (isHomo) {
            _printListHomogenuos(item, i + 1);
          } else {
            print('$space[');
            _printListNotHomogenuos(item, i + 1);
            print('$space],');
          }
        } else {
          value = '[]';
        }
      }

      if (item is int) value = _green('$item');
      if (item is double) value = _yellow('$item');
      if (item is bool) value = _magenta('$item');
      if (item == null) value = _cyan('null');

      if (canPrint) print('$space$value,');
    }
  }

  /// Prints a homogeneous list (contains only one type) in a compact format.
  ///
  /// For primitive types (String, int, double, bool, null), the entire list is printed
  /// on a single line. For maps and nested lists, each element is printed on separate lines.
  ///
  /// [list] is the homogeneous list to be printed.
  /// [i] is the current indentation level.
  /// [key] is the optional key name when this list is a value in a map.
  static void _printListHomogenuos(List list, int i, {String key = ''}) {
    final dynamic item = list[0];
    final String space = _generateSpaces(i);

    if (item is Map) {
      if (key.isNotEmpty) print('$space$key: [');
      final String inner = _generateSpaces(i + 1);
      for (final item in list) {
        if ((item as Map<dynamic, dynamic>).isNotEmpty) {
          print('$inner{');
          _printMap(item, i: i + 1);
        } else {
          print('$inner{},');
        }
      }
      if (key.isNotEmpty) print('$space],');
    }

    if (item is List) {
      if (key.isNotEmpty) print('$space$key: [');
      for (final List element in list as List<List>) {
        final bool isHomo = _isHomogenuos(element);
        if (isHomo) {
          _printListHomogenuos(element, i + 1);
        } else {
          _printListNotHomogenuos(element, i + 1);
        }
      }
      print('$space],');
    }
    if (item is String) {
      final colored = _white('$list');
      if (key.isNotEmpty) {
        print('$space$key: $colored,');
      } else {
        print('$space$colored,');
      }
    }
    if (item is int) {
      final colored = _green('$list');
      if (key.isNotEmpty) {
        print('$space$key: $colored,');
      } else {
        print('$space$colored,');
      }
    }
    if (item is double) {
      final colored = _yellow('$list');
      if (key.isNotEmpty) {
        print('$space$key: $colored,');
      } else {
        print('$space$colored,');
      }
    }
    if (item is bool) {
      final colored = _magenta('$list');
      if (key.isNotEmpty) {
        print('$space$key: $colored,');
      } else {
        print('$space$colored,');
      }
    }
    if (item == null) {
      final colored = _cyan('$list');
      if (key.isNotEmpty) {
        print('$space$key: $colored,');
      } else {
        print('$space$colored,');
      }
    }
  }
}
