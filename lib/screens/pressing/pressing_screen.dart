
import 'package:movegui_admin_panel/screens/dashboard_screen.dart';
import 'package:movegui_admin_panel/widgets/app/pressing/pressing_dashboard_page.dart';

class PressingScreen extends DashboardScreen {
   PressingScreen({super.key})
         : super(
               pageBuilder: (models, service) => PressingDashboardPage(
                  models: models,
                  service: service,
               ),
            );
}





