part of '../index.dart';

class StockOpnameScreen extends StatefulWidget {
  const StockOpnameScreen({super.key});

  @override
  State<StockOpnameScreen> createState() => _StockOpnameScreenState();
}

class _StockOpnameScreenState extends State<StockOpnameScreen> {
  var valueCutOf, valueLocation, valueOid;
  var valueCutOfId, valueLocationId;

  void getItem() {
    BlocProvider.of<PhysicalCountCubit>(context).getPhysicalCountListSO(context, valueOid, valueLocationId);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CutofSoCubit>(context).getCutOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stock Opname'),
        actions: [IconButton(onPressed: () => Navigator.pushNamed(context, insertStockOpnameScreen), icon: Icon(Icons.add))],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
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
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            hintText: "Cut Off",
                            labelText: "Cut Off",
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                      selectedItem: valueCutOf,
                      onChanged: (value) {
                        setState(() {
                          data.where((e) => e.warehouseName == value).forEach((a) {
                            valueOid = a.oid;
                            BlocProvider.of<LocationSoCubit>(context).getLocationSOList(context, valueOid);
                          });
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<LocationSoCubit, LocationSoState>(
                  builder: (context, state) {
                    if (state is LocationSoLoading) {
                      return DropdownSearch(
                        popupProps: const PopupProps.menu(showSearchBox: true, fit: FlexFit.loose),
                        items: [].map((e) => e).toList(),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            hintText: "Location",
                            labelText: "Location",
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                      selectedItem: valueCutOf,
                      onChanged: (value) {
                        setState(() {
                          data.where((e) => e.name == value).forEach((a) {
                            valueLocationId = a.id;
                          });
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onTap: getItem,
                  text: "Retrieve",
                  bkackgroundColor: colorBlueNavy,
                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 10),
                BlocBuilder<PhysicalCountCubit, PhysicalCountState>(
                  builder: (context, state) {
                    if (state is PhysicalCountLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (state is PhysicalCountLoaded == false) {
                      return Container();
                    }
                    var data = (state as PhysicalCountLoaded).model;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data!.data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var a = data.data[index];
                        return Container(
                          margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.centerLeft, child: Text(a.itemCode!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
                                  const SizedBox(height: 6),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
                                      border: TableBorder.all(color: Colors.grey.shade300),
                                      columnSpacing: 24,
                                      dataRowMinHeight: 48,
                                      dataRowMaxHeight: 56,
                                      columns: const [
                                        DataColumn(label: Text("Lot/Pallet ID")),
                                        DataColumn(label: Text("Qty (System)")),
                                        DataColumn(label: Text("Qty (Count)")),
                                        DataColumn(label: Text("Qty (Variance)")),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text(a.lotNo!)),
                                          DataCell(
                                            Text(
                                              a.qtyPackagingPerPalletSystem != null
                                                  ? "${a.qtyPackagingPerPalletSystem!.toStringAsFixed(0)} ${a.unitMeasureCode ?? ''}"
                                                  : "-", // kalau null tampilkan strip
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              a.qtyPackagingPerPalletSystem != null
                                                  ? "${a.qtyPackagingPerPalletCounted!.toStringAsFixed(0)} ${a.unitMeasureCode ?? ''}"
                                                  : "-", // kalau null tampilkan strip
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              a.qtyPackagingPerPalletSystem != null ? "0 ${a.unitMeasureCode ?? ''}" : "-", // kalau null tampilkan strip
                                            ),
                                          ),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text(a.palletId!)),
                                          DataCell(
                                            Text(
                                              a.qtyPackagingPerPalletSystem != null
                                                  ? "${a.qtyPackageSizeSystem!.toStringAsFixed(0)} Zak"
                                                  : "-", // kalau null tampilkan strip
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              a.qtyPackagingPerPalletSystem != null
                                                  ? "${a.qtyPackageSizeCounted!.toStringAsFixed(0)} Zak"
                                                  : "-", // kalau null tampilkan strip
                                            ),
                                          ),
                                          DataCell(Text("0 Zak")),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
