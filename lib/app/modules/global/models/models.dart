class Cv {
  Cv({
    required this.cvs,
    required this.currentPage,
    required this.lastPage,
    required this.nationalities,
    required this.jobs,
    required this.experience,
    required this.religion,
  });

  final List<CvElement> cvs;
  final int? currentPage;
  final int? lastPage;
  final List<Nationality> nationalities;
  final List<Experience> jobs;
  final List<Experience> experience;
  final List<Experience> religion;

  factory Cv.fromJson(Map<String, dynamic> json){
    return Cv(
      cvs: json["cvs"] == null ? [] : List<CvElement>.from(json["cvs"]!.map((x) => CvElement.fromJson(x))),
      currentPage: json["current_page"],
      lastPage: json["last_page"],
      nationalities: json["nationalities"] == null ? [] : List<Nationality>.from(json["nationalities"]!.map((x) => Nationality.fromJson(x))),
      jobs: json["jobs"] == null ? [] : List<Experience>.from(json["jobs"]!.map((x) => Experience.fromJson(x))),
      experience: json["experience"] == null ? [] : List<Experience>.from(json["experience"]!.map((x) => Experience.fromJson(x))),
      religion: json["religion"] == null ? [] : List<Experience>.from(json["religion"]!.map((x) => Experience.fromJson(x))),
    );
  }

}

class CvElement {
  CvElement({
    required this.id,
    required this.status,
    required this.orderType,
    required this.image,
    required this.recruitmentOffice,
    required this.nationality,
    required this.spokenLanguage,
    required this.religion,
    required this.job,
    required this.socialType,
    required this.age,
    required this.salary,
    required this.recruitmentPrice,
    required this.passportNo,
    required this.video,
    required this.experience,
    required this.cvType,
  });

  final int? id;
  final String? status;
  final String? orderType;
  final String? image;
  final String? recruitmentOffice;
  final String? nationality;
  final String? spokenLanguage;
  final String? religion;
  final String? job;
  final String? socialType;
  final int? age;
  final int? salary;
  final int? recruitmentPrice;
  final String? passportNo;
  final String? video;
  final String? experience;
  final String? cvType;

  factory CvElement.fromJson(Map<String, dynamic> json){
    return CvElement(
      id: json["id"],
      status: json["status"],
      orderType: json["order_type"],
      image: json["image"],
      recruitmentOffice: json["recruitment_office"],
      nationality: json["nationality"],
      spokenLanguage: json["spoken_language"],
      religion: json["religion"],
      job: json["job"],
      socialType: json["social_type"],
      age: json["age"],
      salary: json["salary"],
      recruitmentPrice: json["recruitment_price"],
      passportNo: json["passport_no"],
      video: json["video"],
      experience: json["experience"],
      cvType: json["cv_type"],
    );
  }

}

class Experience {
  Experience({
    required this.id,
    required this.title,
  });

  final int? id;
  final String? title;

  factory Experience.fromJson(Map<String, dynamic> json){
    return Experience(
      id: json["id"],
      title: json["title"],
    );
  }

}

class Nationality {
  Nationality({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.recruitmentPrice,
    required this.nonMuslimPrice,
  });
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final int? recruitmentPrice;
  final int? nonMuslimPrice;

  factory Nationality.fromJson(Map<String, dynamic> json){
    return Nationality(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      recruitmentPrice: json["recruitment_price"],
      nonMuslimPrice: json["non_muslim_price"],
    );
  }

}
////////////////HomeSliderModel////////////////////
class HomeSliderModel {
  HomeSliderModel({
    required this.data,
  });

  final List<Datum> data;

  factory HomeSliderModel.fromJson(Map<String, dynamic> json){
    return HomeSliderModel(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.image,
    required this.title,
    required this.description,
  });

  final String? image;
  final String? title;
  final String? description;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      image: json["image"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
    );
  }

}
//////////////////////////////////////////////////


