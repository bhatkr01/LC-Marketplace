import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import '../../main.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import '../../data/api/product/product_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/accounts/accounts_api.dart';

class AddProducts extends ConsumerStatefulWidget {
  // final _formKey = GlobalKey<FormState>();
  const AddProducts({super.key});

  @override
  ConsumerState<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  String token = '';
  bool autoValidate = true;

  bool readOnly = false;

  bool showSegmentedControl = true;

  final _formKey = GlobalKey<FormBuilderState>();

  bool _productAuthorHasError = false;
  bool _productNameHasError = false;
  bool _productPriceHasError = false;
  bool _productDescriptionHasError = false;
  bool _productConditionHasError = false;
  bool _productActionHasError = false;

  var productConditionOptions = ['NEW', 'USED-GOOD', 'USED-ACCEPTABLE'];
  var productActionOptions = ['DONATE', 'SELL'];

  // void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload a Product'),
          // centerTitle:false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: "Luther Marketplace")),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FormBuilder(
              key: _formKey,
              // enabled: false,
              onChanged: () {
                _formKey.currentState!.save();
                // debugPrint(_formKey.currentState!.value.toString());
              },
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: const {
                'product_author': '1',
                'product_name': '',
                'product_price': '0',
                'product_description': '',
                'product_condition': 'NEW',
                'product_action': 'DONATE',
                'gender': 'Male',
              },
              skipDisabled: true,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Upload Product Image'),
                  ),
                  FormBuilderImagePicker(
                    name: 'product_picture',
                    displayCustomType: (obj) =>
                        obj is ApiImage ? obj.imageUrl : obj,
                    // decoration: const InputDecoration(
                    //   labelText: 'Pick Photos',
                    // ),
                    showDecoration: false,
                    maxImages: 1,
                    previewAutoSizeWidth: true,
                    initialValue: const [
                      'https://images.pexels.com/photos/7078045/pexels-photo-7078045.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                    ],
                  ),
                  const SizedBox(height: 15),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'product_author',
                    decoration: InputDecoration(
                      labelText: 'Product Author',
                      suffixIcon: _productAuthorHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _productAuthorHasError = !(_formKey
                                .currentState?.fields['product_author']
                                ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(10000),
                    ]),
                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'product_name',
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      suffixIcon: _productNameHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _productNameHasError = !(_formKey
                                .currentState?.fields['product_name']
                                ?.validate() ??
                            false);
                      });
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(1000)
                    ]),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'product_price',
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      suffixIcon: _productPriceHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _productPriceHasError = !(_formKey
                                .currentState?.fields['product_price']
                                ?.validate() ??
                            false);
                      });
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(10000),
                    ]),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'product_description',
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                      suffixIcon: _productDescriptionHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _productDescriptionHasError = !(_formKey
                                .currentState?.fields['product_name']
                                ?.validate() ??
                            false);
                      });
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(1000)
                    ]),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderDropdown<String>(
                    name: 'product_condition',
                    decoration: InputDecoration(
                      labelText: 'Product Condition',
                      suffix: _productConditionHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                      hintText: 'Select Product Condition',
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: productConditionOptions
                        .map((condition) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: condition,
                              child: Text(condition),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _productConditionHasError = !(_formKey
                                .currentState?.fields['product_condition']
                                ?.validate() ??
                            false);
                      });
                    },
                    valueTransformer: (val) => val?.toString(),
                  ),
                  FormBuilderDropdown<String>(
                    name: 'product_action',
                    decoration: InputDecoration(
                      labelText: 'Product Action',
                      suffix: _productActionHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                      hintText: 'Select Product Action',
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: productActionOptions
                        .map((action) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: action,
                              child: Text(action),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _productActionHasError = !(_formKey
                                .currentState?.fields['product_action']
                                ?.validate() ??
                            false);
                      });
                    },
                    valueTransformer: (val) => val?.toString(),
                  ),
                  FormBuilderDateTimePicker(
                    // FormBuilderTextField(
                    name: 'product_date',
                    initialEntryMode: DatePickerEntryMode.calendar,
                    // initialValue: DateTime.now(),
                    initialValue: DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(DateTime.now())),
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      labelText: 'Product Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _formKey.currentState!.fields['product_date']
                              ?.didChange(null);
                        },
                      ),
                    ),

                    // initialTime: const TimeOfDay(hour: 8, minute: 0),
                    // locale: const Locale.fromSubtags(languageCode: 'fr'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        // debugPrint(_formKey.currentState?.value.toString());

                        final dataInput = Map.of(_formKey.currentState!.value);
                        dataInput['product_date'] = DateFormat("yyyy-MM-dd")
                            .format(dataInput['product_date']);
                        final formData = FormData.fromMap({
                          'product_author': dataInput['product_author'],
                          'product_name': dataInput['product_name'],
                          'product_price': dataInput['product_price'],
                          'product_description':
                              dataInput['product_description'],
                          'product_condtion': dataInput['product_condtion'],
                          'product_action': dataInput['product_action'],
                          'product_date': dataInput['product_date'],
                          'product_picture': await MultipartFile.fromFile(
                              dataInput['product_picture'][0].path,
                              filename: dataInput['product_picture'][0]
                                  .path
                                  .split('/')
                                  .last),
                        });
                        try {
                          await ref
                              .read(addProductsProvider.notifier)
                              .addProducts(formData)
                              .then((_) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                    title: 'Luther Marketplace'),
                              ),
                            );
                          });
                        } catch (e) {
                          if (mounted){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Product upload error"),
                            duration: Duration(milliseconds: 50),
                          ));

                          }
                        }
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}

class ApiImage {
  final String imageUrl;
  final String id;

  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}
