import 'package:hive/hive.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';

class ElementModelAdapter extends TypeAdapter<ElementModel> {
  @override
  final int typeId = 1;

  @override
  ElementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ElementModel(
      atomicNumber: fields[0] as int,
      symbol: fields[1] as String,
      name: fields[2] as String,
      category: fields[3] as String,
      categoryType: ElementCategoryType.values[fields[4] as int],
      atomicMass: fields[5] as String,
      summary: fields[6] as String,
      dailyLifeUse: fields[7] as String,
      discoveredBy: fields[8] as String,
      isCompound: fields[9] as bool,
      colorValue: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ElementModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.atomicNumber)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.categoryType.index)
      ..writeByte(5)
      ..write(obj.atomicMass)
      ..writeByte(6)
      ..write(obj.summary)
      ..writeByte(7)
      ..write(obj.dailyLifeUse)
      ..writeByte(8)
      ..write(obj.discoveredBy)
      ..writeByte(9)
      ..write(obj.isCompound)
      ..writeByte(10)
      ..write(obj.colorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElementModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
