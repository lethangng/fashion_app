import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/configs.dart';
import '../../../models/home_models/evaluate.dart';
import '../../../models/request/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';

class ReviewsViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<ListEvaluate>> evaluateRes =
      ApiResponse<ListEvaluate>.loading().obs;
  final RxList<Evaluate> listEvaluate = <Evaluate>[].obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late final int productId;
  int _page = 1;

  num average_evaluate = 0;
  int count = 0;
  int star_1 = 0;
  int star_2 = 0;
  int star_3 = 0;
  int star_4 = 0;
  int star_5 = 0;

  void setEvaluateRes(ApiResponse<ListEvaluate> res) {
    evaluateRes.value = res;
  }

  Future<void> _fetchDataEvaluate(RequestData req) async {
    try {
      setEvaluateRes(ApiResponse.loading());
      final Map<String, dynamic> res =
          await _accessServerRepository.getData(req);
      ListEvaluate data = ListEvaluate.fromMap(res);

      if (_page == 1) {
        average_evaluate = data.average_evaluate;
        count = data.count;
        star_1 = data.star_1;
        star_2 = data.star_2;
        star_3 = data.star_3;
        star_4 = data.star_4;
        star_5 = data.star_5;
      }

      listEvaluate.addAll(data.evaluates);
      listEvaluate.refresh();

      setEvaluateRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setEvaluateRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadEvaluate() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getEvaluate(
        page: _page,
        product_id: productId,
        limit: 6,
        is_sum: 1,
      ),
      data: Helper.toMapString(data),
    );

    await _fetchDataEvaluate(resquestData);
  }

  Future<void> initData() async {
    await _handleLoadEvaluate();
  }

  Future<void> onRefresh() async {
    _page = 1;
    listEvaluate.value = [];
    await _handleLoadEvaluate();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    _page++;
    await _handleLoadEvaluate();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    productId = Get.arguments['productId'];

    initData();
    super.onInit();
  }
}
