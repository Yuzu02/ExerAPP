// lib/providers/exercise_list.dart
import 'package:exerapp/exercise/agenda.dart';
import 'package:exerapp/exercise/aprende_frutas.dart';
import 'package:exerapp/exercise/audio.dart';
import 'package:exerapp/exercise/calculator_app.dart';
import 'package:exerapp/exercise/checkbox_calc.dart';
import 'package:exerapp/exercise/ciclo_activity.dart';
import 'package:exerapp/exercise/editor_archivo.dart';
import 'package:exerapp/exercise/frame_layout.dart';
import 'package:exerapp/exercise/image_button.dart';
import 'package:exerapp/exercise/linear_layout.dart';
import 'package:exerapp/exercise/list_view.dart';
import 'package:exerapp/exercise/productos_sqlite.dart';
import 'package:exerapp/exercise/promedio.dart';
import 'package:exerapp/exercise/radio_button.dart';
import 'package:exerapp/exercise/radio_button_calc.dart';
import 'package:exerapp/exercise/recorder.dart';
import 'package:exerapp/exercise/reproductor.dart';
import 'package:exerapp/exercise/save_email.dart';
import 'package:exerapp/exercise/scroll_view.dart';
import 'package:exerapp/exercise/sd_file.dart';
import 'package:exerapp/exercise/spinner_calc.dart';
import 'package:exerapp/exercise/spinner_personalized.dart';
import 'package:exerapp/exercise/sumar.dart';
import 'package:exerapp/models/exercise.dart';
import 'package:exerapp/models/exercise_category.dart';
import 'package:exerapp/screens/extra/url_input_screen.dart';

