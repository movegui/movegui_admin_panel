import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/button_info.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address/address_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/util/button_widget.dart';

class AddressListWidget extends StatefulWidget {
  final PersonFormController personForm;

  const AddressListWidget({super.key, required this.personForm});

  @override
  State<AddressListWidget> createState() => _AddressListWidgetState();
}

class _AddressListWidgetState extends State<AddressListWidget> {
  late final SeedService _seedService = getIt<SeedService>();

  Future<void> _addAddress() async {
    final addressTestData = _seedService.api.env is EnvDev
        ? await _seedService.getgeneratedAdress()
        : null;

    if (!mounted) return;

    setState(() {
      widget.personForm.addAddress();
      if (addressTestData != null) {
        widget.personForm.adressesForms.last.setData(addressTestData);
      }
    });
  }

  void _removeAddress(int index) {
    setState(() {
      widget.personForm.removeAddress(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final addresses = widget.personForm.adressesForms;

    if (addresses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            //  adressId = formControllers[index].id ?? '';
            return Center(
              child: Container(
                width: Responsive.isDesktop(context)
                    ? size.width * 0.5
                    : double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    AddressWidget(
                      onCommuneChange: (value) {
                        setState(() {
                          addresses[index].selectedMunicipality = value!;
                        });
                      },
                      onAdressTypeChange: (type) {
                        setState(() {
                          addresses[index].selectedType = type!;
                        });
                      },
                      addressForm: addresses[index],
                      onChange: (_) {},
                      defaultId: addresses.first.id!,
                      onDefaultAdressChange: (_) {},
                      onRemoveAdress: () => _removeAddress(index),
                    ),
                    SeparatorWidget(height: WidgetConstants.sepWidget),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: WidgetConstants.sepWidget);
          },
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (addresses.isNotEmpty)
              SizedBox(
                width: 300,
                child: ButtonWidget(
                  onPressed: (item) async {
                    await _addAddress();
                  },
                  buttonItem: ButtonInfo(
                    title: AppLocalizations.of(context)!.btn_add_adress,
                    enabled: true,
                    routeName: '',
                  ),
                  icon: Icon(Icons.add),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
