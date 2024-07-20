import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Incidencia> _incidencias = [];

  void agregarIncidencia(Incidencia incidencia) {
    setState(() {
      _incidencias.add(incidencia);
    });
  }

  void borrarRegistros() {
    setState(() {
      _incidencias.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se han borrado todos los registros.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardiana'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: AppDrawer(
        borrarRegistros: borrarRegistros,
      ),
      body: const Center(
        child: Text('Contenido de la página de inicio'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegistroIncidenciasPage(
                onGuardar: agregarIncidencia,
              ),
            ),
          );
        },
        tooltip: 'Registrar Incidencia',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final VoidCallback borrarRegistros;

  const AppDrawer({Key? key, required this.borrarRegistros}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú Guardiana',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Registro de incidencias'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegistroIncidenciasPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.error),
            title: const Text('Incidencias'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IncidenciasPage(incidencias: _incidencias)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('Caso de Emergencia'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              borrarRegistros(); // Llama a la función para borrar registros
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AcercaDePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Oficial:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nombre: Robert\nApellido: de Niro\nMatrícula: 2022-0396',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Reflexión:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'La seguridad comienza con la vigilancia. Proteger a la comunidad es nuestro deber y nuestra misión.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistroIncidenciasPage extends StatelessWidget {
  final Function(Incidencia) onGuardar;

  const RegistroIncidenciasPage({Key? key, required this.onGuardar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Incidencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
              onChanged: (titulo) {
                _titulo = titulo;
              },
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  // Implementa la lógica para manejar la fecha seleccionada
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Fecha',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Seleccionar fecha',
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              onChanged: (descripcion) {
                _descripcion = descripcion;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final incidencia = Incidencia(
                  titulo: _titulo,
                  fecha: _selectedDate,
                  descripcion: _descripcion,
                );

                // Llama a la función callback para guardar la incidencia
                onGuardar(incidencia);

                Navigator.pop(context); // Vuelve a la pantalla anterior
              },
              child: const Text('Guardar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }
}

class IncidenciasPage extends StatelessWidget {
  final List<Incidencia> incidencias;

  const IncidenciasPage({Key? key, required this.incidencias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidencias'),
      ),
      body: ListView.builder(
        itemCount: incidencias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(incidencias[index].titulo),
            subtitle: Text(incidencias[index].descripcion),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleIncidenciaPage(incidencia: incidencias[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalleIncidenciaPage extends StatelessWidget {
  final Incidencia incidencia;

  const DetalleIncidenciaPage({Key? key, required this.incidencia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fecha: ${incidencia.fecha.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Descripción: ${incidencia.descripcion}',
            ),
          ],
        ),
      ),
    );
  }
}

class Incidencia {
  final String titulo;
  final DateTime fecha;
  final String descripcion;

  Incidencia({required this.titulo, required this.fecha, required this.descripcion});
}


