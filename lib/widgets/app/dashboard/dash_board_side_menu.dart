import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/appbar_title_provider.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/providers/dark_theme_provider.dart';
import 'package:movegui_admin_panel/providers/dashboard_menu_provider.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/menu_tile.dart';
import 'package:movegui_admin_panel/widgets/app/menu/menu_item.dart';
import 'package:movegui_admin_panel/widgets/app/menu/menu_item_widget.dart';
import 'package:movegui_admin_panel/widgets/util/profile_menu_title.dart';
import 'package:movegui_admin_panel/widgets/web/app_title_widget.dart';
import 'package:movegui_admin_panel/widgets/web/menu_section_title.dart';

class DashBoardSideMenu extends ConsumerWidget {
  DashBoardSideMenu({super.key});
  final userService = getIt<UserService>();

  void onPress(BuildContext context, WidgetRef ref, String routeName) {
    context.go(routeName);
  }

  Future<UserModel?> loadCurrentUser(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProviderState).user;
    if (currentUser != null) {
      return Future.value(currentUser);
    }
    return userService.getCurrentUser(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authRoles);
    final theme = ref.read(themeProvider).getTheme();
    final themeState = ref.read(themeProvider);

    return FutureBuilder<UserModel?>(
      future: loadCurrentUser(context, ref),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userSnapshot.hasError) {
          return Text(
            userSnapshot.error.toString(),
            style: TextStyle(color: AppColors.error),
          );
        }

        final currentUser = userSnapshot.data;

        return authState.when(
          data: (user) {
            if (user == null) {
              return Text(
                AppLocalizations.of(context)!.error_authorization,
                style: TextStyle(color: AppColors.error),
              );
            }

            if (currentUser == null ||
                user.uid != currentUser.id ||
                user.role != currentUser.role.name) {
              return Text(
                AppLocalizations.of(context)!.error_authorization,
                style: TextStyle(color: AppColors.error),
              );
            }

            final allowedRoles = {
              UserRole.Employe.name,
              UserRole.Admin.name,
              UserRole.SuperAdmin.name,
              UserRole.Manager.name,
            };

            if (!allowedRoles.contains(user.role)) {
              return Text(
                AppLocalizations.of(context)!.error_authorization,
                style: TextStyle(color: AppColors.error),
              );
            }

            return Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: MoveGuiDrawer(
                role: currentUser.role,
                onNavigate: (route) {
                  if (route.startsWith('/')) context.go(route);
                },
                onLogout: () {
                  // ref.read(authRoles.notifier).logout();
                  FirebaseAuth.instance.signOut();
                  context.go(RouteConstants.LOGIN_ROUTE);
                },
                onThemeChanged: (value) {
                  themeState.setDarkTheme(themeValue: value);
                },
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text(e.toString()),
        );
      },
    );
  }

  bool isSuperAdmin(UserModel currentUser, AppUser user) {
    return currentUser.role == UserRole.SuperAdmin &&
        user.role == UserRole.SuperAdmin.name;
  }

  bool isAdmin(UserModel currentUser, AppUser user) {
    return {
          UserRole.Admin.name,
          UserRole.SuperAdmin.name,
        }.contains(user.role) &&
        {UserRole.Admin, UserRole.SuperAdmin}.contains(currentUser.role);
  }

  bool isManager(UserModel currentUser, AppUser user) {
    return {
          UserRole.Admin.name,
          UserRole.SuperAdmin.name,
          UserRole.Manager.name,
        }.contains(user.role) &&
        {
          UserRole.Admin,
          UserRole.SuperAdmin,
          UserRole.Manager,
        }.contains(currentUser.role);
  }

  bool isEmployee(UserModel currentUser, AppUser user) {
    return {
          UserRole.Admin.name,
          UserRole.SuperAdmin.name,
          UserRole.Employe.name,
        }.contains(user.role) &&
        {
          UserRole.Admin,
          UserRole.SuperAdmin,
          UserRole.Employe,
        }.contains(currentUser.role);
  }

  bool isDriver(UserModel currentUser, AppUser user) {
    return {
          UserRole.Admin.name,
          UserRole.SuperAdmin.name,
          UserRole.Employe.name,
          UserRole.Driver.name,
        }.contains(user.role) &&
        {
          UserRole.Admin,
          UserRole.SuperAdmin,
          UserRole.Employe,
          UserRole.Driver,
        }.contains(currentUser.role);
  }
}

class MoveGuiDrawer extends ConsumerWidget {
  final UserRole role;
  final Function(String) onNavigate;
  final VoidCallback? onLogout;
  final ValueChanged<bool>? onThemeChanged;

