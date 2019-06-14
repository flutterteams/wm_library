import 'package:connectivity/connectivity.dart';

///网络检测
class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((intenet) {
      if (intenet != null && intenet) {
        func(true);
      } else {
        func(false);
      }
    });
  }

  fetchPrefrence(bool isNetworkPresent) {
    if(isNetworkPresent){

    }else{

    }
  }
//  NetworkCheck networkCheck = new NetworkCheck();
//  networkCheck.checkInternet(fetchPrefrence)

}
