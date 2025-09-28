import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sci_mobile/source/env/env.dart';
import 'package:sci_mobile/source/router/string.dart';
import 'package:sci_mobile/source/service/Auth/cubit/auth_cubit.dart';
import 'package:sci_mobile/source/service/Auth/cubit/profile_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/cutof_so_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/insert_stock_opname_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/item_bypallet_id_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/location_so_cubit.dart';
import 'package:sci_mobile/source/service/StockOpname/cubit/physical_count_cubit.dart';
import 'package:sci_mobile/source/widget/customButton.dart';
import 'package:sci_mobile/source/widget/customDialog.dart';
import 'package:sci_mobile/source/widget/customField.dart';

part 'Auth/login.dart';
part 'Auth/splash.dart';

part 'Dashboard/dashboard.dart';

part './StockOpname/stockOpname.dart';
part './StockOpname/insertStockOpname.dart';