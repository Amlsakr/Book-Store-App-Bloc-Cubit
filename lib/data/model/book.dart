import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Book extends Equatable {
  final int? number;
  final String? title;
  final String? originalTitle;
  final String? releaseDate;
  final String? description;
  final int? pages;
  final String? cover;
  final int? index;

  const Book({
    required this.number,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.description,
    required this.pages,
    required this.cover,
    required this.index,
  });

  @override
  List<Object?> get props => [
    number,
    title,
    originalTitle,
    releaseDate,
    description,
    pages,
    cover,
    index,
  ];

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'title': title,
      'originalTitle': originalTitle,
      'releaseDate': releaseDate,
      'description': description,
      'pages': pages,
      'cover': cover,
      'index': index,
    };
  }

  factory Book.fromJson(Map<String, dynamic> map) {
    return Book(
      number: map['number'] as int,
      title: map['title'] as String,
      originalTitle: map['originalTitle'] as String,
      releaseDate: map['releaseDate'] as String,
      description: map['description'] as String,
      pages: map['pages'] as int,
      cover: map['cover'] as String,
      index: map['index'] as int,
    );
  }
}
