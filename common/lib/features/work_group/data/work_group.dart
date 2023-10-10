import 'package:common/features/work_group/domain/work_group.dart';

class WorkGroupModel extends WorkGroupEntity {
  WorkGroupModel({
    required super.id,
    required super.groupName,
  });

  factory WorkGroupModel.fromJson(Map<String, dynamic> json) {
    return WorkGroupModel(
      id: json['id'] as int,
      groupName: json['groupName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
    };
  }
}
