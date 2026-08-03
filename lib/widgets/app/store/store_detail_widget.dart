import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movegui_admin_panel/providers/store_model_provider.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/app/loading_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_employe_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_info_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_open_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_order_widget.dart';

class StoreDetailWidget extends ConsumerWidget {
  final String storeId;

  const StoreDetailWidget({super.key, required this.storeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Responsive.isDesktop(context)
        ? buidDesktop(context, ref)
        : buildMobile(context, ref);
  }

  Widget buidDesktop(BuildContext context, WidgetRef ref) {
    final storeProvider = ref.watch(StoreModelProvider.storeProvider(storeId));
    return storeProvider.when(
      data: (store) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              /// HEADER IMAGE
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(store.name),
                  background: Image.network(store.imageUrl, fit: BoxFit.cover),
                ),
              ),

              /// CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// DESCRIPTION
                      Text(
                        store.description,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// STORE INFO
                          Expanded(child: StoreInfoWidget(storeModel: store)),

                          const SizedBox(height: 20),

                          /// OPENING HOURS
                          Expanded(
                            child: StoreOpenHoursWidget(
                              weeklyHours: store.weeklyHours,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /*
                  /// SERVICES
                  const PressingServiceDetailsWidget(),

                  const SizedBox(height: 20),
                  */

                      /// EMPLOYEES
                      StoreEmployeWidget(employees: store.staff ?? []),

                      const SizedBox(height: 20),

                      /// ORDERS
                      const StoreOrderWidget(),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },

      error: (error, _) => Text(error.toString()),
      // loading: () => SizedBox(width: 40, height: 40, child: const CircularProgressIndicator(strokeWidth: 3,)),
      loading: () {
        return LoadingWidget();
      },
    );
  }

  Widget buildMobile(BuildContext context, WidgetRef ref) {
    final storeProvider = ref.watch(StoreModelProvider.storeProvider(storeId));
    return storeProvider.when(
      data: (store) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              /// HEADER IMAGE
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(store.name),
                  background: Image.network(store.imageUrl, fit: BoxFit.cover),
                ),
              ),

              /// CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// DESCRIPTION
                      Text(
                        store.description,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 20),

                      /// STORE INFO
                      StoreInfoWidget(storeModel: store),

                      const SizedBox(height: 20),

                      /// OPENING HOURS
                      StoreOpenHoursWidget(weeklyHours: store.weeklyHours),

                      const SizedBox(height: 20),

                      /*
                  /// SERVICES
                  const PressingServiceDetailsWidget(),

                  const SizedBox(height: 20),
                  */

                      /// EMPLOYEES
                      StoreEmployeWidget(employees: store.staff ?? []),

                      const SizedBox(height: 20),

                      /// ORDERS
                      const StoreOrderWidget(),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },

      error: (error, _) => Text(error.toString()),
      // loading: () => SizedBox(width: 40, height: 40, child: const CircularProgressIndicator(strokeWidth: 3,)),
      loading: () {
        return LoadingWidget();
      },
    );
  }
}
