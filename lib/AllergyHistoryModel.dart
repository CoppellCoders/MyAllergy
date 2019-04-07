class AllergyHistoryModel {
  String food;
  List<String> ingrid;
  List<bool> isAllergic;
  String note;
  String date;

  AllergyHistoryModel(this.food,this.ingrid,this.note,this.date);

  String getFood(){
    return food;
  }

  String getNote(){
    return note;
  }
  String getDate(){
    return date;
  }
 List<String> getIngrid(){
    return ingrid;
  }


}