////////////////AboutUsModel////////////////////
class AboutUs {
  AboutUs({
    required this.data,
  });

  final Data? data;

  factory AboutUs.fromJson(Map<String, dynamic> json){
    return AboutUs(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.sectionTitle,
    required this.title,
    required this.description,
    required this.service,
    required this.license,
    required this.security,
    required this.delivery,
    required this.features,
  });

  final String? sectionTitle;
  final String? title;
  final String? description;
  final String? service;
  final String? license;
  final String? security;
  final String? delivery;
  final List<Feature> features;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      sectionTitle: json["section_title"]?? "",
      title: json["title"]?? "",
      description: json["description"]?? "",
      service: json["service"]?? "",
      license: json["license"]?? "",
      security: json["security"]?? "",
      delivery: json["delivery"]?? "",
      features: json["features"] == null ? [] : List<Feature>.from(json["features"]!.map((x) => Feature.fromJson(x))),
    );
  }

}

class Feature {
  Feature({
    required this.title,
    required this.desc,
    required this.icon,
    required this.image,
  });

  final String? title;
  final String? desc;
  final String? icon;
  final String? image;

  factory Feature.fromJson(Map<String, dynamic> json){
    return Feature(
      title: json["title"] ?? "",
      desc: json["desc"]?? "",
      icon: json["icon"] ?? "",
      image: json["image"]?? "",
    );
  }

}

//////////////////////////////////////////////////


////////////////ServicesModel////////////////////
class Services {
  Services({
    required this.data,
  });

  final List<ServiceInnerData> data;

  factory Services.fromJson(Map<String, dynamic> json){
    return Services(
      data: json["data"] == null ? [] : List<ServiceInnerData>.from(json["data"]!.map((x) => ServiceInnerData.fromJson(x))),
    );
  }

}

class ServiceInnerData {
  ServiceInnerData({
    required this.image,
    required this.title,
    required this.desc,
  });

  final String? image;
  final String? title;
  final String? desc;

  factory ServiceInnerData.fromJson(Map<String, dynamic> json){
    return ServiceInnerData(
      image: json["image"],
      title: json["title"],
      desc: json["desc"],
    );
  }

}
//////////////////////////////////////////////////

////////////////CustomerServiceModel////////////////////
class CustomerService {
  CustomerService({
    required this.data,
  });

  final List<CustomerServiceInnerData> data;

  factory CustomerService.fromJson(Map<String, dynamic> json){
    return CustomerService(
      data: json["data"] == null ? [] : List<CustomerServiceInnerData>.from(json["data"]!.map((x) => CustomerServiceInnerData.fromJson(x))),
    );
  }

}

