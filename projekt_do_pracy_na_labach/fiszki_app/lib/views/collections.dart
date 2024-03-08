import 'package:fiszki_app/backend_communication/api_communication.dart';
import 'package:fiszki_app/models/collection.dart';
import 'package:fiszki_app/views/flash_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class CollectionsListing extends StatefulWidget {
  const CollectionsListing({super.key});

  @override
  State<CollectionsListing> createState() => _CollectionListingState();
}

class _CollectionListingState extends State<CollectionsListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcards collections"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getFlashCardCollections(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text("No flashcards found");
              } else {
                final List<Collection> collections = snapshot.data!;
                return ListView.builder(
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      return CollectionCard(collection: collections[index]);
                    });
              }
            } else if (snapshot.hasError) {
              return Text("Unexpected error occured. ${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: _retrieveFab(context),
    );
  }

  Widget _retrieveFab(BuildContext context) {
    return ExpandableFab(
      type: ExpandableFabType.up,
      children: [
        FloatingActionButton.small(
          tooltip: "Add new collection",
          heroTag: null,
          child: const Icon(Icons.add),
          onPressed: () async {
            final isDone = await postNewFlashCard();

            if (isDone) {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text("You have added to api"),
                ),
              );
              setState(() {});
            } else {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text("You have not added to api"),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class CollectionCard extends StatelessWidget {
  const CollectionCard({super.key, required this.collection});
  final Collection collection;
  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          child: ListTile(
            title: Text(collection.title),
            subtitle: collection.tags != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: collection.tags!
                        .map(
                          (tag) => _tag(tag, context),
                        )
                        .toList(),
                  )
                : null,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashCards(collection: collection),
              ),
            );
          },
        ),
      );
  Widget _tag(String text, BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ],
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(20)),
        child: Text(text),
      );
}
