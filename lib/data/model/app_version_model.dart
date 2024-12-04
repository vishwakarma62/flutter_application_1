class SettingModel {
  int? statusCode;
  String? message;
  Result? result;
  bool? isSuccess;

  SettingModel({this.statusCode, this.message, this.result, this.isSuccess});

  SettingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}

class Result {
  String? minimumMobileVersion;
  String? interstitialAdUnitId;
  String? bannerAdUnitID;
  String? isDisplayAd;

  Result(
      {this.minimumMobileVersion,
      this.interstitialAdUnitId,
      this.bannerAdUnitID,
      this.isDisplayAd});

  Result.fromJson(Map<String, dynamic> json) {
    minimumMobileVersion = json['MinimumMobileVersion'];
    interstitialAdUnitId = json['InterstitialAdUnitId'];
    bannerAdUnitID = json['BannerAdUnitID'];
    isDisplayAd = json['IsDisplayAd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MinimumMobileVersion'] = this.minimumMobileVersion;
    data['InterstitialAdUnitId'] = this.interstitialAdUnitId;
    data['BannerAdUnitID'] = this.bannerAdUnitID;
    data['IsDisplayAd'] = this.isDisplayAd;
    return data;
  }
}