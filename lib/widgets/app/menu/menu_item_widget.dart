

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/error/message_widget.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/widgets/app/menu/menu_item.dart';


class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.menuItem,
    required this.isCollapsed,
    required this.expandedItems,
    required this.expansionKey,
    required this.onExpanded,
    required this.onNavigate,
    required this.selected,
    this.depth = 0,
  });

  final MenuItem menuItem;
  final bool isCollapsed;
  final Map<String, bool> expandedItems;
  final String expansionKey;
  final void Function(String key, bool value) onExpanded;
  final ValueChanged<MenuItem> onNavigate;
  final String selected;
  final int depth;

  bool get isExpanded => expandedItems[expansionKey] ?? false;
  bool get isSelected => _containsSelected(menuItem);

  bool _containsSelected(MenuItem item) {
    if (selected == item.route ||
        selected.toLowerCase() == item.title.toLowerCase()) {
      return true;
    }
    return item.subMenus?.any(_containsSelected) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.selectedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? const Border(left: BorderSide(color: Colors.white, width: 3))
                : null,
          ),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 12 : 14,
              vertical: 3,
            ),
            leading: Icon(menuItem.icon, color: menuItem.enabled ? Colors.white : Colors.grey),
            title: isCollapsed
                ? null
                : Text(
                    menuItem.title,
                    style:  TextStyle(
                      color: menuItem.enabled ? Colors.white : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            trailing: isCollapsed
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (menuItem.subMenus?.isNotEmpty ?? false)
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.chevron_right,
                          color: menuItem.enabled ? Colors.white : Colors.grey,
                          size: 20,
                        ),
                    ],
                  ),
            onTap: () async {
              if (!menuItem.enabled) {
                await notImplemented(context);
                return;
              }

              if (menuItem.hasChildren && !isCollapsed) {
                onExpanded(expansionKey, !isExpanded);
              } else {
                menuItem.onTap?.call();
                onNavigate(menuItem);
              }
            },
          ),
        ),

        // SUBMENUS
        if (!isCollapsed && menuItem.hasChildren)
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: isExpanded
                ? Column(
                    children: menuItem.subMenus!.map((child) {
                      return Padding(
                        padding: EdgeInsets.only(left: depth == 0 ? 18 : 12),
                        child: MenuItemWidget(
                          menuItem: child,
                          isCollapsed: false,
                          expandedItems: expandedItems,
                          expansionKey: '$expansionKey/${child.title}',
                          onExpanded: onExpanded,
                          onNavigate: onNavigate,
                          selected: selected,
                          depth: depth + 1,
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox.shrink(),
          ),
      ],
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

/*
class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({super.key, required this.title, required this.route});
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(route);
      },
      child: Card(
        // color: Color(0xFF871A1C),
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}

class HoverListTile extends StatefulWidget {
  const HoverListTile({
    super.key,
    required this.icon,
    required this.item,
    this.onTap,
    this.color = AppColors.primary,
  });

  final IconData icon;
  final ButtonInfo item;
  final VoidCallback? onTap;
  final Color? color;

  @override
  State<HoverListTile> createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: widget.item.enabled
              ? isHovered
                    ? AppColors.onPrimary
                    : widget.color
              : AppColors.disabled,
        ),
        title: Text(
          widget.item.title ?? "Shom_GN",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: widget.item.enabled
                ? isHovered
                      ? AppColors.onPrimary
                      : widget.color
                : AppColors.disabled,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        tileColor: widget.item.enabled
            ? isHovered
                  ? AppColors.selectionColor
                  : Colors.transparent
            : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap:
            widget.onTap ??
            () {
              if (widget.item.enabled) {
                context.push(
                  widget.item.routeName ?? RouteConstants.HOME_ROUTE,
                );
              } else {
                notImplemented();
              }
            },
      ),
    );
  }

  Future<dynamic> notImplemented() {
    return MessageWidget.errorMessage(
      context,
      AppLocalizations.of(context)!.deactivate_button_title,
      AppLocalizations.of(context)!.deactivate_button_message,
      Icon(Icons.error, color: AppColors.error),
      FlushbarPosition.TOP,
    );
  }
}
*/
