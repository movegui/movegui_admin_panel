import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/providers/auth_provider.dart';
import 'package:movegui_admin_panel/providers/current_user_provider.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';

class PermissionService {
  final Ref ref;

  PermissionService(this.ref);

  bool isSuperAdmin() {
    final appuserProvider = ref.read(authRoles);
    appuserProvider.when(
      data: (user) {
        if (user == null) return false;
        final currentUser = ref
            .watch(CurrentUserProvider.currentUserProvider)
            .currentUser;
        if (currentUser == null) return false;
        if (user.uid != currentUser.id) return false;
        if (user.role != currentUser.role) return false;
        if (user.role == currentUser.role &&
            user.role != UserRole.SuperAdmin.name) {
          return false;
        }
        return true;
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
    return false;
  }

  bool isAdmin() {
    final appuserProvider = ref.watch(authRoles);
    print('user is ');
    appuserProvider.when(
      data: (user) {
        print('user is ${user!.role}');
        final currentUser = ref
            .read(CurrentUserProvider.currentUserProvider)
            .currentUser;
        print('current is ${currentUser!.role}');
        if (user.uid != currentUser.id) return false;
        if (user.role != currentUser.role) return false;
        if (user.role == currentUser.role && user.role != UserRole.Admin.name) {
          return false;
        }
        return true;
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
    return false;
  }

  bool isEmploye() {
    final appuserProvider = ref.read(authRoles);
    appuserProvider.when(
      data: (user) {
        if (user == null) return false;
        final currentUser = ref
            .read(CurrentUserProvider.currentUserProvider)
            .currentUser;
        if (currentUser == null) return false;
        if (user.uid != currentUser.id) return false;
        if (user.role != currentUser.role) return false;
        if (user.role == currentUser.role &&
            user.role != UserRole.Employe.name) {
          return false;
        }
        return true;
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
    return false;
  }

bool isAuthorize() {
  final appUserAsync = ref.read(authRoles);

  return appUserAsync.when(
    data: (user) {
      if (user == null) return false;

      final currentUser =
          ref.read(CurrentUserProvider.currentUserProvider).currentUser;

      if (currentUser == null) return false;
      if (user.uid != currentUser.id) return false;
      if (user.role != currentUser.role) return false;

      const allowedRoles = {
        'Employe',
        'Admin',
        'SuperAdmin',
      };

      return allowedRoles.contains(user.role);
    },
    loading: () => false,
    error: (_, __) => false,
  );
}
}

final permissionProvider = Provider((ref) {
  return PermissionService(ref);
});