final List<Exercise> exerciseList = [
  Exercise(
    id: '1',
    title: 'Calculadora Básica',
    description:
        'Una calculadora con operaciones básicas: suma, resta, multiplicación y división.',
    category: ExerciseCategory.calculators,
    app: const CalculatorApp(),
    concepts: [
      'Widgets Stateful',
      'Manejo de eventos',
      'Operaciones matemáticas'
    ],
    difficulty: 'Fácil',
    tags: ['Calculadora', 'TableRow', 'TableLayout'],
  ),
  Exercise(
      id: '2',
      title: "Ciclo de vida de un activity",
      description: "Muestra los estados de un widget en Flutter",
      category: ExerciseCategory.utilities,
      app: const LifeCycleExample(),
      difficulty: "Intermedio",
      tags: ["Ciclo de vida", "StatefulWidget"],
      concepts: ["initState", "didChangeDependencies", "dispose"]),
  Exercise(
      id: '3',
      title: "List View",
      description: "Usa un ListView para mostrar una lista de elementos",
      category: ExerciseCategory.utilities,
      app: const CustomListView(),
      difficulty: "Fácil",
      tags: ["ListView", "StatelessWidget"],
      concepts: ["ListView", "ListTile"]),
  Exercise(
      id: "4",
      title: "webview",
      description: "Muestra una página web en tu aplicación",
      category: ExerciseCategory.utilities,
      app: const UrlInputScreen(),
      difficulty: "Intermedio",
      tags: ["WebView", "StatefulWidget"],
      concepts: ["webview", "webview_flutter"]),
  Exercise(
      id: '5',
      title: 'Sumar',
      description: 'Suma dos números',
      category: ExerciseCategory.calculators,
      app: const SumWidget(),
      difficulty: 'Fácil',
      tags: ['Suma', 'Básico'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar']),
  Exercise(
      id: '6',
      title: 'Promedio Estudiante',
      description: 'Calcula el promedio de tres calificaciones',
      category: ExerciseCategory.calculators,
      app: const StudentStatusWidget(),
      difficulty: 'Fácil',
      tags: ['Promedio', 'Básico'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar']),
  Exercise(
      id: '7',
      title: 'RadioButton',
      description: 'Calcula la suma o resta de dos números',
      category: ExerciseCategory.calculators,
      app: const RadioButtonWidget(),
      difficulty: 'Fácil',
      tags: ['RadioButton', 'Básico'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar', 'Radio']),
  Exercise(
      id: '8',
      title: 'Radio Button Calculator',
      description:
          'Calcula la suma, resta, multiplicación o división de dos números',
      category: ExerciseCategory.calculators,
      app: const RadioCalc(),
      difficulty: 'Intermedio',
      tags: ['RadioButton', 'Intermedio'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar', 'Radio']),
  Exercise(
      id: '9',
      title: 'CheckBox Calculator',
      description: 'Calcula la suma o resta de dos números al mismo tiempo',
      category: ExerciseCategory.calculators,
      app: const CheckBoxCalc(),
      difficulty: 'Intermedio',
      tags: ['CheckBox', 'Intermedio'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar', 'CheckBox']),
  Exercise(
      id: '10',
      title: 'Calculadora Spinner',
      description:
          'Calcula la suma, resta, multiplicación o división de dos números',
      category: ExerciseCategory.calculators,
      app: const SpinnerWidget(),
      difficulty: 'Intermedio',
      tags: ['DropdownButton', 'Intermedio'],
      concepts: ['StatefulWidget', 'TextField', 'SnackBar', 'DropdownButton']),
  Exercise(
      id: '11',
      title: 'Calculadora Spinner Personalizada',
      description:
          'Calcula la suma, resta, multiplicación o división de dos números',
      category: ExerciseCategory.calculators,
      app: const SpinnerVtwo(),
      difficulty: 'Intermedio',
      tags: [
        'DropdownButton',
        'Intermedio'
      ],
      concepts: [
        'StatefulWidget',
        'TextField',
        'SnackBar',
        'DropdownButton',
        'DropdownMenuItem'
      ]),
  Exercise(
      id: '12',
      title: "Image Button",
      description: "Muestra una imagen en un botón",
      category: ExerciseCategory.utilities,
      app: const ImageButtonScreen(),
      difficulty: "Fácil",
      tags: ["ImageButton", "StatefulWidget"],
      concepts: ["Image", "InkWell"]),
  Exercise(
      id: '13',
      title: "SharedPreferences",
      description: "Guarda y recupera datos en el dispositivo",
      category: ExerciseCategory.utilities,
      app: const EmailInputWidget(),
      difficulty: "Intermedio",
      tags: ["SharedPreferences", "StatefulWidget"],
      concepts: ["SharedPreferences", "TextField"]),
  Exercise(
      id: '14',
      title: 'Agenda',
      description: 'Guarda y recupera datos en el dispositivo',
      category: ExerciseCategory.utilities,
      app: const AgendaApp(),
      difficulty: 'Intermedio',
      tags: ['SharedPreferences', 'StatefulWidget'],
      concepts: ['SharedPreferences', 'TextField']),
  Exercise(
      id: '15',
      title: 'FileEditorApp',
      description: 'Guarda y recupera datos en el dispositivo',
      category: ExerciseCategory.utilities,
      app: const FileEditorApp(),
      difficulty: 'Intermedio',
      tags: ['permission_handler', 'StatefulWidget', 'path_provider'],
      concepts: ['SharedPreferences', 'TextField']),
  Exercise(
    id: '16',
    title: 'SD FileEditor',
    description:
        "Editor de archivos de texto que permite crear, guardar y leer archivos en la memoria externa del dispositivo",
    category: ExerciseCategory.utilities,
    app: const SDFileEditorApp(),
    difficulty: 'Intermedio',
    tags: [
      "File Handling",
      "Storage",
      "Permissions",
      "TextFields",
      "StatefulWidget"
    ],
    concepts: ["File I/O"],
  ),
  Exercise(
      id: '17',
      title: 'CRUD SQLite',
      description: 'Aplicación para gestionar productos en una base de datos',
      category: ExerciseCategory.utilities,
      app: const ProductManagerApp(),
      difficulty: 'Intermedio',
      tags: ['SFQLite', 'CRUD', 'StatefulWidget'],
      concepts: ['SFQLite', 'CRUD', 'Database']),
  Exercise(
      id: '18',
      title: 'Linear Layout',
      description: 'Login con Linear Layout',
      category: ExerciseCategory.visualization,
      app: LinearLayoutLogin(),
      difficulty: 'Fácil',
      tags: ['Login', 'Linear Layout'],
      concepts: ['Text', 'TextField', 'ElevatedButton']),
  Exercise(
      id: '19',
      title: 'Frame Layout',
      description: 'Uso de un button para ocultar y mostrar una imagen',
      category: ExerciseCategory.visualization,
      app: const FrameLayoutExample(),
      difficulty: 'Fácil',
      tags: ['Frame Layout', 'ElevatedButton', 'Image'],
      concepts: ['Stack', 'Positioned', 'Visibility']),
  Exercise(
      id: '20',
      title: 'Galería de Frutas',
      description:
          'Muestra una galería de frutas con imágenes usando SingleChildScrollView',
      category: ExerciseCategory.visualization,
      app: const FruitGallery(),
      difficulty: 'Fácil',
      tags: ['SingleChildScrollView', 'Card', 'Column'],
      concepts: ['SingleChildScrollView', 'Card', 'Column']),
  Exercise(
      id: '21',
      title: 'Aprende con frutas',
      description:
          'Muestra una galería de frutas con imágenes y un AppBar acorde a la UI',
      category: ExerciseCategory.visualization,
      app: const FruitGalleryColor(),
      difficulty: 'Fácil',
      tags: ['AppBar', 'SingleChildScrollView', 'Card', 'Column'],
      concepts: ['Colors', 'Design']),
  Exercise(
      id: '22',
      title: 'Reproductor de Audio',
      description: 'Reproduce audios cortos y largos',
      category: ExerciseCategory.utilities,
      app: const AudioPlayerWidget(),
      difficulty: 'Intermedio',
      tags: ['Audio', 'Reproductor'],
      concepts: ['AudioPlayer', 'AudioCache', "Just_Audio"]),
  Exercise(
      id: '23',
      title: 'Music Player Complete',
      description:
          'Reproductor de música con todas las features , play, pause, stop, next, previous',
      category: ExerciseCategory.utilities,
      app: const MusicPlayerComplete(),
      difficulty: 'Intermedio',
      tags: ['Audio', 'Reproductor'],
      concepts: ['AudioPlayer', 'AudioCache', "Just_Audio"]),
  Exercise(
      id: '24',
      title: 'Audio Recorder',
      description: 'Graba y reproduce audios',
      category: ExerciseCategory.utilities,
      app: const AudioRecorderWidget(),
      difficulty: 'Intermedio',
      tags: ['flutter_sound', 'Audio', 'Reproductor'],
      concepts: ['AudioRecorder', 'AudioPlayer', 'flutter_sound']),
  // More Some on..
];
