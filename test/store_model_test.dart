import 'package:flutter_test/flutter_test.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';

void main() {
  group('StoreTypeModel', () {
    test('creates a type from JSON payload', () {
      final type = StoreTypeModel.fromJson({
        'id': 'laundry',
        'name': 'Laundry',
      });

      expect(type.id, 'laundry');
      expect(type.name, 'Laundry');
    });

    test('enum type exposes matching model data', () {
      final type = StoreType.laundry.type;

      expect(type.id, 'laundry');
      expect(type.name, 'Laundry');
    });
  });
}
