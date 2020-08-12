import 'dart:convert';

import 'package:flutter_app/core/model/book.dart';
import 'package:http/http.dart';

import '../utils/strings.dart';

class NetworkCall {
  Future<List<Book>> fetchBooks() async {
    List<Book> books = [];
    Response response =
        await get('$baseUrl?q=subject:fiction&maxResults=40&key=$apiKey');
    var data = jsonDecode(response.body);
    data['items'].forEach((data) {
      Book book = Book(
        title: data['volumeInfo']['title'],
        imgUrl: data['volumeInfo']['imageLinks']['thumbnail'],
        author: data['volumeInfo']['authors'][0],
        desc: data['volumeInfo']['description'],
        category: data['volumeInfo']['categories'][0],
        language: data['volumeInfo']['language'],
        pages: data['volumeInfo']['pageCount'],
      );
      books.add(book);
    });
    return books;
  }
}
