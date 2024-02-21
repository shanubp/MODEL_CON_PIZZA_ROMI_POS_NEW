class Brands{

  String? category;
  String? image;
  String? id;
  Brands({ this.category, this.image, this.id});
  Brands.fromMapObject(Map<String,dynamic> map){

    this.category=map['category'];
    this.image=map['image'];
     this.id=map['id'];



  }


}