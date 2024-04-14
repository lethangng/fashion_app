import '../bag_models/bag_item.dart';

enum OrderType { delivered, processing, cancelled }

class Order {
  final int id;
  final String idOrder;
  final List<BagItem> listBagItem;
  final String time;
  final int count;
  final double totalPrice;
  final OrderType orderType;

  Order({
    required this.id,
    required this.idOrder,
    required this.listBagItem,
    required this.time,
    required this.count,
    required this.totalPrice,
    required this.orderType,
  });
}
