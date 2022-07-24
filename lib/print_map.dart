// ignore_for_file: avoid_print
library print_map;

void printMap(Map json) => _printMap(json, i: 0);

void _printMap(Map json, {required int i}) {
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
      value = '\x1B[37m$value\x1B[0m';
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

    if (v is int || v is double) value = '\x1B[33m$v\x1B[0m';
    if (v is bool) value = '\x1B[35m$v\x1B[0m';
    if (v == null) value = '\x1B[36mnull\x1B[0m';

    if (canPrint) print('$space$k: $value,');
  });
  print('$preSpace},');
}

String _generateSpaces(int tabs) {
  final spaces = StringBuffer();
  for (var i = 0; i < tabs; i++) {
    spaces.write('    ');
  }

  return spaces.toString();
}

bool _isHomogenuos(List json) {
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

void _printListNotHomogenuos(List list, int i) {
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
      value = '\x1B[37m$value\x1B[0m';
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

    if (item is int || item is double) value = '\x1B[33m$item\x1B[0m';
    if (item is bool) value = '\x1B[35m$item\x1B[0m';
    if (item == null) value = '\x1B[36mnull\x1B[0m';

    if (canPrint) print('$space$value,');
  }
}

void _printListHomogenuos(List list, int i, {String key = ''}) {
  final dynamic item = list[0];
  final String space = _generateSpaces(i);

  if (item is Map) {
    for (final item in list) {
      if ((item as Map<dynamic, dynamic>).isNotEmpty) {
        print('$space{');
        _printMap(item, i: i);
      } else {
        print('$space{},');
      }
    }
  }

  if (item is List) {
    for (final List element in list as List<List>) {
      final bool isHomo = _isHomogenuos(element);
      if (isHomo) {
        _printListHomogenuos(element, i + 1);
      } else {
        _printListNotHomogenuos(element, i + 1);
      }
    }
    print('$i],');
  }
  if (item is String) print('$space$key: \x1B[37m$list\x1B[0m');
  if (item is int || item is double) print('$space$key: \x1B[33m$list\x1B[0m');
  if (item is bool) print('$space$key: \x1B[35m$list\x1B[0m');
  if (item == null) print('$space$key: \x1B[36m$list\x1B[0m');
}
