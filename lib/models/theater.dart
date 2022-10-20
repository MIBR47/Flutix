part of 'models.dart';

class TheaterModel extends Equatable {
  final String? name;
  const TheaterModel(this.name);
  @override
  List<Object?> get props => [name];
}

List<TheaterModel> dummyTheaters = [
  const TheaterModel("CGV 23 Paskla Hyper Square"),
  const TheaterModel("CGV Paris Van Java"),
  const TheaterModel("XII Cihampelas Walk"),
  const TheaterModel("Xii Bandung Trade Center"),
];
