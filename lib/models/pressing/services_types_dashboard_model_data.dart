import 'package:movegui_admin_panel/models/types_dashboard_model_data.dart';

class ServicesTypesDashboardModelData  extends TypesdahboardModeldata{
  const ServicesTypesDashboardModelData({
    required super.totalTypes,
     required super.totalActiveTypes, 
     required super.totalInactiveTypes
  });

    factory ServicesTypesDashboardModelData.empty() {
    return ServicesTypesDashboardModelData(
      totalTypes: 0,
      totalActiveTypes: 0,
      totalInactiveTypes: 0,
    );
  }

}
