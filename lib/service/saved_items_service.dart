import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';

class SavedItemService with ChangeNotifier {
  var savedItemList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  fetchSavedItem() async {
    _isLoading = true;
    savedItemList = await DbService().getAllSaveditem().whenComplete(
      () {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  remove(
      int serviceId,
      String title,
      String image,
      var price,
      String sellerName,
      double rating,
      int index,
      BuildContext context,
      sellerId,
      exp) async {
    await DbService().saveOrUnsave(serviceId, title, image, price, sellerName,
        rating, context, sellerId, exp);
    fetchSavedItem();
    Provider.of<TopRatedServicesSerivce>(context, listen: false)
        .topServiceSaveUnsaveFromOtherPage(serviceId, title, sellerName);
    Provider.of<RecentServicesService>(context, listen: false)
        .recentServiceSaveUnsaveFromOtherPage(serviceId, title, sellerName);
  }
}
