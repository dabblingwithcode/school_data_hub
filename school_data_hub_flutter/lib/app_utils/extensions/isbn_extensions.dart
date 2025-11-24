extension DisplayAsIsbn on int {
  String displayAsIsbn() {
    final String isbn = toString();
    return isbn.length == 13
        ? "${isbn.substring(0, 3)}-${isbn.substring(3, 4)}-${isbn.substring(4, 6)}-${isbn.substring(6, 12)}-${isbn.substring(12, 13)}"
        : isbn.length == 10
        ? "${isbn.substring(0, 1)}-${isbn.substring(1, 5)}-${isbn.substring(5, 9)}-${isbn.substring(9, 10)}"
        : isbn;
  }
}
