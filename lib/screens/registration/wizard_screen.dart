import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/wizard_info_model.dart';
import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class WizardScreen extends StatefulWidget {
  final WizardType wizardType;

  const WizardScreen({
    super.key,
    required this.wizardType,
  });

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  WizardInfoModel? _info;
  late Future<WizardModel> _future;
  int? _selectedId;

  void _fetchData(String url) {
    _future = ApiService<WizardModel>().build(
      isPublic: true,
      url: url,
      apiType: ApiType.get,
      builder: WizardModel.fromJson,
    );
  }

  WizardInfoModel _getInfo() {
    switch (widget.wizardType) {
      case WizardType.countries:
        return WizardInfoModel(
          apiUrl: ApiUrl.countries,
          headerTitle: context.appLocalization.selectCountry,
          headerBody: null,
          hintText: context.appLocalization.countriesHint,
          nextType: WizardType.universities,
        );
      case WizardType.universities:
        return WizardInfoModel(
          apiUrl: ApiUrl.universities,
          headerTitle: context.appLocalization.selectUniversity,
          headerBody: context.appLocalization.canChangeUniversity,
          hintText: context.appLocalization.searchUniversity,
          nextType: WizardType.colleges,
        );
      case WizardType.colleges:
        return WizardInfoModel(
          apiUrl: ApiUrl.colleges,
          headerTitle: context.appLocalization.selectCollege,
          headerBody: context.appLocalization.canChangeCollege,
          hintText: context.appLocalization.searchCollege,
          nextType: WizardType.specialities,
        );
      case WizardType.specialities:
        return WizardInfoModel(
          apiUrl: ApiUrl.specialties,
          headerTitle: context.appLocalization.selectSpecialization,
          headerBody: context.appLocalization.canChangeSpecialty,
          hintText: context.appLocalization.searchSpecialty,
        );
      default:
        throw 'Wizard Not Defined';
    }
  }

  void _onNext(BuildContext context) {
    if (_info!.nextType == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      context.push(
        WizardScreen(wizardType: _info!.nextType!),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_info == null) {
      _info = _getInfo();
      _fetchData(_info!.apiUrl!);
    }
    return CustomFutureBuilder(
      future: _future,
      onRetry: () {
        setState(() {
          _fetchData(_info!.apiUrl!);
        });
      },
      withBackgroundColor: true,
      onComplete: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  _onNext(context);
                },
                child: Text(context.appLocalization.skip),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: StretchedButton(
              onPressed: _selectedId != null
                  ? () {
                      _onNext(context);
                    }
                  : null,
              child: Text(context.appLocalization.next),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AuthHeader(
                  title: _info!.headerTitle!,
                  body: _info?.headerBody,
                ),
                BaseEditor(
                  hintText: _info!.hintText,
                  prefixIcon: const Center(child: CustomSvg(MyIcons.search)),
                  suffixIconConstraints: const BoxConstraints(
                    maxWidth: 50,
                    maxHeight: 30,
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      final element = snapshot.data!.data![index];
                      return ListTile(
                        tileColor: context.colorPalette.greyDED,
                        onTap: () {
                          setState(() {
                            _selectedId = element.id;
                          });
                        },
                        leading: widget.wizardType == WizardType.countries
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: CustomSvg(
                                    UiHelper.getFlag('JO'),
                                    width: 30,
                                  ),
                                ),
                              )
                            : null,
                        title: Text(element.name!),
                        trailing: _selectedId == element.id
                            ? Icon(
                                Icons.check,
                                color: context.colorScheme.primary,
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