  const MoveGuiDrawer({
    super.key,
    required this.role,
    required this.onNavigate,
    this.onLogout,
    this.onThemeChanged,
  });

  List<MenuItem> _allMenus(AppLocalizations l10n) => [
    MenuItem(
      title: l10n.dashboard_menu_overview,
      icon: Icons.dashboard_outlined,
      route: RouteConstants.HOME_ROUTE,
      enabled: true,
    ),

    MenuItem(
      title: l10n.dashboard_menu_marketplace,
      icon: Icons.store_outlined,
      enabled: true,
      subMenus: [
        MenuItem(
          title: l10n.dashboard_menu_establishments,
          icon: Icons.business_outlined,
          enabled: true,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_all_establishments,
              icon: Icons.list,
              route: '/establishments',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_pressings,
              icon: Icons.local_laundry_service,
              route: RouteConstants.PRESSING_ROUTE,
              enabled: true,
              subMenus: [
                MenuItem(
                  title: l10n.dashboard_menu_all_pressings,
                  icon: Icons.list,
                  route: RouteConstants.PRESSING_ALL_ROUTE,
                  enabled: true,
                ),
                MenuItem(
                  title: l10n.dashboard_menu_add_pressing,
                  icon: Icons.add,
                  route: RouteConstants.PRESSING_ADD_ROUTE,
                  enabled: true,
                ),

                MenuItem(
                  title: l10n.dashboard_menu_service_types,
                  icon: Icons.design_services_outlined,
                  route: RouteConstants.PRESSING_TYPE_SERVICE_ROUTE,
                  enabled: true,
                ),
                MenuItem(
                  title: l10n.dashboard_menu_orders,
                  icon: Icons.receipt_long_outlined,
                  route: RouteConstants.ORDERS_ROUTE,
                  enabled: false,
                ),
              ],
            ),
            MenuItem(
              title: l10n.dashboard_menu_pharmacies,
              icon: Icons.local_pharmacy_outlined,
              route: '/establishments/pharmacies',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_stores,
              icon: Icons.shopping_bag_outlined,
              route: '/establishments/stores',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_pending,
              icon: Icons.pending_outlined,
              route: '/establishments/pending',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_suspended,
              icon: Icons.block_outlined,
              route: '/establishments/suspended',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_users,
          icon: Icons.people_outline,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_all_users,
              icon: Icons.people,
              route: '/users',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_customers,
              icon: Icons.person_outline,
              route: '/users/customers',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_owners,
              icon: Icons.business_center_outlined,
              route: '/users/owners',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_employees,
              icon: Icons.badge_outlined,
              route: '/users/employees',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_couriers,
              icon: Icons.delivery_dining,
              route: '/users/couriers',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_blocked_users,
              icon: Icons.person_off_outlined,
              route: '/users/blocked',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_orders,
          icon: Icons.receipt_long_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_all_orders,
              icon: Icons.list_alt,
              route: '/orders',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_new_orders,
              icon: Icons.fiber_new,
              route: '/orders/new',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_in_progress,
              icon: Icons.autorenew,
              route: '/orders/processing',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_completed,
              icon: Icons.check_circle_outline,
              route: '/orders/completed',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_cancelled,
              icon: Icons.cancel_outlined,
              route: '/orders/cancelled',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_disputes,
              icon: Icons.report_problem_outlined,
              route: '/orders/disputes',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_delivery_logistics,
          icon: Icons.local_shipping_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_couriers,
              icon: Icons.delivery_dining,
              route: '/logistics/couriers',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_missions,
              icon: Icons.assignment_outlined,
              route: '/logistics/missions',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_active_deliveries,
              icon: Icons.route_outlined,
              route: '/logistics/active',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_delivery_zones,
              icon: Icons.map_outlined,
              route: '/logistics/zones',
              enabled: false,
            ),
          ],
        ),
      ],
    ),

    // Gestion commerciale
    MenuItem(
      title: l10n.dashboard_menu_business_management,
      icon: Icons.business_center_outlined,
      enabled: false,
      subMenus: [
        MenuItem(
          title: l10n.dashboard_menu_finances,
          icon: Icons.account_balance_wallet_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_financial_overview,
              icon: Icons.analytics_outlined,
              route: '/finance',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_transactions,
              icon: Icons.swap_horiz,
              route: '/finance/transactions',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_payments,
              icon: Icons.payment_outlined,
              route: '/finance/payments',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_commissions,
              icon: Icons.percent,
              route: '/finance/commissions',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_refunds,
              icon: Icons.money_off_outlined,
              route: '/finance/refunds',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_subscriptions_billing,
          icon: Icons.card_membership_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_general_overview,
              icon: Icons.dashboard_outlined,
              route: '/subscriptions',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_offers,
              icon: Icons.sell_outlined,
              route: '/subscriptions/plans',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_active_subscriptions,
              icon: Icons.check_circle_outline,
              route: '/subscriptions/active',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_expired,
              icon: Icons.event_busy_outlined,
              route: '/subscriptions/expired',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_invoices,
              icon: Icons.receipt_outlined,
              route: '/subscriptions/invoices',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_catalog_categories,
          icon: Icons.category_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_business_types,
              icon: Icons.storefront_outlined,
              route: '/catalog/business-types',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_categories,
              icon: Icons.category_outlined,
              route: '/catalog/categories',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_services,
              icon: Icons.design_services_outlined,
              route: '/catalog/services',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_product_categories,
              icon: Icons.inventory_2_outlined,
              route: '/catalog/product-categories',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_products,
              icon: Icons.shopping_bag_outlined,
              route: '/catalog/products',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_promotions_loyalty,
          icon: Icons.loyalty_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_promo_codes,
              icon: Icons.discount_outlined,
              route: '/promotions/codes',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_campaigns,
              icon: Icons.campaign_outlined,
              route: '/promotions/campaigns',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_loyalty_program,
              icon: Icons.stars_outlined,
              route: '/promotions/loyalty',
              enabled: false,
            ),
          ],
        ),
      ],
    ),

    // Pilotage
    MenuItem(
      title: l10n.dashboard_menu_steering,
      icon: Icons.insights_outlined,
      enabled: false,
      subMenus: [
        MenuItem(
          title: l10n.dashboard_menu_analytics_reports,
          icon: Icons.bar_chart_outlined,
          route: '/analytics',
          enabled: false,
        ),
        MenuItem(
          title: l10n.dashboard_menu_geographic_areas,
          icon: Icons.public_outlined,
          route: '/geography',
          enabled: false,
        ),
        MenuItem(
          title: l10n.dashboard_menu_support_claims,
          icon: Icons.support_agent_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_tickets,
              icon: Icons.confirmation_number_outlined,
              route: '/support/tickets',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_claims,
              icon: Icons.report_outlined,
              route: '/support/claims',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_refund_requests,
              icon: Icons.money_off_outlined,
              route: '/support/refunds',
              enabled: false,
            ),
          ],
        ),
        MenuItem(
          title: l10n.dashboard_menu_notifications,
          icon: Icons.notifications_none_outlined,
          enabled: false,
          subMenus: [
            MenuItem(
              title: l10n.dashboard_menu_send_notification,
              icon: Icons.send_outlined,
              route: '/notifications/send',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_templates,
              icon: Icons.description_outlined,
              route: '/notifications/templates',
              enabled: false,
            ),
            MenuItem(
              title: l10n.dashboard_menu_history,
              icon: Icons.history,
              route: '/notifications/history',
              enabled: false,
            ),
          ],
        ),
      ],
    ),

    // Administration
    MenuItem(
      title: l10n.dashboard_menu_administration,
      icon: Icons.admin_panel_settings_outlined,
      enabled: false,
      subMenus: [
        MenuItem(
          title: l10n.dashboard_menu_administrators,
          icon: Icons.manage_accounts_outlined,
          route: '/admin/users',
          enabled: false,
        ),
        MenuItem(
          title: l10n.dashboard_menu_roles_permissions,
          icon: Icons.security_outlined,
          route: '/admin/roles',
          enabled: false,
        ),
        MenuItem(
          title: l10n.dashboard_menu_activity_log,
          icon: Icons.history_outlined,
          route: '/admin/activity',
          enabled: false,
        ),
        MenuItem(
          title: l10n.dashboard_menu_platform_settings,
          icon: Icons.settings_outlined,
          route: '/settings',
          enabled: false,
        ),
      ],
    ),
  ];

  List<MenuItem> _menus(AppLocalizations l10n) =>
      _filterMenus(_allMenus(l10n), _allowedRoutesForRole(role));

  Set<String>? _allowedRoutesForRole(UserRole role) {
    switch (role) {
      case UserRole.Admin:
      case UserRole.SuperAdmin:
        return null;
      case UserRole.Owner:
      case UserRole.Manager:
        return {
          RouteConstants.HOME_ROUTE,
          RouteConstants.PRESSING_ROUTE,
          RouteConstants.PRESSING_ALL_ROUTE,
          //   RouteConstants.PRESSING_ADD_ROUTE,
          RouteConstants.PRESSING_TYPE_SERVICE_ROUTE,
          RouteConstants.ORDERS_ROUTE,
        };
      case UserRole.Employe:
        return {
          RouteConstants.HOME_ROUTE,
          RouteConstants.PRESSING_ROUTE,
          RouteConstants.PRESSING_ALL_ROUTE,
          //    RouteConstants.PRESSING_TYPE_SERVICE_ROUTE,
          RouteConstants.ORDERS_ROUTE,
        };
      case UserRole.User:
      case UserRole.Guest:
      case UserRole.Support:
      case UserRole.Driver:
        return {};
    }
  }

  List<MenuItem> _filterMenus(
    List<MenuItem> items,
    Set<String>? allowedRoutes,
  ) {
    return items
        .map((item) {
          final children = _filterMenus(item.subMenus ?? [], allowedRoutes);
          final routeAllowed =
              item.enabled &&
              item.route != null &&
              (allowedRoutes == null || allowedRoutes.contains(item.route));
          final hasVisibleChildren = children.isNotEmpty;

          if (!item.enabled || (!routeAllowed && !hasVisibleChildren)) {
            return null;
          }

          return MenuItem(
            title: item.title,
            icon: item.icon,
            route: routeAllowed ? item.route : null,
            onTap: item.onTap,
            enabled: routeAllowed || hasVisibleChildren,
            subMenus: children,
          );
        })
        .whereType<MenuItem>()
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuState = ref.watch(dashboardMenuProvider);
    final menuController = ref.read(dashboardMenuProvider);
    final l10n = AppLocalizations.of(context)!;
    final menuItems = _menus(l10n);
    final width = menuState.collapsed ? 82.0 : 280.0;
    final currentUser = ref.watch(userProviderState).user;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.burgundy,
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(3, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER
          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTitleWidget(isCollapse: menuState.collapsed),
          ),
          const Divider(color: Color(0xFFAD5559), height: 1),
          const SizedBox(height: WidgetConstants.sepWidget),
          if (!menuState.collapsed)
            MenuSectionTitle(
              title: AppLocalizations.of(context)!.menu_principal.toUpperCase(),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: menuItems.map((menu) {
                return MenuItemWidget(
                  menuItem: menu,
                  isCollapsed: menuState.collapsed,
                  expandedItems: menuState.expandedItems,
                  expansionKey: menu.title,
                  onExpanded: (key, value) {
                    menuController.setExpanded(key, value);
                  },
                  onNavigate: (menuItem) {
                    final route = menuItem.route;
                    menuController.select(route ?? menuItem.title);
                    if (route != null) onNavigate(route);
                  },
                  selected: menuState.selected,
                );
              }).toList(),
            ),
          ),

          // PREFERENCES
          if (!menuState.collapsed)
            MenuSectionTitle(
              title: AppLocalizations.of(context)!.menu_preferency,
            ),
          _preferenceItem(
            collapsed: menuState.collapsed,
            darkMode: menuState.darkMode,
            onChanged: (value) {
              menuController.setDarkMode(value);
              onThemeChanged?.call(value);
            },
          ),

          const Divider(
            color: Color(0xFFAD5559),
            height: 24,
            indent: 16,
            endIndent: 16,
          ),

          // USER PROFILE
          _profile(collapsed: menuState.collapsed, currentUser: currentUser!),

          const SizedBox(height: 12),

          // COLLAPSE BUTTON
          IconButton(
            onPressed: () => menuController.setCollapsed(!menuState.collapsed),
            icon: Icon(
              menuState.collapsed
                  ? Icons.keyboard_double_arrow_right
                  : Icons.keyboard_double_arrow_left,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _preferenceItem({
    required bool collapsed,
    required bool darkMode,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(
        darkMode ? Icons.dark_mode : Icons.light_mode,
        color: Colors.white,
      ),
      title: collapsed
          ? null
          : const Text(
              'Mode sombre',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
      trailing: collapsed
          ? null
          : Switch(
              value: darkMode,
              activeColor: Colors.white,
              activeTrackColor: AppColors.selectedColor,
              onChanged: onChanged,
            ),
    );
  }

  Widget _profile({required bool collapsed, required UserModel currentUser,}) {
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFF5DCDD),
          child: Icon(Icons.person, color: AppColors.burgundy),
        ),
        title: collapsed
            ? null
            :  Text(
                (currentUser.personModel?.name.isNotEmpty ?? false)
                  ? currentUser.personModel!.name
                  : currentUser.name.isNotEmpty
                    ? currentUser.name
                    : currentUser.role.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
        subtitle: collapsed
            ? null
            :  Text(
                currentUser.personModel?.email ?? currentUser.personModel?.phone ?? 'Email non disponible',
                style: TextStyle(color: Color(0xFFE8BFC1), fontSize: 10),
              ),
        trailing: collapsed
            ? null
            : IconButton(
                onPressed: onLogout,
                icon: const Icon(Icons.logout, color: Colors.white, size: 19),
              ),
      ),
    );
  }
}
