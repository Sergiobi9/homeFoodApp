import 'family.dart';

class FamilyRegister {
  
  Family family = Family ();
  List<String> membersUserIds = [];

  FamilyRegister() {}

  FamilyRegister.fromJsonMap(Map<String, dynamic> json) {
    family = Family.fromJsonMap(json['family']);
    membersUserIds = json['membersUserIds'];
  }

  Map toJson() => {
        'family': family,
        'membersUserIds': membersUserIds,
      };
}
