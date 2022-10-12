part of 'models.dart';

class PromoModel extends Equatable {
  final String title;
  final String subtitle;
  final int discount;
  const PromoModel(
      {required this.title, required this.subtitle, required this.discount});

  @override
  List<Object?> get props => [title, subtitle, discount];
}

List<PromoModel> dumyPromos = [
  const PromoModel(
      title: "Student", subtitle: "Maximal only for two people", discount: 50),
  const PromoModel(
      title: "Family", subtitle: "Maximal only for three people", discount: 50),
  const PromoModel(
      title: "Subscription Promo",
      subtitle: "Maximal only for two people",
      discount: 50),
];
