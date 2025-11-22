import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:equatable/equatable.dart';

class DeviceModel extends Equatable{
  final String name;
  final String id;
  final DeviceType type;

  const DeviceModel({required this.name, required this.type, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,type];
}
