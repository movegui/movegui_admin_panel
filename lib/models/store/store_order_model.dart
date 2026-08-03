import 'package:intl/intl.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/order_item_model.dart';
import 'package:movegui_admin_panel/models/order_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';


enum OrderStoreType { pressing, restaurant, pharmacy, boutique, gas, courier,}

abstract class StoreOrderModel<
  S extends StoreModel,
  U extends UserModel,
  T extends OrderItemModel
>
    extends OrderModel<U, T> {
  final String storeId;
   final OrderStoreType storeType;
  DateTime? pickupDate;
  DateTime? deliveryDate;
  AdressModel? pickupAdress;
  AdressModel? deliveryAdress;
  bool? pickupOnStore = false;
  bool? deliveryOnStore = false;
  StoreOrderModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.customerId,
    required super.total,
    required super.items,
    required this.storeId,
    required this.deliveryDate,
    required this.pickupDate,
    required this.pickupAdress,
    required this.deliveryAdress,
    required this.storeType,
    required super.status,
    required super.currency,
    required super.orderId
  });

  @override
  Map<String, dynamic> toJson() => {  
    ...super.toJson(),
    'storeId': storeId,
    'pickupDate':  pickupDate == null ? '' : DateFormat('dd MMM yyyy', 'fr').format(pickupDate!),
    'deliveryDate': deliveryDate == null ? '' : DateFormat('dd MMM yyyy', 'fr').format(deliveryDate!),      
    'pickupAdress': pickupAdress?.toJson(),
    'deliveryAdress': deliveryAdress?.toJson(),
    'storeType': storeType.name
  };
}
