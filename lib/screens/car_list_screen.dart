import 'package:flutter/material.dart';
import '../data/mock_cars.dart';
import '../utils/globals.dart';
import 'car_details_screen.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
      ),
      body: ListView.builder(
        itemCount: mockCars.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final car = mockCars[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF2B3467).withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                   if (!car.available) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sorry, this car is currently unavailable'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  GlobalData.selectedCar = car;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                       // Car Image Placeholder
                      Container(
                        width: 110,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(0xFFBAD7E9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.directions_car_filled_outlined,
                          size: 40,
                          color: Color(0xFF2B3467).withOpacity(0.6),
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Car Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    car.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2B3467),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (!car.available)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Booked',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // Features
                            Row(
                              children: [
                                _FeatureIcon(icon: Icons.local_gas_station, text: car.fuel),
                                const SizedBox(width: 16),
                                _FeatureIcon(icon: Icons.event_seat, text: '${car.seats} Seats'),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Price
                            Text(
                              '₹${car.price}/day',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEB455F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureIcon({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}
