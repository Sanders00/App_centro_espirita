import 'package:common/features/work_group/domain/work_group.dart';

class WorkGroupModel extends WorkGroupEntity {
  WorkGroupModel({
    required super.id,
    required super.name,
    required super.desc,
  });

  factory WorkGroupModel.fromJson(Map<String, dynamic> json) {
    return WorkGroupModel(
      id: json['work_group_id'] as int,
      name: json['name'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'work_group_id': id, 'name': name, 'desc': desc};
  }
}
