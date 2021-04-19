import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/wiki_search_api_model.dart';

class ApiHelper {
  static const String _requestUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description';

  static const String wikiUrl = "https://en.wikipedia.org/wiki/";

 Future<WikiSearchApiModel> getDataForSearchQueryFromWikiApi(String value, int limit) async {
print('url:**** $_requestUrl&gpssearch=$value&gpslimit=$limit');
    http.Response response = await http
        .get(Uri.parse('$_requestUrl&gpssearch=$value&gpslimit=10'));
print('api response:**** status: ${response.statusCode}, data: ${response.body.toString()}');
    return compute(wikiSearchApiModelFromJson, response.body);

  }
}