class CustomerServiceInnerData {
  CustomerServiceInnerData({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.whatsApp,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? phone;
  final String? whatsApp;

  factory CustomerServiceInnerData.fromJson(Map<String, dynamic> json){
    return CustomerServiceInnerData(
      id: json["id"]?? "",
      name: json["name"]?? "",
      image: json["image"]?? "",
      phone: json["phone"]?? "",
      whatsApp: json["whats_app"]?? "",
    );
  }

}

//////////////////////////////////////////////////

//////////////////CountriesModel////////////////////
class Countries {
  Countries({
    required this.data,
  });

  final List<CountryData> data;

  factory Countries.fromJson(Map<String, dynamic> json){
    return Countries(
      data: json["data"] == null ? [] : List<CountryData>.from(json["data"]!.map((x) => CountryData.fromJson(x))),
    );
  }

}

class CountryData {
  CountryData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.recruitmentPrice,
    required this.nonMuslimPrice,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final num? recruitmentPrice;
  final num? nonMuslimPrice;

  factory CountryData.fromJson(Map<String, dynamic> json){
    return CountryData(
      id: json["id"] ?? 0,
      title: json["title"]?? "",
      description: json["description"]?? "",
      image: json["image"]?? "",
      recruitmentPrice: json["recruitment_price"]?? "",
      nonMuslimPrice: json["non_muslim_price"]?? "",
    );
  }

}
//////////////////////////////////////////////////

////////////////////StaticticsModel////////////////////
class Statictics {
  Statictics({
    required this.data,
  });

  final List<StaticticsDatum> data;

  factory Statictics.fromJson(Map<String, dynamic> json){
    return Statictics(
      data: json["data"] == null ? [] : List<StaticticsDatum>.from(json["data"]!.map((x) => StaticticsDatum.fromJson(x))),
    );
  }

}

class StaticticsDatum {
  StaticticsDatum({
    required this.title,
    required this.icon,
    required this.number,
  });

  final String? title;
  final String? icon;
  final String? number;

  factory StaticticsDatum.fromJson(Map<String, dynamic> json){
    return StaticticsDatum(
      title: json["title"] ?? "",
      icon: json["icon"] ?? "",
      number: json["number"] ?? "",
    );
  }

}

//////////////////////////////////////////////////


//////////////////StepsModel////////////////////
class Steps {
  Steps({
    required this.data,
  });

  final StepsInnerData? data;

  factory Steps.fromJson(Map<String, dynamic> json){
    return Steps(
      data: json["data"] == null ? null : StepsInnerData.fromJson(json["data"]),
    );
  }

}

class StepsInnerData {
  StepsInnerData({
    required this.title,
    required this.recruitmentStepDesc,
    required this.recruitmentStep1Desc,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.recruitmentStep2Desc,
    required this.recruitmentStep3Desc,
    required this.recruitmentStep4Desc,
    required this.recruitmentStep5Desc,
  });

  final String? title;
  final String? recruitmentStepDesc;
  final String? recruitmentStep1Desc;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? recruitmentStep2Desc;
  final String? recruitmentStep3Desc;
  final String? recruitmentStep4Desc;
  final String? recruitmentStep5Desc;

  factory StepsInnerData.fromJson(Map<String, dynamic> json){
    return StepsInnerData(
      title: json["title"] ?? "",
      recruitmentStepDesc: json["recruitment_step_desc"]?? "",
      recruitmentStep1Desc: json["recruitment_step1_desc"]?? "",
      image1: json["image_1"]?? "",
      image2: json["image_2"]?? "",
      image3: json["image_3"]?? "",
      recruitmentStep2Desc: json["recruitment_step2_desc"]?? "",
      recruitmentStep3Desc: json["recruitment_step3_desc"]?? "",
      recruitmentStep4Desc: json["recruitment_step4_desc"]?? "",
      recruitmentStep5Desc: json["recruitment_step5_desc"]?? "",
    );
  }

}

//////////////////////////////////////////////////

//////////////////SettingsModel////////////////////
class Settings {
  Settings({
    required this.data,
  });

  final SettingsData? data;

  factory Settings.fromJson(Map<String, dynamic> json){
    return Settings(
      data: json["data"] == null ? null : SettingsData.fromJson(json["data"]),
    );
  }

}

class SettingsData {
  SettingsData({
    required this.tapLogo,
    required this.headerLogo,
    required this.footerLogo,
    required this.title,
    required this.footerDesc,
    required this.phone1,
    required this.phone2,
    required this.phone3,
    required this.phone4,
    required this.phone5,
    required this.phone6,
    required this.phone7,
    required this.address1,
    required this.address2,
    required this.lat,
    required this.long,
    required this.email,
    required this.email2,
    required this.facebook,
    required this.linkedIn,
    required this.twitter,
    required this.instagram,
    required this.whatsApp,
    required this.snapchat,
    required this.telegram,
    required this.youtube,
    required this.gmail,
    required this.termsPageLink,
    required this.privacyPageLink,
    required this.headerTitle,
    required this.headerDesc,
    required this.aboutUs,
    required this.delivery,
    required this.security,
    required this.license,
    required this.service,
    required this.mainColor,
  });

  final String? tapLogo;
  final String? headerLogo;
  final String? footerLogo;
  final String? title;
  final String? footerDesc;
  final String? phone1;
  final String? phone2;
  final String? phone3;
  final String? phone4;
  final String? phone5;
  final String? phone6;
  final String? phone7;
  final String? address1;
  final dynamic address2;
  final num? lat;
  final num? long;
  final dynamic email;
  final String? email2;
  final String? facebook;
  final String? linkedIn;
  final String? twitter;
  final String? instagram;
  final String? whatsApp;
  final String? snapchat;
  final String? telegram;
  final String? youtube;
  final String? gmail;
  final dynamic termsPageLink;
  final dynamic privacyPageLink;
  final String? headerTitle;
  final String? headerDesc;
  final String? aboutUs;
  final String? delivery;
  final String? security;
  final String? license;
  final String? service;
  final String? mainColor;

  factory SettingsData.fromJson(Map<String, dynamic> json){
    return SettingsData(
      tapLogo: json["tap_logo"] ?? "",
      headerLogo: json["header_logo"]?? "",
      footerLogo: json["footer_logo"]?? "",
      title: json["title"]?? "",
      footerDesc: json["footer_desc"]?? "",
      phone1: json["phone_1"]?? "",
      phone2: json["phone_2"]?? "",
      phone3: json["phone_3"]?? "",
      phone4: json["phone_4"]?? "",
      phone5: json["phone_5"]?? "",
      phone6: json["phone_6"]?? "",
      phone7: json["phone_7"]?? "",
      address1: json["address_1"]?? "",
      address2: json["address_2"]?? "",
      lat: json["lat"]?? "",
      long: json["long"]?? "",
      email: json["email"]?? "",
      email2: json["email_2"]?? "",
      facebook: json["facebook"]?? "",
      linkedIn: json["linked_in"]?? "",
      twitter: json["twitter"]?? "",
      instagram: json["instagram"]?? "",
      whatsApp: json["whats_app"]?? "",
      snapchat: json["snapchat"]?? "",
      telegram: json["telegram"]?? "",
      youtube: json["youtube"]?? "",
      gmail: json["gmail"]?? "",
      termsPageLink: json["terms_page_link"]?? "",
      privacyPageLink: json["privacy_page_link"]?? "",
      headerTitle: json["header_title"]?? "",
      headerDesc: json["header_desc"]?? "",
      aboutUs: json["about_us"]?? "",
      delivery: json["delivery"]?? "",
      security: json["security"]?? "",
      license: json["license"]?? "",
      service: json["service"]?? "",
      mainColor: json["main_color"]?? "",
    );
  }

}

///////////////////////////////////////////////


////////////////////////////order response model//////////////////////

class OrderResponseModel {
  OrderResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final OrderResponseInnerData? data;

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    status: json["status"],
    message: json["message"],
    data: OrderResponseInnerData.fromJson(json["data"]),
  );


}


class OrderResponseInnerData {
  OrderResponseInnerData( {
    required this.id,
    required this.cv,
    required this.order_date,
    required this.status,
    required this.longitude,
    required this.latitude,
    required this.rent_start_date,
    required this.rent_end_date,
    this.isExpanded = false,



  });


  final int? id;
  final CvElement? cv;
 final String? order_date;
  final String? status;
  final String? longitude;
  final String? latitude;
  final String? rent_start_date;
  final String? rent_end_date;
   bool isExpanded;

  factory OrderResponseInnerData.fromJson(Map<String, dynamic> json) => OrderResponseInnerData(
    id: json["id"],
    cv: CvElement.fromJson(json["cv"]),
    order_date: json["order_date"],
    status: json["status"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    rent_start_date: json["rent_start_date"],
    rent_end_date: json["rent_end_date"],
  );


}