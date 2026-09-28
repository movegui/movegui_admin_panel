import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/providers/providers.dart';
import 'package:movegui_admin_panel/widgets/subtitle_text.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';
import 'package:movegui_admin_panel/widgets/web/profile_menu_widget.dart';


class WebAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  WebAppBar({super.key, required this.title});
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final currentUser = ref.watch(userProviderState).user;
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                onPressed: (item) async {
                  context.push(RouteConstants.HOME_ROUTE);
                },
                buttonItem: ButtonInfo(title: AppConstants.name, enabled: true),
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/icons/movegui.jpg',
                    width: 24,
                    height: 24,
                   // color: Theme.of(context).colorScheme.onPrimary,
                    
                  ),
                ),
                textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.onPrimary),
              ),
            ),
      
            const SizedBox(width: WidgetConstants.sepWidgetWidth),
            const Icon(Icons.location_on),
            //   CurrentPositionWidget(),
            const SizedBox(width: WidgetConstants.sepWidgetWidth),
      
            Expanded(child: Center(child: SubtitleTextWidget(label: title, color: AppColors.onPrimary, fontSize: 32,))),
      /*
            Expanded(
              child: AppSearchWidget(
                controller: controller,
                focusNode: focusNode,
              ),
            ),
            */
      
            const SizedBox(width: WidgetConstants.sepWidgetWidth),
            if (user != null)
              ProfileMenuWidget(user: currentUser)
            else
              showConnectionBtn(context),
          ],
        ),
      ),
    );
  }

  Widget showConnectionBtn(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.LOGIN_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_login_web,
              enabled: true,
            ),
            icon: Icon(Icons.login),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonWidget(
            onPressed: (item) async {
              context.push(RouteConstants.REGISTER_ROUTE);
            },
            buttonItem: ButtonInfo(
              title: AppLocalizations.of(context)!.label_registration,
              enabled: false,
            ),
            icon: Icon(Icons.person),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
