import 'package:sci_mobile/source/env/env.dart';

class Api {
  static login() {
    return "$host/api/auth/login";
  }

// stockOpname
  static getCutOf() {
    return "$host/api/inventory/cycle-count";
  }

  static getCutOfbyNo(code) {
    return "$host/api/inventory/cycle-count/$code";
  }

  static getLocationSObyCode(oid, code) {
    return "$host/api/inventory/cycle-count/$oid/location/$code";
  }

  static getLocationSO(oid) {
    return "$host/api/inventory/cycle-count/$oid/location";
  }

  static getItembyPaletIDSO(oid, locationId, paletId) {
    return "$host/api/inventory/cycle-count/$oid/pallet?location_id=$locationId&pallet_id=$paletId";
  }

  static getPhysicalCountListSO(oid, locationId) {
    return "$host/api/inventory/cycle-count/$oid/pallet/all?location_id=$locationId";
  }

  static saveSO(oid) {
    return "$host/api/inventory/cycle-count/$oid/pallet";
  }
}
