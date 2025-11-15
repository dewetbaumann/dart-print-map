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

  test('Extensive data types test', () {
    final json = {
      // Strings de diferentes longitudes
      'shortString': 'Hello',
      'jwt':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
      'base64Data': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
      'longText':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',

      // Números de diferentes tamaños
      'smallInt': 1,
      'largeInt': 9223372036854775807, // max int64
      'negativeInt': -12345678,
      'smallDouble': 0.0001,
      'largeDouble': 1.7976931348623157e+308,
      'scientificNotation': 6.022e23,

      // Listas de diferentes tamaños
      'emptyList': [],
      'shortList': [1, 2, 3],
      'longList': List.generate(20, (i) => i),
      'shortStringList': ['a', 'b', 'c'],
      'longStringList': List.generate(15, (i) => 'Item $i'),

      // Anidaciones profundas
      'deepNesting': {
        'level1': {
          'level2': {
            'level3': {
              'level4': {
                'level5': {
                  'data': 'Deep nested value',
                  'numbers': [1, 2, 3, 4, 5],
                  'config': {
                    'enabled': true,
                    'timeout': 3000,
                    'retries': 3,
                  }
                }
              }
            }
          }
        }
      },

      // Arrays de objetos complejos
      'users': [
        {
          'id': 1,
          'name': 'Alice Johnson',
          'email': 'alice@example.com',
          'active': true,
          'balance': 1234.56,
          'roles': ['admin', 'user'],
          'metadata': {
            'lastLogin': '2024-01-15T10:30:00Z',
            'loginCount': 42,
          }
        },
        {
          'id': 2,
          'name': 'Bob Smith',
          'email': 'bob@example.com',
          'active': false,
          'balance': 0.0,
          'roles': ['user'],
          'metadata': {
            'lastLogin': null,
            'loginCount': 0,
          }
        },
        {
          'id': 3,
          'name': 'Charlie Brown',
          'email': 'charlie@example.com',
          'active': true,
          'balance': -50.25,
          'roles': [],
          'metadata': {}
        }
      ],

      // Mezcla de tipos en arrays
      'mixedArray': [
        1,
        'text',
        true,
        null,
        {'nested': 'object'},
        [1, 2, 3],
        3.14159,
        '',
        false,
        {
          'another': {'deep': 'nest'}
        }
      ],

      // Arrays de arrays
      'matrix': [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ],

      // Casos especiales
      'boolTrue': true,
      'boolFalse': false,
      'nullValue': null,
      'emptyString': '',
      'emptyObject': {},
      'emptyArray': [],

      // Objetos anidados con arrays
      'apiResponse': {
        'status': 'success',
        'code': 200,
        'data': {
          'items': [
            {'id': 1, 'value': 'First'},
            {'id': 2, 'value': 'Second'},
            {'id': 3, 'value': 'Third'},
          ],
          'pagination': {
            'page': 1,
            'perPage': 10,
            'total': 100,
            'hasMore': true,
          }
        },
        'errors': null,
        'warnings': []
      }
    };

    print('\nExtensive data types test');
    printMap(json);
  });

  test('Array with maps should show key', () {
    final json = {
      'users': [
        {'name': 'Juan', 'age': 25},
        {'name': 'Maria', 'age': 30},
        {'name': 'Pedro', 'age': 28},
      ],
      'products': [
        {'id': 1, 'name': 'Product A'},
        {'id': 2, 'name': 'Product B'},
      ],
    };

    print('\nArray with maps test');
    printMap(json);
  });

  test('Print different primitive types', () {
    print('\nTesting primitive types:');

    print('\nString:');
    printMap('Hello World');

    print('\nEmpty String:');
    printMap('');

    print('\nInteger:');
    printMap(42);

    print('\nDouble:');
    printMap(3.14159);

    print('\nBoolean true:');
    printMap(true);

    print('\nBoolean false:');
    printMap(false);

    print('\nNull:');
    printMap(null);

    print('\nList of integers:');
    printMap([1, 2, 3, 4, 5]);

    print('\nList of strings:');
    printMap(['a', 'b', 'c']);

    print('\nMixed list:');
    printMap([1, 'two', 3.0, true, null]);
  });

  test('Header and footer with map', () {
    final json = {
      'service': 'orders',
      'status': 'ok',
      'count': 3,
      'items': [
        {'id': 1, 'price': 10.5},
        {'id': 2, 'price': 22.0},
        {'id': 3, 'price': 7.75},
      ],
    };

    print('\nHeader and footer with map');
    printMap(json, header: '--- REQUEST ---', footer: '--- END REQUEST ---');
  });

  test('Timestamp with header/footer (list)', () {
    print('\nTimestamp header/footer list');
    printMap(['alpha', 123, false], header: 'LIST START', footer: 'LIST END', timestamp: true);
  });

  test('Header only (string)', () {
    print('\nHeader only string');
    printMap('sample-string', header: 'STRING START', timestamp: true);
  });

  test('Footer only (null)', () {
    print('\nFooter only null');
    printMap(null, footer: 'NULL FINISHED', timestamp: true);
  });
}
