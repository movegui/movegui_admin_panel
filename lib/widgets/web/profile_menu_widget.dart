import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/services/assets_manager.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/widgets/util/profile_menu_title.dart';

class ProfileMenuWidget extends ConsumerWidget {
  final UserModel? user;

  const ProfileMenuWidget({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final name = user?.personModel?.name.trim();
    return PopupMenuButton<String>(
      tooltip: '',
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) async {
        switch (value) {
          case 'profile':
            context.go(RouteConstants.PROFILE_ROUTE);
            break;

          case 'orders':
            context.go(RouteConstants.ORDERS_ROUTE);
            break;

          case 'deliveries':
            context.go(RouteConstants.DELIVERIES_ROUTE);
            break;

          case 'settings':
            context.go(RouteConstants.SETTINGS_ROUTE);
            break;

          case 'logout':
            await FirebaseAuth.instance.signOut();
            ref.read(userProviderState).setUser(null);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               (name?.isNotEmpty ?? false) ? name! : 'No Name',
                style: theme.textTheme.displayMedium!.copyWith(fontSize: 28),
              ),
              if (user?.personModel?.email != null)
                Text(
                  user?.personModel?.email ?? 'Pas d\'Email',
                  style: theme.textTheme.displaySmall!.copyWith(fontSize: 18),
                ),
            ],
          ),
        ),
        const PopupMenuDivider(),

        PopupMenuItem(
          value: 'profile',
          child: SizedBox(
            width: 210,
            child: ProfileMenuTitle(
              icon: Icon(Icons.person_outline),
              title: AppLocalizations.of(context)!.profile_title,
              onTap: () => notImplemented(context),
              enabled: false,
            ),
          ),
        ),

        PopupMenuItem(
          value: 'orders',
          child: ProfileMenuTitle(
            icon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), size: 24),
            title: AppLocalizations.of(context)!.profile_menu_orders,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        PopupMenuItem(
          value: 'deliveries',
          child: ProfileMenuTitle(
            icon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), size: 24),
            title: AppLocalizations.of(context)!.delivery_title,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        PopupMenuItem(
          value: 'settings',
          child: ProfileMenuTitle(
            icon: Icon(Icons.settings_outlined),
            title: "settings", // AppLocalizations.of(context)!.settings_title,
            onTap: () => notImplemented(context),
            enabled: false,
          ),
        ),

        const PopupMenuDivider(),

        PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              AppLocalizations.of(context)!.profile_menu_logout,
              style: TextStyle(color: Colors.red),
            ),
            contentPadding: EdgeInsets.zero,
            onTap: () async => {await FirebaseAuth.instance.signOut()},
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: user?.personModel?.profileImageUrl != null
                  ? NetworkImage(user!.personModel!.profileImageUrl!)
                  : null,
              child: user?.personModel?.profileImageUrl == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 10),

            Text(
              user?.name ?? 'Compte',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.onPrimary,
                fontSize: 18,
              ),
            ),

            const SizedBox(width: 4),

            const Icon(Icons.keyboard_arrow_down, color: AppColors.onPrimary),
          ],
        ),
      ),
    );
  }

  Future<dynamic> notImplemented(BuildContext context) {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
