import 'package:sci_mobile/source/network/api.dart';
import 'package:sci_mobile/source/network/network.dart';

class RepositoryStockOpname {
  Future getCutOf(context) async {
    var json = await network(url: Api.getCutOf(), method: "GET", body: null, context: context);
    return json;
  }

  Future getCutOfbyNo(context, code) async {
    var json = await network(url: Api.getCutOfbyNo(code), method: "GET", body: null, context: context);
    return json;
  }

  Future getLocationSObyCode(context, oid, code) async {
    var json = await network(url: Api.getLocationSObyCode(oid, code), method: "GET", body: null, context: context);
    return json;
  }

  Future getLocationSO(context, oid) async {
    var json = await network(url: Api.getLocationSO(oid), method: "GET", body: null, context: context);
    return json;
  }

  Future getItembyPaletIDSO(context, oid, locationId, paletId) async {
    var json = await network(url: Api.getItembyPaletIDSO(oid, locationId, paletId), method: "GET", body: null, context: context);
    return json;
  }

  Future getPhysicalCountListSO(context, oid, locationId) async {
    var json = await network(url: Api.getPhysicalCountListSO(oid, locationId), method: "GET", body: null, context: context);
    return json;
  }

  Future saveSO(context, oid, body) async {
    var json = await network(url: Api.saveSO(oid), method: "POST", body: body, context: context);
    return json;
  }
}
