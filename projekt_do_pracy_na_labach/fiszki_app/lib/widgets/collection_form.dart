// import 'package:flutter/material.dart';
// import 'package:textfield_tags/textfield_tags.dart';

// class CollectionForm extends StatefulWidget {
//   const CollectionForm({super.key});

//   @override
//   State<CollectionForm> createState() => _CollectionFormState();
// }

// class _CollectionFormState extends State<CollectionForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextfieldTagsController _controller = TextfieldTagsController();
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("Add new collection"),
//       content: SizedBox(
//         height: 300,
//         width: 200,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: _getCollectionTitleTextField()),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Insert tags here',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       actionsAlignment: MainAxisAlignment.spaceAround,
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             final isOk = _formKey.currentState!.validate();
//             if (isOk) {
//               Navigator.pop(context);
//             }
//           },
//           child: Text("Create"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text("Cancel"),
//         ),
//       ],
//     );
//   }

//   Widget _getCollectionTitleTextField() => TextFormField(
//         validator: (value) {
//           if (value!.length < 8 && value.isNotEmpty) {
//             return "Collection name is too short";
//           } else if (value.length > 30) {
//             return "Collection name is too long";
//           } else if (value.isEmpty) {
//             return "Field is required";
//           } else {
//             return null;
//           }
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: 'Collection name',
//         ),
//       );

//   Widget _getCollectionTags() => TextFieldTags(
//       textSeparators: const [' ', ','],
//       letterCase: LetterCase.normal,
//       validator: (String tag) {
//         if (tag == 'php') {
//           return 'No, please just no';
//         } else if (_controller.getTags.contains(tag)) {
//           return 'you already entered that';
//         }
//         return null;
//       },
//       inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {});
// }
