import '../../configs/configs.dart';
// import '../../models/data_message.dart';

class ApiEndPoints {
  static String getProduct() {
    return Configs.getProducts;
  }

  // static String accessServer() {
  //   return Configs.accessServer;
  // }

  // static String messageApiEndPoint(DataMessage dataMessage) {
  //   return '${Configs.getMessage}?data=${dataMessage.data}&app_id=${dataMessage.appId}'
  //       '&ask=${dataMessage.ask}&ngay=${dataMessage.ngay}&thang=${dataMessage.thang}'
  //       '&nam=${dataMessage.nam}&gio=${dataMessage.gio}&gioitinh=${dataMessage.gioiTinh}'
  //       '&index=${dataMessage.index}&topic=${dataMessage.topic}'
  //       '&old_msg=${dataMessage.oldMsg}&type=${dataMessage.type}';
  // }

  // static String appIdEndPoint() {
  //   return Configs.getAppId;
  // }
}
