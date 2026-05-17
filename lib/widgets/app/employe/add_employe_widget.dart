import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/screens/auth/register_screen.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';

class AddEmployeWidget extends ConsumerWidget{
  const AddEmployeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   return Scaffold(body: RegisterScreen(role: UserRole.Employe, title: AppLocalizations.of(context)!.register_employe_title,)
   );
  }
}