import 'heroe_model.dart';

class SearchResult {
  late String response;
  late String resultsFor;
  late List<Heroe> results;

  SearchResult(
      {required this.response,
      required this.resultsFor,
      required this.results});

  SearchResult.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    resultsFor = json['results-for'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new Heroe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['results-for'] = this.resultsFor;
    data['results'] = this.results.map((v) => v.toJson()).toList();

    return data;
  }
}
