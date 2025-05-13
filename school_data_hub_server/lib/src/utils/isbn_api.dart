import 'dart:typed_data';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:school_data_hub_server/src/utils/local_storage.dart';
import 'package:serverpod/serverpod.dart';

//- TODO: This is experimental code and should be tested before using in production
class IsbnApiData {
  // final Uint8List? image;
  final String imagePath;
  final String title;
  final String author;
  final String description;
  IsbnApiData(
      { // required this.image,
      required this.imagePath,
      required this.title,
      required this.author,
      required this.description});
}

class IsbnApi {
  static Future<IsbnApiData> fetchIsbnApiData(Session session, int isbn) async {
    // We check a German isbn resource for the book info
    final imageUrl = "https://buch.isbn.de/cover/$isbn.jpg";
    final url = 'https://www.isbn.de/buch/$isbn';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load book data');
    }

    final document = parse(response.body);
    // We extract the title, author and description from the html

    // Extract the title
    var dataElement = document.querySelector('data[itemprop="product-id"]');
    final title = dataElement?.text ?? '?';

    // Extract the author
    var smallElement = document.querySelector('.isbnhead small');
    final author = smallElement?.text ?? '?';

    // Extract the description
    var bookDescElement = document.querySelector('#bookdesc');
    String description = 'Nicht vorhanden';
    if (bookDescElement != null) {
      description = bookDescElement.innerHtml
          .replaceAll('<br>', '')
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .trim();

      description = description.replaceAll('\n', '');

      // Replace multiple consecutive spaces with a newline
      description = description.replaceAll(RegExp(r' {2,}'), '\n');
    }
    final image = await http.get(Uri.parse(imageUrl));
    if (image.statusCode != 200) {
      // If the image is not found, we return a placeholder image
      return IsbnApiData(
          imagePath: 'https://via.placeholder.com/150',
          title: title,
          author: author,
          description: description);
    }
    // We have the image, let's transform it to byteData and store it
    final byteData = ByteData.view(image.bodyBytes.buffer);

    await session.storage.storeFile(
      storageId: LocalStorageId.public.storageId, // or private
      path: 'isbn',
      byteData: byteData,
    );
    final isbnFileUrl = await session.storage.getPublicUrl(
      storageId: LocalStorageId.public.storageId,
      path: 'isbn',
    );
    if (isbnFileUrl == null) {
      throw Exception('Failed to get public URL for image');
    }
    // pass the path to the image to the object
    return IsbnApiData(
      // image: image.bodyBytes,
      imagePath: isbnFileUrl.toString(),
      title: title,
      author: author,
      description: description,
    );
  }
}
