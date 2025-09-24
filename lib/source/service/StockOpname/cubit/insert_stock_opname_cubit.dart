import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';

part 'insert_stock_opname_state.dart';

class InsertStockOpnameCubit extends Cubit<InsertStockOpnameState> {
    final RepositoryStockOpname? repository;
  InsertStockOpnameCubit({this.repository}) : super(InsertStockOpnameInitial());
}
