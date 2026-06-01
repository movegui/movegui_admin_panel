import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
return  Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                //  color: AppColors.backgroundColor,
                  child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.selectionColor),
                ),
                SizedBox(height: 12),
                Text(AppLocalizations.of(context)!.is_loding_text),
              ],
            ),
          
        );

    /*
    return Container(
      width: 40,
      height: 40,
      color: AppColors.backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.selectionColor),
      ),
    );
    */
  }
}
