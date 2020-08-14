import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_app/core/model/book.dart';

import '../utils/strings.dart';

class NetworkCall {
  Future<List<Book>> fetchBooks() async {
    List<Book> books = [];
    await _call(category: 'fiction', books: books);
    await _call(category: 'poetry', books: books);
    await _call(category: 'design', books: books);
    await _call(category: 'cooking', books: books);
    await _call(category: 'nature', books: books);
    await _call(category: 'philosophy', books: books);
    await _call(category: 'education', books: books);
    await _call(category: 'comics', books: books);
    await _call(category: 'health', books: books);
    await _call(category: 'business', books: books);
    return books;
  }

  Future<List<List<Book>>> fetchBooksAccordingToCategory() async {
    List<List<Book>> booksList = [];
    List<Book> fictionBooks = [];
    List<Book> poetryBooks = [];
    List<Book> designBooks = [];
    List<Book> cookingBooks = [];
    List<Book> natureBooks = [];
    List<Book> philosophyBooks = [];
    List<Book> educationBooks = [];
    List<Book> comicsBooks = [];
    List<Book> healthBooks = [];
    List<Book> businessBooks = [];
    await _call(category: 'fiction', books: fictionBooks);
    await _call(category: 'poetry', books: poetryBooks);
    await _call(category: 'design', books: designBooks);
    await _call(category: 'cooking', books: cookingBooks);
    await _call(category: 'nature', books: natureBooks);
    await _call(category: 'philosophy', books: philosophyBooks);
    await _call(category: 'education', books: educationBooks);
    await _call(category: 'comics', books: comicsBooks);
    await _call(category: 'health', books: healthBooks);
    await _call(category: 'business', books: businessBooks);
    booksList.addAll([
      fictionBooks,
      poetryBooks,
      designBooks,
      cookingBooks,
      natureBooks,
      philosophyBooks,
      educationBooks,
      cookingBooks,
      healthBooks,
      businessBooks
    ]);
    return booksList;
  }

  Future<Null> _call({String category, List<Book> books}) async {
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Dio _dio = Dio();
    Options _cacheOptions = buildCacheOptions(Duration(days: 7));

    _dio.interceptors.add(_dioCacheManager.interceptor);

    Response response = await _dio.get(
        '$baseUrl?q=subject:$category&maxResults=39&key=$apiKey',
        options: _cacheOptions);
    if (response.statusCode == 200) {
      response.data['items'].forEach((data) {
        Book book = Book(
          title: data['volumeInfo']['title'],
          imgUrl: data['volumeInfo']['imageLinks'] == null
              ? 'no'
              : data['volumeInfo']['imageLinks']['thumbnail'],
          author: data['volumeInfo']['authors'] == null
              ? 'Anonymous'
              : data['volumeInfo']['authors'][0],
          desc: data['volumeInfo']['description'],
          category: data['volumeInfo']['categories'] == null
              ? category
              : data['volumeInfo']['categories'][0],
          language: data['volumeInfo']['language'],
          pages: data['volumeInfo']['pageCount'],
        );
        books.add(book);
      });
    }
  }
}
