import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/configs.dart';
import '../../../models/home_models/brand.dart';
import '../../../models/home_models/category.dart';
import '../../../models/home_models/product_color.dart';
import '../../../models/home_models/product.dart';
import '../../../models/home_models/product_size.dart';
import '../../../models/request/request_data.dart';
import '../../../models/shop_models/category_sort.dart';
import '../../../models/shop_models/filters.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import 'search_view_viewmodel.dart';

enum FilterType {
  price,
  color,
  size,
  category,
  brand,
}

class FiltersViewmodel extends GetxController {
  final SearchViewViewmodel _searchViewModel = Get.find<SearchViewViewmodel>();
  RxList<CategorySort> listSort = [
    CategorySort(id: 0, title: 'Mới nhất', isSelect: true),
    CategorySort(id: 1, title: 'Cũ nhất', isSelect: false),
    CategorySort(
      id: 2,
      title: 'Giá: Từ cao xuông thấp',
      isSelect: false,
    ),
    CategorySort(
      id: 3,
      title: 'Giá: Từ thấp đến cao',
      isSelect: false,
    ),
  ].obs;

  late final RxString sortValue;
  int _page = 1;

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  RxList<Filters> listPrice = [
    Filters(
        id: 1, title: '0-100k', minPrice: 0, maxPrice: 100000, isSelect: false),
    Filters(
        id: 2,
        title: '100k-200k',
        minPrice: 100000,
        maxPrice: 200000,
        isSelect: false),
    Filters(
        id: 3,
        title: '200k-300k',
        minPrice: 200000,
        maxPrice: 300000,
        isSelect: false),
    Filters(
        id: 4,
        title: '300k-500k',
        minPrice: 300000,
        maxPrice: 500000,
        isSelect: false),
  ].obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final RxList<Filters> listColors = <Filters>[].obs;
  final RxList<Filters> listSizes = <Filters>[].obs;
  final RxList<Filters> listCategory = <Filters>[].obs;
  final RxList<Filters> listBrand = <Filters>[].obs;

  final RxList<Product> listData = <Product>[].obs;

  final Rx<ApiResponse<bool>> loadRes = ApiResponse<bool>.loading().obs;

  final Rx<ApiResponse<List<Product>>> loadDataRes =
      ApiResponse<List<Product>>.loading().obs;

  void setLoadRes(ApiResponse<bool> res) {
    loadRes.value = res;
  }

  void setLoadDataRes(ApiResponse<List<Product>> res) {
    loadDataRes.value = res;
  }

  Future<void> handleSelectSort(int id) async {
    for (var item in listSort) {
      item.isSelect = false;
      if (item.id == id) {
        item.isSelect = !item.isSelect;
        sortValue.value = item.title;
      }
    }
    listSort.refresh();
    setLoadDataRes(ApiResponse.loading());
    await onRefresh();
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      // setLoadDataRes(ApiResponse.loading());
      final List res = await _accessServerRepository.getData(req);
      List<Product> data = res.map((item) => Product.fromMap(item)).toList();

      setLoadDataRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setLoadDataRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    List<int> listBrandVal = [];
    List<int> listCategoryVal = [];
    List<int> listColorVal = [];
    List<int> listSizeVal = [];

    for (var item in listBrand) {
      if (item.isSelect) listBrandVal.add(item.id);
    }
    for (var item in listCategory) {
      if (item.isSelect) listCategoryVal.add(item.id);
    }
    for (var item in listColors) {
      if (item.isSelect) listColorVal.add(item.id);
    }
    for (var item in listSizes) {
      if (item.isSelect) listSizeVal.add(item.id);
    }

    Filters? selectPrice;
    for (var item in listPrice) {
      if (item.isSelect) selectPrice = item;
    }

    CategorySort? categorySort;
    for (var item in listSort) {
      if (item.isSelect) categorySort = item;
    }

    int? minPrice = minPriceController.text.isNotEmpty
        ? int.parse(minPriceController.text)
        : null;
    int? maxPrice = maxPriceController.text.isNotEmpty
        ? int.parse(maxPriceController.text)
        : null;

    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getFilterProduct(
        page: _page,
        limit: 6,
        product_name: _searchViewModel.searchController.text,
        sort: categorySort!.id,
        min_price: minPrice ?? selectPrice?.minPrice,
        max_price: maxPrice ?? selectPrice?.maxPrice,
        brands: json.encode(listBrandVal),
        categories: json.encode(listCategoryVal),
        colors: json.encode(listColorVal),
        sizes: json.encode(listSizeVal),
      ),
      data: Helper.toMapString(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> onRefresh() async {
    _page = 1;
    listData.value = [];
    await handleLoad();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    _page++;
    await handleLoad();
    refreshController.loadComplete();
  }

  Future<void> _fetchDataBrand(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<Brand> data = res.map((item) => Brand.fromMap(item)).toList();

      List<Filters> listFilters =
          data.map((item) => Filters.brandToFilter(item)).toList();

      listBrand.addAll(listFilters);
      listBrand.refresh();
    } catch (e, s) {
      s.printError();

      setLoadRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadBrand() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getBrand(),
      data: Helper.toMapString(data),
    );

    await _fetchDataBrand(resquestData);
  }

  Future<void> _fetchDataColor(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<ProductColor> data =
          res.map((item) => ProductColor.fromMap(item)).toList();

      List<Filters> listFilters =
          data.map((item) => Filters.colorToFilter(item)).toList();

      listColors.addAll(listFilters);
      listColors.refresh();
    } catch (e, s) {
      s.printError();
      setLoadRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadColor() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getColor(),
      data: Helper.toMapString(data),
    );

    await _fetchDataColor(resquestData);
  }

