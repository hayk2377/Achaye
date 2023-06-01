import '../../suggestions/models/profile.dart';

class ProfileLog extends Profile {
  String? recentTyped;
  DateTime? time;

  ProfileLog(
      {this.recentTyped,
       this.time,
      super.name,
      super.id,
      super.image});

}
