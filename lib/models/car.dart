// Simple Car model class
class Car {
  final String name;
  final int price;
  final String fuel;
  final int seats;
  final String category;
  final bool available;

  Car({
    required this.name,
    required this.price,
    required this.fuel,
    required this.seats,
    required this.category,
    this.available = true,
  });
}
