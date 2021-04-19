import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/api_helper.dart';
import 'package:test_task/db_helper.dart';

class WikiSearchViewModel extends ChangeNotifier {
  WikiSearchViewModel() {
    getResultForSearchQuery();
  }

  TextEditingController searchController =
      TextEditingController(text: "Sachin");
  FocusNode searchFocus = FocusNode();

  List<PageData> resultList = [];

  bool hasConnection = true;

  bool isLoading  = false;

  updateUi() {
    notifyListeners();
  }

  getResultForSearchQuery() async {

    DbHelper dbHelper = DbHelper.instance;

    hasConnection = await DataConnectionChecker().hasConnection;
isLoading = true;
notifyListeners();
    if (hasConnection) {
      ApiHelper()
          .getDataForSearchQueryFromWikiApi(searchController.text.toString(), 20)
          .then((response) {
        resultList.clear();
        for (var i in response.query.pages) {
          resultList.add(PageData(
              title: i.title,
              url: i.thumbnail != null ? i.thumbnail.source : null,
              desc: i.terms.description[0],
              pageId: i.pageid));
          dbHelper.insertListData(PageData(
              title: i.title,
              url: i.thumbnail != null ? i.thumbnail.source : null,
              desc: i.terms.description[0],
              pageId: i.pageid));
        }
        isLoading = false;
        notifyListeners();
      });
    } else {
      dbHelper
          .getListDataFromDb(searchController.text.toString())
          .then((value) {
        resultList.clear();
        if (value.isNotEmpty) {
          for (var i in value) {
            resultList.add(i);
          }
        }
        isLoading = false;
        notifyListeners();
      });
    }
  }
}
