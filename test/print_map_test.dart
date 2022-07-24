// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:print_map/print_map.dart';

void main() {
  test('Better print', () {
    final json = {
      'string': 'This a string',
      'stringEmpty': '',
      'int': 581,
      'double': 3.1492,
      'nullValue': null,
      'homogenuosList': [1, 2, 3, 4, 5, 6],
      'mapIntoMap': {
        1: 'Apple',
        2: 'Orange',
        3: 'Banana',
        4: 'Berry',
      },
      'notHomogenuosList': [
        1,
        'a',
        {},
        2.9867,
        [],
        null,
      ],
    };

    print('\nNormal map print on Dart');
    print(json);

    print('\nUsing this package');
    printMap(json);
  });
}
