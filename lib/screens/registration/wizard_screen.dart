import 'dart:async';

import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/wizard_info_model.dart';
import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/screens/base/app_nav_bar.dart';
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
  final String wizardType;
  final int? id;

  const WizardScreen({
    super.key,
    required this.wizardType,
    this.id,
  });

  @override
  State<WizardScreen> createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  WizardInfoModel? _info;
  late Future<WizardModel> _future;
  int? _selectedId;
  String? _selectedName;
  String countryCode = '';
  Timer? _debounce;
  String _query = '';

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        setState(() {
          _query = '';
        });
      } else {
        setState(() {
          _query = query;
        });
      }
    });
  }

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
          apiUrl: '${ApiUrl.universities}/${widget.id}',
          headerTitle: context.appLocalization.selectUniversity,
          headerBody: context.appLocalization.canChangeUniversity,
          hintText: context.appLocalization.searchUniversity,
          nextType: WizardType.colleges,
        );
      case WizardType.colleges:
        return WizardInfoModel(
          apiUrl: "${ApiUrl.colleges}/${widget.id}",
          headerTitle: context.appLocalization.selectCollege,
          headerBody: context.appLocalization.canChangeCollege,
          hintText: context.appLocalization.searchCollege,
          nextType: WizardType.specialities,
        );
      case WizardType.specialities:
        return WizardInfoModel(
          apiUrl: '${ApiUrl.specialties}/${widget.id}',
          headerTitle: context.appLocalization.selectSpecialization,
          headerBody: context.appLocalization.canChangeSpecialty,
          hintText: context.appLocalization.searchSpecialty,
        );
      default:
        throw 'Wizard Not Defined';
    }
  }

  void saveWizardValue() {
    switch (widget.wizardType) {
      case WizardType.countries:
        context.authProvider.wizardValues.countryId = _selectedId;
        context.authProvider.wizardValues.countryName = _selectedName;
        context.authProvider.wizardValues.wizardType = WizardType.countries;
        context.authProvider.wizardValues.countryCode = countryCode;
        context.authProvider.wizardValues.universityId = null;
        context.authProvider.wizardValues.universityName = null;
        context.authProvider.wizardValues.collegeId = null;
        context.authProvider.wizardValues.collegeName = null;
        context.authProvider.wizardValues.majorId = null;
        context.authProvider.wizardValues.majorName = null;
      case WizardType.universities:
        context.authProvider.wizardValues.universityId = _selectedId;
        context.authProvider.wizardValues.universityName = _selectedName;
        context.authProvider.wizardValues.wizardType = WizardType.universities;
        context.authProvider.wizardValues.collegeId = null;
        context.authProvider.wizardValues.collegeName = null;
        context.authProvider.wizardValues.majorId = null;
        context.authProvider.wizardValues.majorName = null;
      case WizardType.colleges:
        context.authProvider.wizardValues.collegeId = _selectedId;
        context.authProvider.wizardValues.collegeName = _selectedName;
        context.authProvider.wizardValues.wizardType = WizardType.colleges;
        context.authProvider.wizardValues.majorId = null;
        context.authProvider.wizardValues.majorName = null;
      case WizardType.specialities:
        context.authProvider.wizardValues.majorId = _selectedId;
        context.authProvider.wizardValues.majorName = _selectedName;
        context.authProvider.wizardValues.wizardType = WizardType.specialities;
      default:
        break;
    }
  }

  void _onNext(BuildContext context) {
    saveWizardValue();
    if (_info!.nextType == null) {
      UiHelper().addFilter(context, filterModel: context.authProvider.wizardValues, afterAdd: () {
        context.pushAndRemoveUntil(const AppNavBar());
        // Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else {
      context.push(
        WizardScreen(
          wizardType: _info!.nextType!,
          id: _selectedId,
        ),
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
        var data = <WizardData>[];
        if (_query.isEmpty) {
          data = snapshot.data!.data!;
        } else {
          data = List<WizardData>.from(snapshot.data!.data!
              .where(
                (element) {
                  if (context.languageCode == LanguageEnum.arabic) {
                    return element.name!.contains(_query);
                  }
                  return element.name!.toLowerCase().contains(_query.toLowerCase());
                },
              )
              .toList()
              .map((x) => WizardData.fromJson(x.toJson())));
        }
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            actions: [
              if (widget.wizardType != WizardType.countries)
                TextButton(
                  onPressed: () {
                    UiHelper().addFilter(context, filterModel: context.authProvider.wizardValues, afterAdd: () {
                      context.pushAndRemoveUntil(const AppNavBar());
                    });
                    // context.pushAndRemoveUntil(const AppNavBar());
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
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              children: [
                Material(
                  child: ListBody(
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
                        onChanged: _onSearchChanged,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    itemBuilder: (context, index) {
                      final element = data[index];
                      return ListTile(
                        tileColor: context.colorPalette.greyDED,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          setState(() {
                            if (widget.wizardType == WizardType.countries) {
                              countryCode = element.countryCode!;
                            }
                            _selectedId = element.id;
                            _selectedName = element.name!;
                          });
                        },
                        leading: widget.wizardType == WizardType.countries
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: CustomSvg(
                                    UiHelper.getFlag(element.countryCode!),
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
