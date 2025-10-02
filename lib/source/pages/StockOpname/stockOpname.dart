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
    print("$valueOid, $valueLocationId");
    BlocProvider.of<PhysicalCountCubit>(context).getPhysicalCountListSO(context, valueOid, valueLocationId);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CutofSoCubit>(context).getCutOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        BlocProvider.of<PhysicalCountCubit>(context).clearList(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorBlueNavy,
          leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back, color: Colors.white)),
          title: Text("Stock Opname", style: TextStyle(color: Colors.white, fontSize: 18)),
          actions: [IconButton(onPressed: () => Navigator.pushNamed(context, insertStockOpnameScreen), icon: Icon(Icons.add, color: Colors.white))],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  const SizedBox(height: 15),
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
                      return SizedBox(
                        height: 45,
                        child: DropdownSearch(
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
                              data.where((e) => e.code == value).forEach((a) {
                                valueOid = a.oid;
                                BlocProvider.of<LocationSoCubit>(context).getLocationSOList(context, valueOid);
                              });
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  BlocConsumer<LocationSoCubit, LocationSoState>(
                    listener: (context, state) {
                      if (state is LocationSoLoading) {
                        EasyLoading.show();
                      }
                      if (state is LocationSoFailed) {
                        EasyLoading.dismiss();
                      }
                      if (state is LocationSoListLoaded) {
                        EasyLoading.dismiss();
                      }
                    },
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
                      return SizedBox(
                        height: 45,
                        child: DropdownSearch(
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
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: CustomButton(
                      onTap: getItem,
                      text: "Retrieve",
                      bkackgroundColor: colorBlueNavy,
                      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
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
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(color: colorGrey1, blurRadius: 1.3, spreadRadius: 1.3, offset: Offset(1, 3))]),
                            child: Column(
                              children: [
                                Table(
                                  border: TableBorder.all(style: BorderStyle.none),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FixedColumnWidth(120),
                                    1: FixedColumnWidth(15),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        const Text('Pallet Counted', style: TextStyle(fontSize: 15)),
                                        const Text(':', style: TextStyle(fontSize: 15)),
                                        Text("${data!.summary.entry.palletCount}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const TableRow(
                                      children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                    ),
                                    TableRow(
                                      children: [
                                        const Text('Qty Counted', style: TextStyle(fontSize: 15)),
                                        const Text(':', style: TextStyle(fontSize: 15)),
                                        Text("${formatRupiah(int.parse(data!.summary.entry.totalQtyStockCounted!.toStringAsFixed(0)))}",
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const TableRow(
                                      children: [SizedBox(height: 4), SizedBox(height: 4), SizedBox(height: 4)],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data!.data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var a = data.data[index];
                              num varianceCounted = a.qtyStockCounted! - a.qtyStockSystem!;
                              num variancePerPallet = a.qtyPackagingPerPalletCounted! - a.qtyPackagingPerPalletSystem!;
                              return Container(
                                margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 6),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(a.itemDescription1!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
                                        const SizedBox(height: 6),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
                                            border: TableBorder.all(color: Colors.grey.shade300),
                                            columnSpacing: 16,
                                            dataRowMinHeight: 30,
                                            dataRowMaxHeight: 30,
                                            headingRowHeight: 32,
                                            columns: const [
                                              DataColumn(label: Text("Lot/Pallet ID")),
                                              DataColumn(label: Text("Qty (Count)")),
                                              DataColumn(label: Text("Qty (System)")),
                                              DataColumn(label: Text("Qty (Variance)")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text(a.lotNo!)),
                                                DataCell(
                                                  Text("${formatRupiah(int.parse(a.qtyStockCounted!.toStringAsFixed(0)))} ${a.unitMeasureCode ?? ''}"),
                                                ),
                                                DataCell(
                                                  Text(
                                                    "${formatRupiah(int.parse(a.qtyStockSystem!.toStringAsFixed(0)))} ${a.unitMeasureCode ?? ''}", // kalau null tampilkan strip
                                                  ),
                                                ),
                                                DataCell(
                                                  Text("${formatRupiah(int.parse(varianceCounted.toStringAsFixed(0)))} ${a.unitMeasureCode ?? ''}"),
                                                ),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text(a.palletId!)),
                                                DataCell(
                                                  Text("${formatRupiah(int.parse(a.qtyPackagingPerPalletCounted!.toStringAsFixed(0)))} Zak"),
                                                ),
                                                DataCell(
                                                  Text("${formatRupiah(int.parse(a.qtyPackagingPerPalletSystem!.toStringAsFixed(0)))} Zak"),
                                                ),
                                                DataCell(
                                                  Text("${formatRupiah(int.parse(variancePerPallet.toStringAsFixed(0)))} Zak"),
                                                ),
                                                // DataCell(Text("0 Zak")),
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
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
