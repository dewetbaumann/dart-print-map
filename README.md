# PrintMap 🎨

Un package de Dart que transforma la manera en que visualizas datos en tu consola. PrintMap convierte la salida estándar de `print()` en una representación colorida, estructurada y fácil de leer.

## ¿Por qué usar PrintMap?

### Problemas del `print()` nativo de Dart

Cuando usas el `print()` nativo de Dart para imprimir estructuras de datos complejas como Maps o Lists, obtienes:

- 📝 **Todo en una sola línea**: Difícil de leer y seguir
- 🔍 **Sin diferenciación visual**: Todos los valores se ven iguales
- 😵 **Imposible de depurar**: Con datos anidados se vuelve caótico
- ⚫ **Sin color**: Todo en monocromo, sin jerarquía visual

### Ventajas de PrintMap

PrintMap soluciona todos estos problemas ofreciendo:

✅ **Formato estructurado con indentación**: Cada nivel de anidación es claramente visible  
✅ **Códigos de color por tipo de dato**: Identifica tipos de un vistazo  
✅ **Soporte completo de tipos**: Maps, Lists, String, int, double, bool, null  
✅ **Manejo de estructuras complejas**: Anidaciones profundas, arrays mixtos, matrices  
✅ **Visualización optimizada**: Strings largos (JWT, Base64), números grandes, listas extensas  
✅ **Sin configuración**: Simplemente reemplaza `print()` por `printMap()`

## Instalación

Agrega PrintMap a tu `pubspec.yaml`:

```yaml
dependencies:
  print_map: ^1.0.0
```

Luego ejecuta:

```bash
dart pub get
```

o

```bash
flutter pub get
```

## Uso básico

```dart
import 'package:print_map/print_map.dart';

void main() {
  final data = {
    'nombre': 'Juan Pérez',
    'edad': 30,
    'activo': true,
    'saldo': 1250.50,
    'tags': ['desarrollador', 'flutter', 'dart'],
  };
  
  // Antes (print nativo)
  print(data);
  // Salida: {nombre: Juan Pérez, edad: 30, activo: true, saldo: 1250.5, tags: [desarrollador, flutter, dart]}
  
  // Ahora (con PrintMap)
  printMap(data);
  // Salida formateada con colores e indentación
}
```

## API y parámetros

```dart
void printMap(
  dynamic value, {
  String? header,
  String? footer,
  bool timestamp = false,
})
```

- `value`: Cualquier tipo soportado (Map, List, String, int, double, bool, null).
- `header`: Texto opcional que se imprime antes del contenido formateado.
- `footer`: Texto opcional que se imprime después del contenido formateado.
- `timestamp`: Si es `true`, antepone la hora `[HH:mm:ss.SSS]` al `header` y/o `footer`.

Nota: El timestamp no se agrega a cada línea del cuerpo; sólo al `header` y `footer`.

## Esquema de colores

PrintMap utiliza colores ANSI para diferenciar tipos de datos:

| Tipo de dato | Color | Uso |
|--------------|-------|-----|
| `String` | 🤍 Blanco | Cadenas de texto |
| `int` | 💚 Verde | Números enteros |
| `double` | 💛 Amarillo | Números decimales |
| `bool` | 💜 Magenta | Valores booleanos |
| `null` | 🩵 Cyan | Valores nulos |

## Ejemplos

### Ejemplo 1: Map simple

```dart
final usuario = {
  'nombre': 'María García',
  'edad': 28,
  'email': 'maria@example.com',
  'verificado': true,
};

printMap(usuario);
```

**Salida:**
```
{
    nombre: 'María García',      // Blanco
    edad: 28,                     // Verde
    email: 'maria@example.com',   // Blanco
    verificado: true,             // Magenta
},
```

### Ejemplo 2: Anidación profunda

```dart
final config = {
  'app': {
    'name': 'MiApp',
    'version': '1.0.0',
    'settings': {
      'theme': 'dark',
      'notifications': {
        'enabled': true,
        'sound': false,
      }
    }
  }
};

printMap(config);
```

**Salida:**
```
{
    app: {
        name: 'MiApp',
        version: '1.0.0',
        settings: {
            theme: 'dark',
            notifications: {
                enabled: true,
                sound: false,
            },
        },
    },
},
```

### Ejemplo 3: Arrays de objetos

```dart
final usuarios = {
  'users': [
    {'id': 1, 'name': 'Ana', 'active': true},
    {'id': 2, 'name': 'Luis', 'active': false},
    {'id': 3, 'name': 'Carlos', 'active': true},
  ]
};

printMap(usuarios);
```

**Salida:**
```
{
    users: [
    {
      id: 1,
      name: 'Ana',
      active: true,
    },
    {
      id: 2,
      name: 'Luis',
      active: false,
    },
    {
      id: 3,
      name: 'Carlos',
      active: true,
    },
    ],
},
```

### Ejemplo 4: Strings largos (JWT, Base64)

```dart
final auth = {
  'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
  'refreshToken': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
};

printMap(auth);
```

PrintMap maneja strings largos sin problemas, manteniendo la legibilidad.

### Ejemplo 5: Números grandes y notación científica

