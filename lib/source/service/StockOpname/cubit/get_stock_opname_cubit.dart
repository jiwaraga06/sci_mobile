import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sci_mobile/source/repository/repositoryStockOpname.dart';

part 'get_stock_opname_state.dart';

class GetStockOpnameCubit extends Cubit<GetStockOpnameState> {
  final RepositoryStockOpname? repository;
  GetStockOpnameCubit({this.repository}) : super(GetStockOpnameInitial());
}