  Future<void> _fetchDataSize(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<ProductSize> data =
          res.map((item) => ProductSize.fromMap(item)).toList();

      List<Filters> listFilters =
          data.map((item) => Filters.sizeToFilter(item)).toList();

      listSizes.addAll(listFilters);
      listSizes.refresh();
    } catch (e, s) {
      s.printError();
      setLoadRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadSize() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getSize(),
      data: Helper.toMapString(data),
    );

    await _fetchDataSize(resquestData);
  }

  Future<void> _fetchDataCategory(RequestData req) async {
    try {
      final List res = await _accessServerRepository.getData(req);
      List<Category> data = res.map((item) => Category.fromMap(item)).toList();

      List<Filters> listFilters =
          data.map((item) => Filters.categoryToFilter(item)).toList();

      listCategory.addAll(listFilters);
      listCategory.refresh();
    } catch (e, s) {
      s.printError();
      setLoadRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadCategory() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData resquestData = RequestData(
      query: Configs.getCategory(),
      data: Helper.toMapString(data),
    );

    await _fetchDataCategory(resquestData);
  }

  void handleSelect(int id, FilterType type) {
    switch (type) {
      case FilterType.price:
        for (var item in listPrice) {
          item.isSelect = false;
          if (item.id == id) {
            item.isSelect = !item.isSelect;
          }
        }
        listPrice.refresh();
        break;
      case FilterType.size:
        for (var item in listSizes) {
          if (item.id == id) {
            item.isSelect = !item.isSelect;
          }
        }
        listSizes.refresh();
        break;
      case FilterType.color:
        for (var item in listColors) {
          if (item.id == id) {
            item.isSelect = !item.isSelect;
          }
        }
        listColors.refresh();
        break;
      case FilterType.category:
        for (var item in listCategory) {
          if (item.id == id) {
            item.isSelect = !item.isSelect;
          }
        }
        listCategory.refresh();
        break;
      case FilterType.brand:
        for (var item in listBrand) {
          if (item.id == id) {
            item.isSelect = !item.isSelect;
          }
        }
        listBrand.refresh();
        break;
    }
  }

  void handleDiscard() {
    for (var item in listPrice) {
      item.isSelect = false;
    }
    for (var item in listColors) {
      item.isSelect = false;
    }
    for (var item in listSizes) {
      item.isSelect = false;
    }
    for (var item in listCategory) {
      item.isSelect = false;
    }
    for (var item in listBrand) {
      item.isSelect = false;
    }

    minPriceController.clear();
    maxPriceController.clear();

    // listPrice.first.isSelect = true;
    // listColors.first.isSelect = true;
    // listSizes.first.isSelect = true;
    // listCategory.first.isSelect = true;
    // listBrand.first.isSelect = true;

    listPrice.refresh();
    listColors.refresh();
    listSizes.refresh();
    listCategory.refresh();
    listBrand.refresh();
  }

  Future<void> handleLoadData() async {
    setLoadRes(ApiResponse.loading());
    listColors.clear();
    listSizes.clear();
    listCategory.clear();
    listBrand.clear();

    await Future.wait([
      _handleLoadColor(),
      _handleLoadSize(),
      _handleLoadCategory(),
      _handleLoadBrand(),
    ]);
    setLoadRes(ApiResponse.completed(true));
  }

  Future<void> handleLoadFilter() async {
    listData.clear();
    Get.back();
    setLoadDataRes(ApiResponse.loading());
    await handleLoad(
        // minPrice: minPrice,
        // maxPrice: maxPrice,
        );
  }

  Future<void> initData() async {
    sortValue = listSort.first.title.obs;
    await handleLoad();
    await handleLoadData();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
