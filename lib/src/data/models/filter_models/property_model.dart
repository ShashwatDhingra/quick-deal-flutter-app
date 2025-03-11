class PropertyFilterModel {
  String? propertyType;
  double? minPrice;
  double? maxPrice;
  String? status;
  int? bedrooms;
  int? bathrooms;
  int? constructionYear;
  String? city;
  String? state;
  String? pincode;

  PropertyFilterModel({
    this.propertyType,
    this.minPrice,
    this.maxPrice,
    this.status,
    this.bedrooms,
    this.bathrooms,
    this.constructionYear,
    this.city,
    this.state,
    this.pincode,
  });

  PropertyFilterModel copyWith({
    String? propertyType,
    double? minPrice,
    double? maxPrice,
    String? status,
    int? bedrooms,
    int? bathrooms,
    int? constructionYear,
    String? city,
    String? state,
    String? pincode,
  }) {
    return PropertyFilterModel(
      propertyType: propertyType ?? this.propertyType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      status: status ?? this.status,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      constructionYear: constructionYear ?? this.constructionYear,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
    );
  }

  String toFilter() {
    String filter = "";
    if (propertyType != null) filter += '&filters[propertyType]=$propertyType';
    if (minPrice != null) filter += '&filters[price][lte]=$minPrice';
    if (maxPrice != null) filter += '&filters[price][gte]=$maxPrice';
    if (status != null) filter += '&filters[status]=$status';
    if (bedrooms != null) filter += '&filters[bedrooms]=$bedrooms';
    if (bathrooms != null) filter += '&filters[bedrooms]=$bathrooms';
    if (constructionYear != null) filter += '&filters[constructionYear]=$constructionYear';
    if (city != null) filter += '&filters[city]=$city';
    if (state != null) filter += '&filters[state]=$state';
    if (pincode != null) filter += '&filters[pincode]=$pincode';
    return filter;
  }
}
