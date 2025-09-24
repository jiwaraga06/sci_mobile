import 'package:sci_mobile/source/network/api.dart';
import 'package:sci_mobile/source/network/network.dart';

class RepositoryAuth {
  Future login(body, context) async {
    var json = await network(url: Api.login(), method: "POST", body: body, context: context);
    return json;
  }
}
