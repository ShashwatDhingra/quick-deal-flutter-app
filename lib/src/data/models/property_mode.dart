class Property {
  final String title;
  final String? description;
  final String category;
  final double price;
  final Location location;
  final String status;
  final String? area;
  final String? furnishing;
  final int? bedrooms;
  final int? bathrooms;
  final int? balconies;
  final bool parking;
  final int? floorNumber;
  final int? totalFloors;
  final int? constructionYear;
  final String? ownershipType;
  final List<String>? amenities;
  final List<String>? images;
  final String? videoTour;
  final String? propertyType;
  final double? maintenanceCost;
  final String? nearestLandmark;
  final String? facingDirection;
  final bool legalClearance;
  final DateTime? availableFrom;
  final DateTime createdAt;
  final DateTime updatedAt;

  Property({
    required this.title,
    this.description,
    required this.category,
    required this.price,
    required this.location,
    this.status = 'draft',
    this.area,
    this.furnishing,
    this.bedrooms,
    this.bathrooms,
    this.balconies,
    this.parking = false,
    this.floorNumber,
    this.totalFloors,
    this.constructionYear,
    this.ownershipType,
    this.amenities,
    this.images,
    this.videoTour,
    this.propertyType,
    this.maintenanceCost,
    this.nearestLandmark,
    this.facingDirection,
    this.legalClearance = false,
    this.availableFrom,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Convert JSON to Property instance
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      location: Location.fromJson(json['location']),
      status: json['status'] ?? 'draft',
      area: json['area'],
      furnishing: json['furnishing'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      balconies: json['balconies'],
      parking: json['parking'] ?? false,
      floorNumber: json['floorNumber'],
      totalFloors: json['totalFloors'],
      constructionYear: json['constructionYear'],
      ownershipType: json['ownershipType'],
      amenities: (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      videoTour: json['videoTour'],
      propertyType: json['propertyType'],
      maintenanceCost: (json['maintenanceCost'] as num?)?.toDouble(),
      nearestLandmark: json['nearestLandmark'],
      facingDirection: json['facingDirection'],
      legalClearance: json['legalClearance'] ?? false,
      availableFrom: json['availableFrom'] != null ? DateTime.parse(json['availableFrom']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert Property instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'location': location.toJson(),
      'status': status,
      'area': area,
      'furnishing': furnishing,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'balconies': balconies,
      'parking': parking,
      'floorNumber': floorNumber,
      'totalFloors': totalFloors,
      'constructionYear': constructionYear,
      'ownershipType': ownershipType,
      'amenities': amenities,
      'images': images,
      'videoTour': videoTour,
      'propertyType': propertyType,
      'maintenanceCost': maintenanceCost,
      'nearestLandmark': nearestLandmark,
      'facingDirection': facingDirection,
      'legalClearance': legalClearance,
      'availableFrom': availableFrom?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // CopyWith method to update specific fields
  Property copyWith({
    String? title,
    String? description,
    String? category,
    double? price,
    Location? location,
    String? status,
    String? area,
    String? furnishing,
    int? bedrooms,
    int? bathrooms,
    int? balconies,
    bool? parking,
    int? floorNumber,
    int? totalFloors,
    int? constructionYear,
    String? ownershipType,
    List<String>? amenities,
    List<String>? images,
    String? videoTour,
    String? propertyType,
    double? maintenanceCost,
    String? nearestLandmark,
    String? facingDirection,
    bool? legalClearance,
    DateTime? availableFrom,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Property(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      location: location ?? this.location,
      status: status ?? this.status,
      area: area ?? this.area,
      furnishing: furnishing ?? this.furnishing,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      balconies: balconies ?? this.balconies,
      parking: parking ?? this.parking,
      floorNumber: floorNumber ?? this.floorNumber,
      totalFloors: totalFloors ?? this.totalFloors,
      constructionYear: constructionYear ?? this.constructionYear,
      ownershipType: ownershipType ?? this.ownershipType,
      amenities: amenities ?? this.amenities,
      images: images ?? this.images,
      videoTour: videoTour ?? this.videoTour,
      propertyType: propertyType ?? this.propertyType,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      nearestLandmark: nearestLandmark ?? this.nearestLandmark,
      facingDirection: facingDirection ?? this.facingDirection,
      legalClearance: legalClearance ?? this.legalClearance,
      availableFrom: availableFrom ?? this.availableFrom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Location {
  final String address;
  final String city;
  final String state;
  final int pincode;
  final Coordinates? coordinates;

  Location({
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      coordinates: json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'coordinates': coordinates?.toJson(),
    };
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({
    required this.lat,
    required this.lng,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
