import 'package:movegui_admin_panel/models/model.dart';

abstract class ISeedService<M extends Model> {
  Future<M> generateModel();
}