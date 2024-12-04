class MyBusinessModel {
  String? logoUrl,
      category,
      companyAddress,
      companyEmail,
      companyMobileNumber,
      companyName,
      companyWebSite,
      countryCode,
      id;
  bool isSelect;

  MyBusinessModel({
    this.category,
    this.companyAddress,
    this.companyEmail,
    this.companyMobileNumber,
    this.companyName,
    this.companyWebSite,
    this.countryCode,
    this.logoUrl,
    this.id,
    this.isSelect = false,
  });
}
