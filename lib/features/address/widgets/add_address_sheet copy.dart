// import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
// import 'package:active_ecommerce_flutter/core/my_extensions.dart';
// import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
// import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
// import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
// import 'package:active_ecommerce_flutter/custom/btn.dart';
// import 'package:active_ecommerce_flutter/custom/lang_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_flutter/repositories/address_repository.dart';
// import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
// import 'package:active_ecommerce_flutter/data_model/city_response.dart';
// import 'package:active_ecommerce_flutter/data_model/state_response.dart';
// import 'package:active_ecommerce_flutter/data_model/country_response.dart';
// import 'package:active_ecommerce_flutter/custom/toast_component.dart';
// import 'package:flutter/widgets.dart';
// import 'package:toast/toast.dart';
// import 'package:active_ecommerce_flutter/other_config.dart';
// import 'package:active_ecommerce_flutter/screens/map_location.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// class AddAddressSheet extends StatefulWidget {
//   AddAddressSheet({super.key});

//   @override
//   State<AddAddressSheet> createState() => _AddAddressSheetState();
// }

// class _AddAddressSheetState extends State<AddAddressSheet> {
//   TextEditingController _addressController = TextEditingController();

//   TextEditingController _postalCodeController = TextEditingController();

//   TextEditingController _phoneController = TextEditingController();

//   TextEditingController _cityController = TextEditingController();

//   TextEditingController _stateController = TextEditingController();

//   TextEditingController _countryController = TextEditingController();

//   City? _selected_city;

//   Country? _selected_country;

//   MyState? _selected_state;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text("${AppLocalizations.of(context)!.address_ucf} *",
//                       style: TextStyle(
//                           color: MyTheme.dark_font_grey, fontSize: 12)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Container(
//                     // height: 55,
//                     child: MyTextFormField(
//                       controller: _addressController,
//                       // autofocus: false,
//                       hintText: AppLocalizations.of(context)!.enter_address_ucf,
//                       maxLines: null,
//                       keyboardType: TextInputType.multiline,
//                       // decoration: buildAddressInputDecoration(context,
//                       //     AppLocalizations.of(context)!.enter_address_ucf),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text(
//                       app_mobile_language.$ == 'en'
//                           ? "${AppLocalizations.of(context)!.country_ucf} *"
//                           : "الدولة*",
//                       style: TextStyle(color: MyTheme.font_grey, fontSize: 12)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Container(
//                     height: 40,
//                     child: TypeAheadField(
                      
