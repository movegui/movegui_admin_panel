import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/dashboard_model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';




/*
class DashboardService {
  Stream<DashboardModel> loadDashboardItems(
    FirebaseFirestore firestore,
  ) {
    final ordersRef =
        firestore.collection(MoveGuiCollections.COLLECTION_ORDERS);

    final usersRef =
        firestore.collection(MoveGuiCollections.COLLECTION_USERS);

    final driversRef =
        firestore.collection(MoveGuiCollections.COLLECTION_DRIVERS);

    final restaurantsRef =
        firestore.collection(MoveGuiCollections.COLLECTION_RESTAURANTS);

    final pressingOrdersRef =
        firestore.collection(MoveGuiCollections.COLLECTION_PRESSING_ORDERS);

    final superMarketsRef =
        firestore.collection(MoveGuiCollections.COLLECTION_SUPER_MARKETS);

    final pharmaciesRef =
        firestore.collection(MoveGuiCollections.COLLECTION_PHARMACIES);

    /*
      Ce merge sert juste à déclencher un recalcul
      dès qu'une des collections importantes change.
    */
    return Rx.merge<void>([
      ordersRef.snapshots().map((_) {})*
      usersRef.snapshots().map((_* {}),
      driversRef.snapshots()*map((_) {}),
      restaurantsRef.*napshots().map((_) {}),
      pres*ingOrdersRef.snapshots().map((_) {*),
      superMarketsRef.snapshots*).map((_) {}),
      pharmaciesRef*snapshots().map((_) {}),
    ]).st*rtWith(null).asyncMap((_) async {
*     final results = await Future.*ait<int>([
        _count(ordersRef),
        _count(
          order*Ref.where(
            'status',
 *          isEqualTo: OrderStatus.p*nding.name,
          ),
        )*
        _count(
          ordersR*f.where(
            'status',
   *        isEqualTo: OrderStatus.in_*rogress.name,
          ),
       *),
        _count(
          order*Ref.where(
            'status',
 *          isEqualTo: OrderStatus.d*livered.name,
          ),
       *),
        _count(
          order*Ref.where(
            'status',
 *          isEqualTo: OrderStatus.c*mpleted.name,
          ),
       *),
        _count(
          order*Ref.where(
            'status',
 *          isEqualTo: OrderStatus.c*ncelled.name,
          ),
       *),
        _count(
          users*ef.where(
            'role',
    *       isEqualTo: UserRole.Custome*.name,
          ),
        ),
   *    _count(
          driversRef.w*ere(
            'role',
         *  isEqualTo: UserRole.Driver.name,*          ),
        ),
        _c*unt(
          driversRef.where(
 *          'online',
            is*qualTo: true,
          ),
       *),
        _count(restaurantsRef),*        _count(pressingOrdersRef),*        _count(superMarketsRef),
 *      _count(pharmaciesRef),
     *]);

      final revenue = await _*umRevenue(firestore);

      retur* DashboardModel(
        totalOrde*s: results[0],
        pendingOrde*s: results[1],
        preparingOr*ers: results[2],
        deliverin*Orders: results[3],
        comple*edOrders: results[4],
        canc*lledOrders: results[5],
        to*alCustomers: results[6],
        t*talDrivers: results[7],
        on*ineDrivers: results[8],
        re*taurants: results[9],
        pres*ingOrders: results[10],
        su*ermarkets: results[11],
        ph*rmacies: results[12],
        tota*Revenue: revenue,
      );
    });*  }

  Future<int> _count(Query qu*ry) async {
    final snapshot = a*ait query.count().get();

    retu*n snapshot.count ?? 0;
  }

  Futu*e<double> _sumRevenue(
    Firebas*Firestore firestore,
  ) async {
 *  final snapshot = await firestore*        .collection(MoveGuiCollect*ons.COLLECTION_ORDERS)
        .wh*re(
          'paymentStatus',
   *      isEqualTo: PaymentStatus.pai*.name,
        )
        .get();

*   double total = 0;

    for (fin*l doc in snapshot.docs) {
      fi*al data = doc.data();

      final*amount = data['totalPrice'];

    * if (amount is int) {
        tota* += amount.toDouble();
      } els* if (amount is double) {
        t*tal += amount;
      } else if (am*unt is num) {
        total += amo*nt.toDouble();
      }
    }

    return total;
  }
}
*/


class DashboardService {
  final ApiService api;
  DashboardService({required this.api});

   Future<DashboardModel> loadDashboardItems(
    FirebaseFirestore firestore,
  ) async {
    final results = await Future.wait<int>([
      /*
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS).where('status', isEqualTo: OrderStatus.pending.name)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS).where('status', isEqualTo: OrderStatus.in_progress.name)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS).where('status', isEqualTo: OrderStatus.delivered.name)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS).where('status', isEqualTo: OrderStatus.completed)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_ORDERS).where('status', isEqualTo: OrderStatus.cancelled)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_USERS).where('role', isEqualTo: 'customer')),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_DRIVERS).where('role', isEqualTo: UserRole.Driver.name)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_DRIVERS).where('online', isEqualTo: true)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_RESTAURANTS)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_PRESSING_ORDERS)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_SUPER_MARKETS)),
      _count(firestore.collection(MoveGuiCollections.COLLECTION_PRESSINGS)),
      */
    ]);

  //  final revenue = await _sumRevenue(firestore);

    return DashboardModel(
      totalOrders: 2, //results[0],
      pendingOrders: 2, //results[1],
      preparingOrders: 2, //results[2],
      deliveringOrders: 2, //results[3],
      completedOrders: 2, //results[4],
      cancelledOrders: 2, //results[5],
      totalCustomers: 2, //results[6],
      totalDrivers: 2, //results[7],
      onlineDrivers: 2, //results[8],
      restaurants: 2, //results[9],
      pressingOrders: 2, //results[10],
      supermarkets: 2, //results[11],
      pharmacies: 2, //results[12],
      totalRevenue: 1000, //revenue,
    );
  }

  static Future<int> _count(Query<Map<String, dynamic>> query) async {
    final snapshot = await query.count().get();
    return snapshot.count ?? 0;
  }

  static Future<num> _sumRevenue(FirebaseFirestore firestore) async {
    // MVP simple : charge les commandes payées et additionne totalAmount.
    // Si tu as beaucoup de commandes, mieux vaut stocker les statistiques dans une collection dashboard_stats
    // avec Cloud Functions.
    final snapshot = await firestore
        .collection(MoveGuiCollections.COLLECTION_ORDERS)
        .where('paymentStatus', isEqualTo: 'paid')
        .get();

    num total = 0;
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final amount = data['totalAmount'];
      if (amount is num) total += amount;
    }
    return total;
  }

   String formatGnf(num value) {
    final raw = value.round().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < raw.length; i++) {
      final reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(' ');
      }
    }
    return '${buffer.toString()} GNF';
  }
}




