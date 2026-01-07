import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/globals.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final car = GlobalData.selectedCar!;
    
    final days = GlobalData.startDate != null && GlobalData.endDate != null
        ? GlobalData.endDate!.difference(GlobalData.startDate!).inDays + 1
        : 1;
    final totalCost = days * car.price;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    
                    // Success Circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(Icons.check_circle_rounded, color: Colors.green.shade600, size: 80),
                    ),
                    
                    const SizedBox(height: 32),
                    Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF2B3467),
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your car is ready for pick up',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Summary Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: [
                           Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                _DetailRow(label: 'Car Model', value: car.name, isBold: true),
                                const Divider(height: 32),
                                _DetailRow(label: 'Customer', value: GlobalData.name),
                                const SizedBox(height: 16),
                                _DetailRow(label: 'Pickup', value: GlobalData.location),
                                const SizedBox(height: 16),
                                _DetailRow(
                                  label: 'Duration', 
                                  value: '${DateFormat('d MMM').format(GlobalData.startDate!)} - ${DateFormat('d MMM').format(GlobalData.endDate!)} ($days Days)'
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Color(0xFF2B3467).withOpacity(0.05),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Paid',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2B3467),
                                  ),
                                ),
                                Text(
                                  '₹$totalCost',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2B3467),
                                  ),
                                ),
                              ],
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
          
          // Home Button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2B3467),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/cars', (_) => false);
                },
                child: const Text('Back to Home'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: Color(0xFF2B3467),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
