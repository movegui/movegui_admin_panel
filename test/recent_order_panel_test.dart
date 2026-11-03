import 'package:flutter_test/flutter_test.dart';
import 'package:movegui_admin_panel/widgets/app/dashboard/panel/recent_order_panel.dart';

void main() {
  group('RecentOrderPanel customer display name', () {
    test('uses first and last name from the customer person record', () {
      final customerData = {
        'person': {
          'firstName': 'Jane',
          'lastName': 'Doe',
        },
      };

      expect(resolveCustomerDisplayName(customerData, fallback: 'abc123'), 'Jane Doe');
    });

    test('falls back to the user name when no person object exists', () {
      final customerData = {
        'name': 'Alice Johnson',
      };

      expect(resolveCustomerDisplayName(customerData, fallback: 'abc123'), 'Alice Johnson');
    });
  });
}
