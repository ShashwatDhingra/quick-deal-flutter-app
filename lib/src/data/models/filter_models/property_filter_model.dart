class PropertyFilterModel {
  List<String>? propertyType;
  double? minPrice;
  double? maxPrice;
  List<String>? status;
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
    List<String>? propertyType,
    double? minPrice,
    double? maxPrice,
    List<String>? status,
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
    if (propertyType != null) {
      for (var val in propertyType!) {
        filter += '&filters[propertyType]=$val';
      }
    }
    if (minPrice != null) filter += '&filters[price][lte]=$minPrice';
    if (maxPrice != null) filter += '&filters[price][gte]=$maxPrice';
    if (status != null) {
      for (var val in status!) {
        filter += '&filters[status]=$val';
      }
    }
    if (bedrooms != null) filter += '&filters[bedrooms]=$bedrooms';
    if (bathrooms != null) filter += '&filters[bedrooms]=$bathrooms';
    if (constructionYear != null)
      filter += '&filters[constructionYear]=$constructionYear';
    if (city != null) filter += '&filters[city]=$city';
    if (state != null) filter += '&filters[state]=$state';
    if (pincode != null) filter += '&filters[location.pincode]=$pincode';
    return '?page=1&limit=100' + filter;
  }
}
