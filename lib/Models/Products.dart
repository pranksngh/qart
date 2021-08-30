
import 'dart:convert';

List<Products> productFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Products {

  String? Season;
  String? Brand;
  String ?QRCode;
  String ?Option;
  String ? AvailableSizes;
  String ? ImageUrl;
  String ? Color;
  double ? MRP;
  String ? Description;
  String ? Theme;
  String ?TechnologyImageUrl;
  String ? OfferMonths;
  double ? Likeabilty;
  String ? Mood;
  String ? Gender;
  String ? Fit;
  String ? Collection;
  String ? Finish;
  String ? SubCategory;
  String ? Name;
  String ? Category;
  String ? EAN;

  Products({
   this.Season,
   this.Brand,
   this.QRCode,
   this.Option,
   this.AvailableSizes,
   this.Color,
   this.ImageUrl,
   this.MRP,
   this.Collection,
   this.Description,
   this.Fit,
   this.Gender,
   this.Likeabilty,
   this.Mood,
   this.OfferMonths,
  this.TechnologyImageUrl,
   this.Theme,
   this.Finish,
   this.Name,
   this.SubCategory,
   this.Category,
   this.EAN,

    
  });

 factory Products.fromJson(Map<String, dynamic> json) => Products(
       Season: json['Season'],
       Brand: json['Brand'],
       QRCode: json['QRCode'],
       Option: json['Option'],
       AvailableSizes: json['AvailableSizes'].toString(),
       Color: json['Color'],
       ImageUrl: json['ImageUrl'],
       MRP: json['MRP'],
       Description: json['Description'],
       Mood: json['Mood'],
       Fit: json['Fit'],
       Likeabilty: json['Likeabilty'],
       TechnologyImageUrl: json['TechnologyImageUrl'],
       Theme: json['Theme'],
       Gender: json['Gender'],
       OfferMonths: json['OfferMonths'].toString(),
       Collection: json['Collection'],
       Name: json['Name'],
       SubCategory: json['SubCategory'],
       Finish: json['Finish'],
       Category : json['Category'],
       EAN: json['EAN'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Season": Season,
       "Brand": Brand,
       "QRCode": QRCode,
        "Option": Option,
        "Color": Color, 
        "AvailableSizes": AvailableSizes, 
        "ImageUrl": ImageUrl,
        "MRP":MRP,
        "Description": Description,
        "Mood":Mood,
        "Fit":Fit,
        "Likeabilty":Likeabilty,
        "TechnologyImageUrl":TechnologyImageUrl,
        "Theme":Theme,
        "Gender":Gender,
        "OfferMonths":OfferMonths,
        "Collection": Collection,
        "Name" : Name,
        "Finish": Finish,
        "SubCategory": SubCategory,
        "Category": Category,
        "EAN" : EAN,

      };
}