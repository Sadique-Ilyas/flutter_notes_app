
class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  int get priority => _priority;

  String get date => _date;

  String get description => _description;

  String get title => _title;

  int get id => _id;

  set priority(int value) {
    if(value >= 1 && value <= 2) {
     this._priority = value;
    }
  }

  set date(String value) {
    this._date = value;
  }

  set description(String value) {
    if(value.length <=255) {
      this._description = value;
    }
  }

  set title(String value) {
    if(value.length <=255) {
      this._title = value;
    }
  }

  set id(int value) {
    this._id = value;
  }

  //Convert a Note Object into a Map Object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //Extract a Note object from a Map Object
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}