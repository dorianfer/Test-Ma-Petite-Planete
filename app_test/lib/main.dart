// Ajout de package pour flutter, pour copier un texte dans le presse papier et pour faire une redirection vers une page web.
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

// Fonction qui permet de lancer l'application.
void main() {
  runApp(const MyApp());
}

// Fonction qui permet d'avoir les informations générales de l'application comme le nom de l'application, sa couleur et la 1er page à afficher.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test Ma Petite Planète'),
    );
  }
}

// Fonction qui permet de configurer la page Home
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Fonction qui permet l'affichage de la page Home
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => contact_page()));
          },
          child: const Row(
            children: <Widget>[
              Icon(Icons.contact_page),
              SizedBox(width: 10),
              Text('Page contact'),
            ],
          ),
        )
      ),
    );
  }
}

// Fonction qui permet de créer l'objet ContactCard qui contiendra un prénom, un nom et un numéro de téléphone.
class ContactCard {
  String Prenom;
  String Nom;
  String Phone;
  ContactCard({required this.Prenom, required this.Nom, required this.Phone});
}

// Fonction qui permet de remplir avec des valeurs l'objet ContactCard.
ContactCard contactCard() {
  return ContactCard(
    Prenom: 'Dorian',
    Nom: 'FERNANDES',
    Phone: '06 51 48 71 24',
  );
}

// Fonction qui permet de créer le visuel d'une card avec l'objet ContactCard et la redirection vers le site google.fr si on clique dessus.
class CardContactlist extends StatelessWidget {
  const CardContactlist({super.key});

  // Fonction qui permet la redirection vers le site google.fr.
  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      final Uri url = Uri.parse('https://google.fr');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    // Fonction qui permet de créer le visuel d'une card.
    var largeurEcran = MediaQuery.of(context).size.width;
    final contact = contactCard();
    return Card(
      child: Container(
        width: largeurEcran,
        child: InkWell(
          onTap: _launchURL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Text("Prénom : ${contact.Prenom}",
                  style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Text("Nom : ${contact.Nom}",
                  style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Text("Numéro de Téléphone : ${contact.Phone}",
                  style: const TextStyle(fontSize: 14)),
              ),

              //
              IconButton(
                onPressed: () {
                  FlutterClipboard.copy(contact.Phone)
                    .then((value) => print('copied'));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Numéro de Téléphone copier."),
                  ));
                },
                icon: const Icon(Icons.content_copy),
              )
            ],
          ),
        ),
      )
    );
  }
}

// Fonction qui permet de créer la page Contact Page.
class contact_page extends StatelessWidget {
  contact_page({super.key});

  // Fonction qui permet de créer dix cards.
  final List<Widget> cards = List.generate(10, (i) => const CardContactlist()).toList();

  // Fonction qui permet l'affichage de la page et des cards.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Page Contact"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: cards,
        ),
      ),
    );
  }
}