//                       suggestionsCallback: (name) async {
//                         var countryResponse = await AddressRepository()
//                             .getCountryList(name: name);
//                         return countryResponse.countries;
//                       },
//                       loadingBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .loading_countries_ucf,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       itemBuilder: (context, dynamic country) {
//                         //print(suggestion.toString());
//                         return ListTile(
//                           dense: true,
//                           title: Text(
//                             country.name,
//                             style: TextStyle(color: MyTheme.font_grey),
//                           ),
//                         );
//                       },
//                       noItemsFoundBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .no_country_available,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       onSuggestionSelected: (dynamic country) {
//                         onSelectCountryDuringAdd(country, setState);
//                       },
//                       textFieldConfiguration: TextFieldConfiguration(
//                         onTap: () {},
//                         //autofocus: true,
//                         controller: _countryController,
//                         onSubmitted: (txt) {
//                           // keep this blank
//                         },
//                         decoration: buildAddressInputDecoration(context,
//                             AppLocalizations.of(context)!.enter_country_ucf),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text(
//                       app_mobile_language.$ == 'en'
//                           ? "${AppLocalizations.of(context)!.state_ucf} *"
//                           : "الولايه*",
//                       style: TextStyle(color: MyTheme.font_grey, fontSize: 12)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Container(
//                     height: 40,
//                     child: TypeAheadField(
//                       suggestionsCallback: (name) async {
//                         if (_selected_country == null) {
//                           var stateResponse = await AddressRepository()
//                               .getStateListByCountry(); // blank response
//                           return stateResponse.states;
//                         }
//                         var stateResponse = await AddressRepository()
//                             .getStateListByCountry(
//                                 country_id: _selected_country!.id, name: name);
//                         return stateResponse.states;
//                       },
//                       loadingBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .loading_states_ucf,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       itemBuilder: (context, dynamic state) {
//                         //print(suggestion.toString());
//                         return ListTile(
//                           dense: true,
//                           title: Text(
//                             state.name,
//                             style: TextStyle(color: MyTheme.font_grey),
//                           ),
//                         );
//                       },
//                       noItemsFoundBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .no_state_available,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       onSuggestionSelected: (dynamic state) {
//                         onSelectStateDuringAdd(state, setState);
//                       },
//                       textFieldConfiguration: TextFieldConfiguration(
//                         onTap: () {},
//                         //autofocus: true,
//                         controller: _stateController,
//                         onSubmitted: (txt) {
//                           // _searchKey = txt;
//                           // setState(() {});
//                           // _onSearchSubmit();
//                         },
//                         decoration: buildAddressInputDecoration(context,
//                             AppLocalizations.of(context)!.enter_state_ucf),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text(
//                       app_mobile_language.$ == 'en'
//                           ? "${AppLocalizations.of(context)!.city_ucf} *"
//                           : "المحافظة*",
//                       style: TextStyle(color: MyTheme.font_grey, fontSize: 12)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Container(
//                     height: 40,
//                     child: TypeAheadField(
//                       suggestionsCallback: (name) async {
//                         if (_selected_state == null) {
//                           var cityResponse = await AddressRepository()
//                               .getCityListByState(); // blank response
//                           return cityResponse.cities;
//                         }
//                         var cityResponse = await AddressRepository()
//                             .getCityListByState(
//                                 state_id: _selected_state!.id, name: name);
//                         return cityResponse.cities;
//                       },
//                       loadingBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .loading_cities_ucf,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       itemBuilder: (context, dynamic city) {
//                         //print(suggestion.toString());
//                         return ListTile(
//                           dense: true,
//                           title: Text(
//                             city.name,
//                             style: TextStyle(color: MyTheme.font_grey),
//                           ),
//                         );
//                       },
//                       noItemsFoundBuilder: (context) {
//                         return Container(
//                           height: 50,
//                           child: Center(
//                               child: Text(
//                                   AppLocalizations.of(context)!
//                                       .no_city_available,
//                                   style:
//                                       TextStyle(color: MyTheme.medium_grey))),
//                         );
//                       },
//                       onSuggestionSelected: (dynamic city) {
//                         onSelectCityDuringAdd(city, setState);
//                       },
//                       textFieldConfiguration: TextFieldConfiguration(
//                         onTap: () {},
//                         //autofocus: true,
//                         controller: _cityController,
//                         onSubmitted: (txt) {
//                           // keep blank
//                         },
//                         decoration: buildAddressInputDecoration(context,
//                             AppLocalizations.of(context)!.enter_city_ucf),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   // height: 40,
//                   child: MyTextFormField(
//                     hintText: AppLocalizations.of(context)!.postal_code,
//                     controller: _postalCodeController,
//                     // autofocus: false,
//                     // decoration: buildAddressInputDecoration(context,
//                     //     AppLocalizations.of(context)!.enter_postal_code_ucf),
//                   ),
//                 ),
//                 Container(
//                   // height: 40,
//                   child: MyTextFormField(
//                     hintText: AppLocalizations.of(context)!.phone_ucf,
//                     controller: _phoneController,
//                     // autofocus: false,
//                     // decoration: buildAddressInputDecoration(context,
//                     //     AppLocalizations.of(context)!.enter_phone_number),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: MyProgressButton(
//                   text: app_mobile_language.$ == 'en'
//                       ? LangText(context).local.close_ucf
//                       : "الغاء",
//                   height: context.getHight(5),
//                   borderRadius: 8,
//                   onPressed: () {
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                 ),
//               ),
//               SizedBox(
//                 width: 1,
//               ),
//               Expanded(
//                 child: MyProgressButton(
//                   text: app_mobile_language.$ == 'en'
//                       ? LangText(context).local.add_ucf
//                       : "إضافة",
//                   height: context.getHight(5),
//                   borderRadius: 8,
//                   onPressed: () {
//                     onAddressAdd(context);
//                   },
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   onAddressAdd(context) async {
//     var address = _addressController.text.toString();
//     var postal_code = _postalCodeController.text.toString();
//     var phone = _phoneController.text.toString();

//     if (address == "") {
//       ToastComponent.showDialog(AppLocalizations.of(context)!.enter_address_ucf,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       return;
//     }

//     if (_selected_country == null) {
//       ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_country,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       return;
//     }

//     if (_selected_state == null) {
//       ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_state,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       return;
//     }

//     if (_selected_city == null) {
//       ToastComponent.showDialog(AppLocalizations.of(context)!.select_a_city,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       return;
//     }

//     var addressAddResponse = await AddressRepository().getAddressAddResponse(
//         address: address,
//         country_id: _selected_country!.id,
//         state_id: _selected_state!.id,
//         city_id: _selected_city!.id,
//         postal_code: postal_code,
//         phone: phone);

//     if (addressAddResponse.result == false) {
//       ToastComponent.showDialog(addressAddResponse.message,
//           gravity: Toast.center, duration: Toast.lengthLong);
//       return;
//     }

//     ToastComponent.showDialog(addressAddResponse.message,
//         gravity: Toast.center, duration: Toast.lengthLong);

//     Navigator.of(context, rootNavigator: true).pop();
//     // afterAddingAnAddress();
//   }

//   onSelectCityDuringAdd(city, setModalState) {
//     if (_selected_city != null && city.id == _selected_city!.id) {
//       setModalState(() {
//         _cityController.text = city.name;
//       });
//       return;
//     }
//     _selected_city = city;
//     setModalState(() {
//       _cityController.text = city.name;
//     });
//   }

//   onSelectStateDuringAdd(state, setModalState) {
//     if (_selected_state != null && state.id == _selected_state!.id) {
//       setModalState(() {
//         _stateController.text = state.name;
//       });
//       return;
//     }
//     _selected_state = state;
//     _selected_city = null;
//     setState(() {});
//     setModalState(() {
//       _stateController.text = state.name;
//       _cityController.text = "";
//     });
//   }

//   InputDecoration buildAddressInputDecoration(BuildContext context, hintText) {
//     return InputDecoration(
//         filled: true,
//         fillColor: MyTheme.light_grey,
//         hintText: hintText,
//         hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.textfield_grey),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: MyTheme.noColor, width: 0.5),
//           borderRadius: const BorderRadius.all(
//             const Radius.circular(8.0),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: MyTheme.noColor, width: 1.0),
//           borderRadius: const BorderRadius.all(
//             const Radius.circular(8.0),
//           ),
//         ),
//         contentPadding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0));
//   }

//   onSelectCountryDuringAdd(country, setModalState) {
//     if (_selected_country != null && country.id == _selected_country!.id) {
//       setModalState(() {
//         _countryController.text = country.name;
//       });
//       return;
//     }
//     _selected_country = country;
//     _selected_state = null;
//     _selected_city = null;
//     setState(() {});

//     setModalState(() {
//       _countryController.text = country.name;
//       _stateController.text = "";
//       _cityController.text = "";
//     });
//   }
// }
