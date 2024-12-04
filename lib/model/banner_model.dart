

// class BannerModel {
//   String? bannerId, bannerName, bannerURL;
//   DateTime? createdAt;
//   dynamic navigation;
//   bool? status;

//   BannerModel({
//     this.bannerId,
//     this.bannerName,
//     this.bannerURL,
//     this.createdAt,
//     this.navigation,
//     this.status,
//   });

//   // Convert BannerModel to a Map
//   Map<String, dynamic> toJson() {
//     return {
//       'bannerId': bannerId,
//       'bannerName': bannerName,
//       'bannerURL': bannerURL,
//       'createdAt': createdAt?.toIso8601String(),
//       'navigation': navigation,
//       'status': status,
//     };
//   }

//   // Create a BannerModel instance from a Map
//   factory BannerModel.fromJson(Map<String, dynamic> json) {
//     return BannerModel(
//       bannerId: json['bannerId'],
//       bannerName: json['bannerName'],
//       bannerURL: json['bannerURL'],
//       createdAt: DateTime.tryParse(json['createdAt']),
//       navigation: json['navigation'],
//       status: json['status'],
//     );
//   }
// }
