import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
// import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
// import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
// import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/lang_text.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/repositories/address_repository.dart';
// import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/data_model/city_response.dart';
import 'package:active_ecommerce_flutter/data_model/state_response.dart';
import 'package:active_ecommerce_flutter/data_model/country_response.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/screens/map_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  int? _defaultShippingAddress = 0;
  City? _selectedCity;
  Country? _selectedCountry;
  MyState? _selectedState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildSectionTitle(AppLocalizations.of(context)!.address_ucf,
                //     isRequired: true),
                _buildAddressInputField(context, _addressController,
                    AppLocalizations.of(context)!.enter_address_ucf,
                    maxLines: 1),
                _buildSectionTitle(
                  'الدولة',
                  isRequired: true,
                ),
                _buildCountrySelector(context),
                _buildSectionTitle(AppLocalizations.of(context)!.city_ucf,
                    isRequired: true),
                _buildStateSelector(context),
                // _buildSectionTitle(AppLocalizations.of(context)!.city_ucf,
                // isRequired: true),
                // _buildCitySelector(context),
                // _buildSectionTitle(AppLocalizations.of(context)!.postal_code),
                _buildAddressInputField(context, _postalCodeController,
                    AppLocalizations.of(context)!.enter_postal_code_ucf),
                // _buildSectionTitle(AppLocalizations.of(context)!.phone_ucf),
                _buildAddressInputField(context, _phoneController,
                    AppLocalizations.of(context)!.enter_phone_number),
              ],
            ),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        isRequired ? '$title *' : title,
        style: TextStyle(color: MyTheme.font_grey, fontSize: 12),
      ),
    );
  }

  Widget _buildAddressInputField(
      BuildContext context, TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        child: MyTextFormField(
          controller: controller,
          hintText: hintText,
          maxLines: maxLines,
          keyboardType:
              maxLines == 1 ? TextInputType.text : TextInputType.multiline,
        ),
      ),
    );
  }

  Widget _buildCountrySelector(BuildContext context) {
    return _buildTypeAheadField<Country>(
      context: context,
      controller: _countryController,
      suggestionCallback: (name) async =>
          (await AddressRepository().getCountryList(name: name)).countries,
      onSuggestionSelected: (country) => _onSelectCountry(country, setState),
      hintText: AppLocalizations.of(context)!.enter_country_ucf,
      loadingText: AppLocalizations.of(context)!.loading_countries_ucf,
      noItemsFoundText: AppLocalizations.of(context)!.no_country_available,
    );
  }

  Widget _buildStateSelector(BuildContext context) {
    return _buildTypeAheadField<MyState>(
      context: context,
      controller: _stateController,
      suggestionCallback: (name) async {
        if (_selectedCountry == null) {
          return (await AddressRepository().getStateListByCountry()).states;
        }
        return (await AddressRepository().getStateListByCountry(
                country_id: _selectedCountry!.id, name: name))
            .states;
      },
      onSuggestionSelected: (state) => _onSelectState(state, setState),
      hintText: AppLocalizations.of(context)!.enter_state_ucf,
      loadingText: AppLocalizations.of(context)!.loading_states_ucf,
      noItemsFoundText: AppLocalizations.of(context)!.no_state_available,
    );
  }

  Widget _buildCitySelector(BuildContext context) {
    return _buildTypeAheadField<City>(
      context: context,
      controller: _cityController,
      suggestionCallback: (name) async {
        if (_selectedState == null) {
          return (await AddressRepository().getCityListByState()).cities;
        }
        return (await AddressRepository()
                .getCityListByState(state_id: _selectedState!.id, name: name))
            .cities;
      },
      onSuggestionSelected: (city) => _onSelectCity(city, setState),
      hintText: AppLocalizations.of(context)!.enter_city_ucf,
      loadingText: AppLocalizations.of(context)!.loading_cities_ucf,
      noItemsFoundText: AppLocalizations.of(context)!.no_city_available,
    );
  }

  Widget _buildTypeAheadField<T>({
    required BuildContext context,
    required TextEditingController controller,
    required Future<List<T>> Function(String) suggestionCallback,
    required void Function(T) onSuggestionSelected,
    required String hintText,
    required String loadingText,
    required String noItemsFoundText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 40,
        child: TypeAheadField<T>(
          suggestionsCallback: suggestionCallback,
          loadingBuilder: (context) => _buildLoadingIndicator(loadingText),
          itemBuilder: (context, dynamic item) => ListTile(
            dense: true,
            title: Text(
              (item as dynamic).name,
              style: TextStyle(color: MyTheme.font_grey),
            ),
          ),
          noItemsFoundBuilder: (context) =>
              _buildNoItemsFoundIndicator(noItemsFoundText),
          onSuggestionSelected: onSuggestionSelected,
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            // enabled: false,

            decoration: _buildInputDecoration(context, hintText),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(String text) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: MyTheme.medium_grey),
        ),
      ),
    );
  }

  Widget _buildNoItemsFoundIndicator(String text) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: MyTheme.medium_grey),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context, String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: MyTheme.light_grey,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyTheme.noColor, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyTheme.noColor, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      contentPadding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionButton(
          context,
          text: LangText(context).local.close_ucf,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        const SizedBox(width: 5),
        _buildActionButton(
          context,
          text: LangText(context).local.add_ucf,
          onPressed: () => _onAddressAdd(context),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context,
      {required String text, required VoidCallback onPressed}) {
    return Expanded(
      child: MyProgressButton(
        text: text,
        height: context.getHight(5),
        borderRadius: 8,
        onPressed: onPressed,
      ),
    );
  }

  Future<void> _onAddressAdd(BuildContext context) async {
    final address = _addressController.text;
    final postalCode = _postalCodeController.text;
    final phone = _phoneController.text;

    if (address.isEmpty) {
      ToastComponent.showDialog(AppLocalizations.of(context)!.enter_address_ucf,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    if (_selectedCountry == null) {
      ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_country,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    if (_selectedState == null) {
      ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_state,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    if (_selectedCity == null) {
      ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_city,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    final addressAddResponse = await AddressRepository().getAddressAddResponse(
      address: address,
      country_id: _selectedCountry?.id,
      state_id: _selectedState?.id,
      city_id: _selectedCity?.id,
      postal_code: postalCode,
      phone: phone,
    );

    if (!addressAddResponse.result) {
      ToastComponent.showDialog(addressAddResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    ToastComponent.showDialog(addressAddResponse.message,
        gravity: Toast.center, duration: Toast.lengthLong);
    context.pop();
    // Navigator.of(context, rootNavigator: true).pop();
  }

  void _onSelectCountry(Country country, StateSetter setState) {
    if (_selectedCountry != null && country.id == _selectedCountry!.id) {
      setState(() => _countryController.text = country.name ?? "");
      return;
    }
    _selectedCountry = country;
    _selectedState = null;
    _selectedCity = null;
    setState(() {
      _countryController.text = country.name ?? "";
      _stateController.text = "";
      _cityController.text = "";
    });
  }

  void _onSelectState(MyState state, StateSetter setState) {
    if (_selectedState != null && state.id == _selectedState!.id) {
      setState(() => _stateController.text = state.name ?? "");
      return;
    }
    _selectedState = state;
    _selectedCity = null;
    setState(() {
      _stateController.text = state.name ?? "";
      _cityController.text = "";
    });
  }

  void _onSelectCity(City city, StateSetter setState) {
    if (_selectedCity != null && city.id == _selectedCity!.id) {
      setState(() => _cityController.text = city.name ?? "");
      return;
    }
    _selectedCity = city;
    setState(() => _cityController.text = city.name ?? "");
  }
}
