import 'package:equatable/equatable.dart';

class WorkGroupEntity extends Equatable {
  final int? id;
  final String groupName;

  WorkGroupEntity({
    this.id,
    required this.groupName,
  });
  
  @override
  List<Object?> get props => [id];
}
