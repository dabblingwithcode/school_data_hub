// import 'dart:typed_data';

// import 'package:html/parser.dart' show parse;
// import 'package:http/http.dart' as http;

// //- TODO: This is experimental code and should be tested before using in production
// class IsbnApiData {
//   final Uint8List? image;
//   final String imageUrl;
//   final String title;
//   final String author;
//   final String description;
//   IsbnApiData(
//       {required this.image,
//       required this.imageUrl,
//       required this.title,
//       required this.author,
//       required this.description});
// }

// Future<IsbnApiData> getIsbnApiData(String isbn) async {
//   final cleanIsbn = isbn.replaceAll('-', '');
//   // We check a German isbn resource for the book info
//   final imageUrl = "https://buch.isbn.de/cover/$cleanIsbn.jpg";
//   final url = 'https://www.isbn.de/buch/$isbn';
//   final response = await http.get(Uri.parse(url));
//   //debugger();
//   final document = parse(response.body);
//   // We scraoe the title, author and description from the html

//   // Extract the title
//   var dataElement = document.querySelector('data[itemprop="product-id"]');
//   final title = dataElement?.text ?? '?';

//   // Extract the author
//   var smallElement = document.querySelector('.isbnhead small');
//   final author = smallElement?.text ?? '?';

//   // Extract the description
//   var bookDescElement = document.querySelector('#bookdesc');
//   String description = 'Nicht vorhanden';
//   if (bookDescElement != null) {
//     description = bookDescElement.innerHtml
//         .replaceAll('<br>', '')
//         .replaceAll(RegExp(r'<[^>]*>'), '')
//         .trim();

//     description = description.replaceAll('\n', '');

// // Replace multiple consecutive spaces with a newline
//     description = description.replaceAll(RegExp(r' {2,}'), '\n');
//   }
//   final image = await http.get(Uri.parse(imageUrl));
//   if (image.statusCode != 200) {
//     return IsbnApiData(
//         image: null,
//         imageUrl: 'https://via.placeholder.com/150',
//         title: title,
//         author: author,
//         description: description);
//   }

//   return IsbnApiData(
//       image: image.bodyBytes,
//       imageUrl: imageUrl,
//       title: title,
//       author: author,
//       description: description.toString());

// }
