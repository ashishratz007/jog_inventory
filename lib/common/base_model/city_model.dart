
import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/storage/storage.dart';

class StateModel extends BaseModel {
  @override
  String get endPoint => "/city/fetch-state";

  String? stateName;
  StateModel({this.stateName});

  static String getKey() => "statesStorageKey";

  StateModel.fromJson(Map<dynamic, dynamic> json) : stateName = json['state'];

  static Future<List<StateModel>> fetchStates() async {
    List<StateModel> cities = [];
    var respModel;
    respModel = storage.dataBox.get(getKey(), defaultValue: null);
    if (respModel == null) {
      var resp = await StateModel().get();
      respModel = resp.data['allstates'];
      storage.dataBox.put(getKey(), respModel);
    }

    (respModel ?? []).forEach((json) {
      cities.add(StateModel.fromJson(json));
    });
    return cities;
  }
}

class CityModel extends BaseModel {
  @override
  String get endPoint => "/city/fetch-city";

  String? cityName;
  CityModel({this.cityName});

  static String getKey() => "citiesStorageKey";

  CityModel.fromJson(Map<dynamic, dynamic> json) : cityName = json['city'];

  static Future<List<CityModel>> fetchCities() async {
    List<CityModel> cities = [];
    var respModel;
    respModel = storage.dataBox.get(getKey(), defaultValue: null);
    if (respModel == null) {
      var resp = await CityModel().get();
      respModel = resp.data['allcities'];
      storage.dataBox.put(getKey(), respModel);
    }

    (respModel ?? []).forEach((json) {
      cities.add(CityModel.fromJson(json));
    });
    return cities;
  }
}

class PinCodeModel extends BaseModel {
  @override
  String get endPoint => "/city/fetch-pincode-by-city";

  int? id;
  String? state;
  String? city;
  String? pincode;
  int? status;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PinCodeModel({
    this.id,
    this.state,
    this.city,
    this.pincode,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PinCodeModel.fromJson(Map<String, dynamic> json) {
    return PinCodeModel(
      id: json['id'],
      state: json['state'],
      city: json['city'],
      pincode: json['pincode'],
      status: json['status'],
      isDeleted: json['is_deleted'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
    );
  }

  /// cache keys
  static String getKey(String city) => "cityPinCodesStorageKey${city}";

  static Future<List<PinCodeModel>> fetchPinCodes(String city) async {
    List<PinCodeModel> pinCodes = [];
    var respModel;
    respModel = storage.dataBox.get(getKey(city), defaultValue: null);
    if (respModel == null) {
      var resp = await PinCodeModel().get(pathSuffix: "/${city}");
      respModel = resp.data['allpincodes'];
      storage.dataBox.put(getKey(city), respModel);
    }

    (respModel ?? []).forEach((json) {
      pinCodes.add(PinCodeModel.fromJson(json));
    });
    return pinCodes;
  }
}