```dart
final datos = {
  'maxInt': 9223372036854775807,
  'avogadro': 6.022e23,
  'pi': 3.141592653589793,
  'negativo': -999999999,
};

printMap(datos);
```

### Ejemplo 6: Listas homogéneas y heterogéneas

```dart
final listas = {
  'numeros': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
  'mezclado': [1, 'texto', true, null, 3.14, {'key': 'value'}],
  'matriz': [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ],
};

printMap(listas);
```

PrintMap detecta automáticamente si una lista es homogénea (un solo tipo) para formato compacto, o heterogénea (tipos mixtos) para formato expandido.

### Ejemplo 7: Respuesta de API

```dart
final apiResponse = {
  'status': 'success',
  'code': 200,
  'data': {
    'items': [
      {'id': 1, 'title': 'Producto 1', 'price': 99.99},
      {'id': 2, 'title': 'Producto 2', 'price': 149.50},
    ],
    'pagination': {
      'page': 1,
      'perPage': 10,
      'total': 100,
      'hasMore': true,
    }
  },
  'errors': null,
};

printMap(apiResponse);
```

### Opciones: header, footer y timestamp

Agrega contexto a tus impresiones con un encabezado, pie y marca de tiempo.

1) Header y footer con Map

```dart
printMap({
  'service': 'orders',
  'status': 'ok',
  'count': 3,
  'items': [
    {'id': 1, 'price': 10.5},
    {'id': 2, 'price': 22.0},
    {'id': 3, 'price': 7.75},
  ],
}, header: '--- REQUEST ---', footer: '--- END REQUEST ---');
```

2) Timestamp en header/footer con List

```dart
printMap(['alpha', 123, false], header: 'LIST START', footer: 'LIST END', timestamp: true);
```

3) Solo header (con timestamp) en String

```dart
printMap('sample-string', header: 'STRING START', timestamp: true);
```

4) Solo footer (con timestamp) en null

```dart
printMap(null, footer: 'NULL FINISHED', timestamp: true);
```

## Tipos de datos soportados

PrintMap puede imprimir cualquier tipo de valor:

- ✅ `Map<dynamic, dynamic>` - Con cualquier nivel de anidación
- ✅ `List<dynamic>` - Homogéneas o heterogéneas
- ✅ `String` - Cortos, largos, vacíos
- ✅ `int` - Positivos, negativos, grandes
- ✅ `double` - Decimales, notación científica
- ✅ `bool` - true, false
- ✅ `null` - Valores nulos
- ✅ Combinaciones de todos los anteriores

## Casos de uso

### 🔍 Depuración de APIs

```dart
final response = await http.get('https://api.example.com/users');
final data = jsonDecode(response.body);
printMap(data); // Visualiza la respuesta completa con formato
```

### 📦 Inspección de modelos

```dart
final usuario = Usuario.fromJson(json);
printMap(usuario.toJson()); // Examina tu modelo serializado
```

### 🧪 Testing y desarrollo

```dart
test('should parse user data correctly', () {
  final result = parseUserData(mockData);
  printMap(result); // Visualiza el resultado en tests
  expect(result['name'], equals('Juan'));
});
```

### 📊 Análisis de datos complejos

```dart
final config = await loadConfiguration();
printMap(config); // Revisa configuraciones anidadas fácilmente
```

## Comparación: antes vs después

### Con `print()` nativo:
```
{status: success, data: {users: [{id: 1, name: Ana, email: ana@example.com, active: true, roles: [admin, user]}, {id: 2, name: Luis, email: luis@example.com, active: false, roles: [user]}], total: 2}}
```
😵 Ilegible, todo en una línea, sin colores

### Con `printMap()`:
```
{
    status: 'success',
    data: {
        users: [
        {
            id: 1,
            name: 'Ana',
            email: 'ana@example.com',
            active: true,
            roles: [admin, user]
        },
        {
            id: 2,
            name: 'Luis',
            email: 'luis@example.com',
            active: false,
            roles: [user]
        },
        ],
        total: 2,
    },
},
```
😊 Estructurado, con indentación, colores por tipo

## Características técnicas

- 🚀 **Sin dependencias externas**: Solo usa Dart puro
- ⚡ **Rendimiento optimizado**: Maneja grandes estructuras de datos
- 🎯 **Recursión inteligente**: Detecta y formatea anidaciones automáticamente
- 🔄 **Detección de tipos**: Identifica listas homogéneas vs heterogéneas
- 💾 **Memory efficient**: No almacena datos, solo los formatea
- 🎨 **ANSI colors**: Compatible con terminales que soporten códigos ANSI

## Contribuir

Las contribuciones son bienvenidas! Si encuentras un bug o tienes una sugerencia:

1. Abre un issue en GitHub
2. Fork el repositorio
3. Crea una rama para tu feature
4. Envía un pull request

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Autor

Creado con ❤️ para la comunidad de Dart y Flutter

---

**¿Te resultó útil PrintMap?** ⭐ Dale una estrella en GitHub y compártelo con otros desarrolladores!

- Se representan con un color verdoso 


## Desventajas 

**1. ninguna.** 
