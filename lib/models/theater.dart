part of 'models.dart';

class TheaterModel extends Equatable {
  final String id;
  final String? name;
  final List<Map<String, dynamic>>? price;
  final int fee;
  const TheaterModel(this.id, this.name, this.price, this.fee);
  @override
  List<Object?> get props => [name];
}

List<TheaterModel> dummyTheaters = [
  const TheaterModel(
      '001',
      "CGV 23 Paskla Hyper Square",
      [
        {
          'priceOnWeekday': 40000,
          'priceOnWeekend': 75000,
        }
      ],
      5000),
  const TheaterModel(
      '002',
      "CGV Paris Van Java",
      [
        {
          'priceOnWeekday': 40000,
          'priceOnWeekend': 75000,
        }
      ],
      5000),
  const TheaterModel(
      '003',
      "XII Cihampelas Walk",
      [
        {
          'priceOnWeekday': 40000,
          'priceOnWeekend': 75000,
        }
      ],
      5000),
  const TheaterModel(
      '004',
      "Xii Bandung Trade Center",
      [
        {
          'priceOnWeekday': 40000,
          'priceOnWeekend': 75000,
        }
      ],
      5000),
];
