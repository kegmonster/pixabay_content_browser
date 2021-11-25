import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:pixabay_content_browser/models/base_item.dart';
import 'package:pixabay_content_browser/providers/pixabay_api_provider.dart';

class FolderContentProvider extends ChangeNotifier{

  List<BaseItem> _baseItems = [];
  final String searchTerm;
  String _lastError = '';
  int _currentPage = 1;
  bool busy = false;
  SortBy sortOrder = SortBy.name;
  PixabayAPIProvider pixabayAPIProvider = PixabayAPIProvider();
  bool hasMore = true;
  final Client client = Client();

  FolderContentProvider(this.searchTerm);

  void fetchMoreItems() async {
    try {
      List<BaseItem> items = await pixabayAPIProvider.fetchItems(client, searchTerm, _currentPage.toString());
      if (items.length >= 2 * PixabayAPIProvider.PAGE_SIZE && items.length > 0){
        hasMore = true;
      }
      else{
        hasMore = false;
      }
      _currentPage++;
      _sort(items, sortOrder);
      _baseItems.addAll(items);
    }catch(exception){
      hasMore = false;
      _lastError = exception.toString();
    }
    notifyListeners();
  }

  void setBusy(bool state)  {
    busy = state;
    notifyListeners();
  }

  get lastError {
    return _lastError;
  }

  List<BaseItem> get baseItems {
    return _baseItems;
  }

  void sort(SortBy sortBy){
    _sort(_baseItems, sortBy);
    notifyListeners();
  }

  void _sort(List<BaseItem> items, SortBy sortBy){
    switch(sortBy){
      case SortBy.name:
        // TODO: Handle this case.
        items.sort((a,b) => a.fileName.compareTo(b.fileName));
        break;
      case SortBy.date:
        // TODO: Handle this case.
        items.sort((a,b) => a.creationDate.compareTo(b.creationDate));
        break;
    }
  }
}

String sortByLookup(SortBy sortBy){
  switch(sortBy){
    case SortBy.name:
      return 'Name';
    case SortBy.date:
      return 'Date';
  }
}

enum SortBy{
  name,
  date
}
