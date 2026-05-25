import 'package:movegui_admin_panel/models/model.dart';

abstract class FormController<T extends Model> {

  Future<void> setData(T model);
}