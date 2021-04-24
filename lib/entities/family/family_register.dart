import 'family.dart';
import 'family_member_register.dart';

class FamilyRegister {
  
  Family family = Family ();
  List<FamilyMemberRegister> membersUsers = [];

  FamilyRegister() {}

  FamilyRegister.fromJsonMap(Map<String, dynamic> json) {
    family = Family.fromJsonMap(json['family']);
    membersUsers = json['membersUsers'];
  }

  Map toJson() => {
        'family': family,
        'membersUsers': membersUsers,
      };
}
