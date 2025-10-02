part of '../index.dart';

class InsertStockOpnameScreen extends StatefulWidget {
  const InsertStockOpnameScreen({super.key});

  @override
  State<InsertStockOpnameScreen> createState() => _InsertStockOpnameScreenState();
}

class _InsertStockOpnameScreenState extends State<InsertStockOpnameScreen> {
  final formkey = GlobalKey<FormState>();
  var valueCodeCutOff, valueOidCutOff, valueLocationId, valueLocationName, unit_measure_code;
  TextEditingController controllerWarehouseCutOff = TextEditingController();
  TextEditingController controllerDateCutOff = TextEditingController();
  TextEditingController controllerCodeCutOff = TextEditingController();
  TextEditingController controllerLocationCode = TextEditingController();
  TextEditingController controllerPalletId = TextEditingController();
  TextEditingController controllerItemDesc = TextEditingController();
  TextEditingController controllerLotNo = TextEditingController();
  TextEditingController controllerPackageSize = TextEditingController();
  TextEditingController controllerPackageQty = TextEditingController();

  final FocusNode focusCutOff = FocusNode();
  final FocusNode focusLocation = FocusNode();
  final FocusNode focusPalletID = FocusNode();
  final FocusNode focusQty = FocusNode();
  bool manual = true;
  void changeManual(bool? value) {
    setState(() {
      manual = !manual;
      if (manual == false) {
        BlocProvider.of<CutofSoCubit>(context).getCutOf(context);
        // clear();
      }
    });
  }

  void save() {
    if (formkey.currentState!.validate()) {
      // if (valueOidCutOff != null && valueLocationId != null) {
        BlocProvider.of<InsertStockOpnameCubit>(context).save(context, valueOidCutOff, valueLocationId, controllerPalletId.text, controllerPackageQty.text);
      // }
    }
  }

