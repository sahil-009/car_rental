import '../models/car.dart';

// Mock data for cars - no backend needed
final List<Car> mockCars = [
  Car(
    name: 'Honda City',
    price: 1200,
    fuel: 'Petrol',
    seats: 5,
    category: 'Sedan',
    available: true,  // Available
  ),
  Car(
    name: 'Fortuner',
    price: 3000,
    fuel: 'Petrol',
    seats: 5,
    category: 'Luxury',
    available: true,  // Available
  ),
  Car(
    name: 'Hyundai Creta',
    price: 1800,
    fuel: 'Diesel',
    seats: 5,
    category: 'SUV',
    available: false,  // NOT Available
  ),
  Car(
    name: 'Toyota Innova',
    price: 2500,
    fuel: 'Diesel',
    seats: 7,
    category: 'SUV',
    available: true,  // Available
  ),
  Car(
    name: 'Mahindra Thar',
    price: 3000,
    fuel: 'Diesel',
    seats: 4,
    category: 'SUV',
    available: false,  // NOT Available
  ),
  Car(
    name: 'Tata Nexon',
    price: 1500,
    fuel: 'Petrol',
    seats: 5,
    category: 'SUV',
    available: true,  // Available
  ),
  Car(
    name: 'Land Rover Defender',
    price: 5000,
    fuel: 'Diesel',
    seats: 5,
    category: 'Luxury',
    available: true,
  ),
];
