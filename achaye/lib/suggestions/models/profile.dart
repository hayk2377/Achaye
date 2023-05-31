import 'package:equatable/equatable.dart';

class Profile extends Equatable{
  final String? name;
  final String? distance;
  final String? image;
  final int? id;
  const Profile({this.name, this.distance, this.image, this.id});
  
  @override
  List<Object?> get props => [name, distance, image, id];
  
}
