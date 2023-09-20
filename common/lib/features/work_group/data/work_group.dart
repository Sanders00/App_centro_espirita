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

  Map<String, dynamic> toJson(WorkGroupModel instance) {
    return {'id': instance.id, 'groupName': instance.groupName};
  }
}