  void clear() {
    setState(() {
      // valueCodeCutOff = null;
      // valueOidCutOff = null;
      // valueLocationId = null;
      // valueLocationName = null;
      // controllerWarehouseCutOff.clear();
      // controllerDateCutOff.clear();
      // controllerCodeCutOff.clear();
      // controllerLocationCode.clear();
      controllerPalletId.clear();
      controllerItemDesc.clear();
      controllerLotNo.clear();
      controllerPackageSize.clear();
      controllerPackageQty.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CutofSoCubit>(context).getCutOf(context);
  }

  @override
  void dispose() {
    focusCutOff.dispose();
    focusLocation.dispose();
    focusPalletID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: colorBlueNavy,
        title: Text("Entry Stock Opname", style: TextStyle(color: Colors.white, fontSize: 18)),
        actions: [Switch(value: manual, onChanged: changeManual, activeTrackColor: Colors.green)],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CutofSoCubit, CutofSoState>(
            listener: (context, state) {
              if (state is CutofSoLoading) {
                EasyLoading.show();
              }
              if (state is CutofSoFailed) {
                EasyLoading.dismiss();
              }
              if (state is CutofSoLoadedSingle) {
                EasyLoading.dismiss();
                var json = state.model;
                // var statusCode = state.statusCode;
                if (manual == true) {
                  if (json!.length == 0) {
                    // MyDialog.dialogAlert(context, "Data tidak ditemukan");
                    EasyLoading.showError("Data tidak ditemukan");
                    setState(() {
                      valueOidCutOff = null;
                      controllerWarehouseCutOff.clear();
                      controllerDateCutOff.clear();
                    });
                  } else {
                    print("sini");
                    setState(() {
                      FocusScope.of(context).requestFocus(focusLocation);
                      json.forEach((a) {
                        valueOidCutOff = a.oid;
                        controllerWarehouseCutOff = TextEditingController(text: a.warehouseCode!);
                        controllerDateCutOff = TextEditingController(text: formatDate.format(DateTime.parse(a.date!)));
                      });
                    });
                  }
                }
              }
            },
          ),
          BlocListener<LocationSoCubit, LocationSoState>(
            listener: (context, state) {
              if (state is LocationSoLoading) {
                EasyLoading.show();
              }
              if (state is LocationSoFailed) {
                EasyLoading.dismiss();
                var json = state.json;
                EasyLoading.showError(json['message']);
                setState(() {
                  valueLocationId = null;
                  controllerLocationCode.clear();
                });
              }
              if (state is LocationSoCodeLoaded) {
                EasyLoading.dismiss();
                var json = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  // EasyLoading.showSuccess("Location Available");
                  if (manual == true) {
                    setState(() {
                      valueLocationId = json.id;
                      print(valueLocationId);
                      FocusScope.of(context).requestFocus(focusPalletID);
                    });
                  }
                }
              }
            },
          ),
          BlocListener<ItemBypalletIdCubit, ItemBypalletIdState>(
            listener: (context, state) {
              if (state is ItemBypalletIdLoading) {
                EasyLoading.show();
              }
              if (state is ItemBypalletIdFailed) {
                EasyLoading.dismiss();
                var json = state.json;
                var statusCode = state.statusCode;
                EasyLoading.showError(json['message']);
                // MyDialog.dialogAlert(context, json['message']);
                setState(() {
                  controllerPalletId.clear();
                  controllerItemDesc.clear();
                  controllerLotNo.clear();
                  controllerPackageSize.clear();
                  controllerPackageQty.clear();
                });
              }
              if (state is ItemBypalletIdLoaded) {
                EasyLoading.dismiss();
                var json = state.model!;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  if (json.message!.isNotEmpty) {
                    MyDialog.dialogInfo(
                      context,
                      json.message,
                      () {},
                      () {
                        setState(() {
                          controllerPalletId = TextEditingController(text: json.data.palletId);
                          controllerItemDesc = TextEditingController(text: json.data.itemDescription1);
                          controllerLotNo = TextEditingController(text: json.data.lotNo);
                          controllerPackageSize = TextEditingController(text: json.data.qtyPackageSizeCounted!.toString());
                          controllerPackageQty = TextEditingController(text: json.data.qtyPackagingPerPalletCounted!.toString());
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            FocusScope.of(context).requestFocus(focusQty);
                            if (!focusQty.hasListeners) {
                              focusQty.addListener(() {
                                if (focusQty.hasFocus) {
                                  controllerPackageQty.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: controllerPackageQty.text.length,
                                  );
                                }
                              });
                            }
                          });
                        });
                      },
                    );
                  } else if (json.message! == "") {
                    setState(() {
                      controllerPalletId = TextEditingController(text: json.data.palletId);
                      controllerItemDesc = TextEditingController(text: json.data.itemDescription1);
                      controllerLotNo = TextEditingController(text: json.data.lotNo);
                      controllerPackageSize = TextEditingController(text: json.data.qtyPackageSizeCounted!.toString());
                      controllerPackageQty = TextEditingController(text: json.data.qtyPackagingPerPalletCounted!.toString());
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        FocusScope.of(context).requestFocus(focusQty);

                        // Pastikan hanya add listener sekali!
                        if (!focusQty.hasListeners) {
                          focusQty.addListener(() {
                            if (focusQty.hasFocus) {
                              controllerPackageQty.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: controllerPackageQty.text.length,
                              );
                            }
                          });
                        }
                      });
                    });
                  }
                }
              }
            },
          ),
          BlocListener<InsertStockOpnameCubit, InsertStockOpnameState>(
            listener: (context, state) {
              if (state is InsertStockOpnameLoading) {
                EasyLoading.show();
              }
              if (state is InsertStockOpnameFailed) {
                EasyLoading.dismiss();
                var json = state.json;
                var statusCode = state.statusCode;
                if (statusCode == 400) {
                  final errors = json['errors'] as Map<String, dynamic>;
                  final messages = errors.entries.map((e) => "${e.key}: ${(e.value as List).join(', ')}").join("\n");
                  MyDialog.dialogAlert(context, messages);
                }
              }
              if (state is InsertStockOpnameLoaded) {
                EasyLoading.dismiss();
                var json = state.json;
                var statusCode = state.statusCode;
                if (statusCode == 200) {
                  MyDialog.dialogSuccess(context, json['message']);
                  clear();
                  FocusScope.of(context).requestFocus(focusPalletID);
                }
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            // CUT OFF
                            if (manual == false)
                              BlocBuilder<CutofSoCubit, CutofSoState>(
                                builder: (context, state) {
                                  if (state is CutofSoLoading) {
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [].map((e) => e).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            hintText: "Cut Off",
                                            labelText: "Cut Off",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                    );
                                  }
                                  if (state is CutofSoLoaded == false) {
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [].map((e) => e).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            hintText: "Cut Off",
                                            labelText: "Cut Off",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                    );
                                  }
                                  var data = (state as CutofSoLoaded).model;
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: data!.map((e) => e.code).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          hintText: "Cut Off",
                                          labelText: "Cut Off",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                    selectedItem: valueCodeCutOff,
                                    onChanged: (value) {
                                      setState(() {
                                        data.where((e) => e.code == value).forEach((a) {
                                          valueOidCutOff = a.oid;
                                          controllerWarehouseCutOff = TextEditingController(text: a.warehouseCode!);
                                          controllerDateCutOff = TextEditingController(text: formatDate.format(DateTime.parse(a.date!)));
                                          BlocProvider.of<LocationSoCubit>(context).getLocationSOList(context, valueOidCutOff);
                                        });
                                      });
                                    },
                                  );
                                },
                              ),
                            if (manual == true)
                              Column(
                                children: [
                                  CustomField(
                                    readOnly: false,
                                    hidePassword: false,
                                    controller: controllerCodeCutOff,
                                    labelText: "Cut Off",
                                    hintText: "QR Code Cut Off",
                                    preffixIcon: Icon(Icons.qr_code_2),
                                    suffixIcon: controllerCodeCutOff.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                controllerCodeCutOff.clear();
                                                controllerWarehouseCutOff.clear();
                                                controllerDateCutOff.clear();
                                                controllerLocationCode.clear();
                                              });
                                            },
                                            child: Icon(Icons.close))
                                        : SizedBox.shrink(),
                                    focusNode: focusCutOff,
                                    onChanged: (value) async {
                                      await Future.delayed(Duration(milliseconds: 500));
                                      setState(() {
                                        if (controllerCodeCutOff.text.isNotEmpty) {
                                          BlocProvider.of<CutofSoCubit>(context).getCutOfCode(context, value);
                                        }
                                      });
                                    },
                                    messageError: "Please fill this column",
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerWarehouseCutOff,
                              labelText: "Warehouse",
                              messageError: "Please fill this column",
                              preffixIcon: Icon(Icons.home),
                            ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerDateCutOff,
                              labelText: "Cut Off Date",
                              messageError: "Please fill this column",
                              preffixIcon: Icon(Icons.calendar_month),
                            ),
                            const SizedBox(height: 8),
                            // LOCATION
                            if (manual == false)
                              BlocBuilder<LocationSoCubit, LocationSoState>(
                                builder: (context, state) {
                                  if (state is LocationSoLoading) {
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [].map((e) => e).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                            hintText: "Location",
                                            labelText: "Location",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                    );
                                  }
                                  if (state is LocationSoListLoaded == false) {
                                    return DropdownSearch(
                                      popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                      items: [].map((e) => e).toList(),
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                            hintText: "Location",
                                            labelText: "Location",
                                            labelStyle: TextStyle(color: Colors.black),
                                            hintStyle: TextStyle(color: Colors.black)),
                                      ),
                                    );
                                  }
                                  var data = (state as LocationSoListLoaded).model;
                                  return DropdownSearch(
                                    popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                                    items: data!.map((e) => e.name).toList(),
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          isDense: true,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                          hintText: "Location",
                                          labelText: "Location",
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintStyle: TextStyle(color: Colors.black)),
                                    ),
                                    selectedItem: valueLocationName,
                                    onChanged: (value) {
                                      setState(() {
                                        data.where((e) => e.name == value).forEach((a) {
                                          valueLocationId = a.id;
                                          valueLocationName = a.name;
                                        });
                                      });
                                    },
                                  );
                                },
                              ),
                            if (manual == true)
                              Column(
                                children: [
                                  CustomField(
                                    readOnly: false,
                                    hidePassword: false,
                                    controller: controllerLocationCode,
                                    focusNode: focusLocation,
                                    labelText: "Location",
                                    hintText: "Scan QR Code location",
                                    preffixIcon: Icon(Icons.qr_code_2),
                                    messageError: "Please fill this column",
                                    onChanged: (value) async {
                                      await Future.delayed(Duration(milliseconds: 500));
                                      setState(() {
                                        if (controllerCodeCutOff.text.isEmpty) {
                                          EasyLoading.showError("QR Cut Off code belum di Scan");
                                          controllerLocationCode.clear();
                                          valueLocationId = null;
                                        } else {
                                          if (controllerCodeCutOff.text.isNotEmpty) {
                                            BlocProvider.of<LocationSoCubit>(context).getLocationSOCode(context, valueOidCutOff, value);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            const SizedBox(height: 25),
                            CustomField(
                              readOnly: false,
                              hidePassword: false,
                              controller: controllerPalletId,
                              focusNode: focusPalletID,
                              labelText: "Pallet ID",
                              hintText: "Scan QR Code Pallet ID",
                              preffixIcon: Icon(Icons.qr_code_2),
                              messageError: "Please fill this column",
                              onChanged: (value) async {
                                await Future.delayed(Duration(milliseconds: 500));
                                setState(() {
                                  if (controllerLocationCode.text.isEmpty) {
                                    EasyLoading.showError("Location belum di Scan");
                                    controllerPalletId.clear();
                                    controllerItemDesc.clear();
                                    controllerLotNo.clear();
                                    controllerPackageSize.clear();
                                    controllerPackageQty.clear();
                                  } else {
                                    if (controllerPalletId.text.isNotEmpty) {
                                      BlocProvider.of<ItemBypalletIdCubit>(context)
                                          .scanPalletId(context, valueOidCutOff, valueLocationId, controllerPalletId.text);
                                    }
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: false,
                              hidePassword: false,
                              focusNode: focusQty,
                              controller: controllerPackageQty,
                              keyboardType: TextInputType.number,
                              labelText: "Qty Package/Pallet",
                              messageError: "Please fill this column",
                            ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerItemDesc,
                              labelText: "Item Description",
                              messageError: "Please fill this column",
                            ),
                            const SizedBox(height: 8),
                            CustomField(
                              readOnly: true,
                              hidePassword: false,
                              controller: controllerLotNo,
                              labelText: "Lot No",
                              messageError: "Please fill this column",
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 45,
                child: CustomButton(
                  onTap: save,
                  bkackgroundColor: colorGreenDarkTeal,
                  text: "SAVE",
                  textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }
}
