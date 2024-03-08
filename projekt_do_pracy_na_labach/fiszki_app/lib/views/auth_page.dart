import 'package:fiszki_app/backend_communication/api_communication.dart';
import 'package:fiszki_app/views/collections.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
            scale: 0.1,
            height: 400,
            width: 400,
          ),
          Center(
            child: FutureBuilder(
              future: CheckIfAPIIsAlive(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!["message"],
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                } else if (snapshot.hasError) {
                  return Text("No connection to the api");
                } else {
                  return Text("Connecting");
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CollectionsListing()));
            },
            child: Text(
              "Click me",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          )
        ],
      ),
    );
  }
}
