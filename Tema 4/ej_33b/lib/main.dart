import 'dart:convert';

import 'package:ej_33b/Note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, __) => MaterialApp(
        title: "Notas",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: theme.themeMode,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Note> notes = context.watch<NotesProvider>().listNotes;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Notes")),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
          icon: Icon(Icons.settings),
        ),
      ),
      body: notes.isEmpty
          ? Center(child: Text("Empty notes"))
          : Center(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notes[index].title),
                      subtitle: notes[index].content.isEmpty
                          ? Text("No description")
                          : Text(notes[index].content),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<NotesProvider>().removeNote(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
        },
      ),
    );
  }
}

class AddNoteScreen extends StatelessWidget {
  final validarFormulario = GlobalKey<FormState>();
  TextEditingController? title = TextEditingController();
  TextEditingController? description = TextEditingController();
  AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formalurio notas")),
      body: Form(
        key: validarFormulario,
        child: Column(
          children: [
            Card(
              child: TextFormField(
                controller: title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Write a title";
                  }
                },
                decoration: InputDecoration(label: Text("Titulo")),
              ),
            ),
            Card(
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(label: Text("Descripcion")),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (validarFormulario.currentState!.validate()) {
                    Note note = Note(
                      title: title!.text,
                      content: description!.text,
                    );
                    context.read<NotesProvider>().addNote(note);
                    Navigator.pop(context);
                  }
                },
                child: Text("Add note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDark;
    return Scaffold(
      appBar: AppBar(title: Text("Setting screen")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Modo oscuro"),
              Switch(
                value: isDark,
                onChanged: (value) {
                  isDark = value;
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesProvider extends ChangeNotifier {
  NotesProvider() {
    _loadFromPrefs();
  }
  List<Note> notes = [];

  List<Note> get listNotes => notes;

  void addNote(Note note) {
    notes.add(note);
    _savePrefs();
    notifyListeners();
  }

  void removeNote(int index) {
    notes.removeAt(index);
    _savePrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? list = prefs.getStringList('notes') ?? [];
    notes = list
        .map((noteString) => Note.fromJson(jsonDecode(noteString)))
        .toList();
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', list);
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;
  ThemeProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
  }
}
