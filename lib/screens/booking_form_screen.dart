import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state.dart';
import '../data/mock_cars.dart';
import 'confirmation_screen.dart';

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key});

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickDate(bool isStartDate) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      initialDate: today,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // using global variable directly
    final carId = ref.watch(appStateProvider).selectedCarId;
    final car = mockCars.firstWhere((c) => c.name == carId, orElse: () => mockCars.first);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBAD7E9).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBAD7E9).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.directions_car_filled,
                              color: Color(0xFF2B3467),
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Vehicle',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  car?.name ?? 'Not Selected',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2B3467),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${car?.price}/day',
                             style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEB455F),
                              ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Personal Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2B3467)),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      'Trip Details',
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF2B3467)),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => pickDate(true),
                            borderRadius: BorderRadius.circular(16),
                            child: IgnorePointer(
                              child: TextFormField(
                                key: ValueKey(startDate),
                                initialValue: startDate != null ? DateFormat('dd MMM yyyy').format(startDate!) : null,
                                decoration: const InputDecoration(
                                  labelText: 'Start Date',
                                  prefixIcon: Icon(Icons.calendar_today_outlined),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) => startDate == null ? 'Required' : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () => pickDate(false),
                            borderRadius: BorderRadius.circular(16),
                            child: IgnorePointer(
                              child: TextFormField(
                                key: ValueKey(endDate),
                                initialValue: endDate != null ? DateFormat('dd MMM yyyy').format(endDate!) : null,
                                decoration: const InputDecoration(
                                  labelText: 'End Date',
                                  prefixIcon: Icon(Icons.calendar_today_outlined),
                                   suffixIcon: Icon(Icons.arrow_drop_down),
                                   border: OutlineInputBorder(),
                                ),
                                validator: (value) => endDate == null ? 'Required' : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Pickup Location',
                        prefixIcon: Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ],
                ),
              ),
            ),
          ),

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
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2B3467), foregroundColor: Colors.white),
                onPressed: () {
                  if (formKey.currentState!.validate() && startDate != null && endDate != null) {
                    ref.read(appStateProvider.notifier).setBookingInfo(
                      name: nameController.text,
                      startDate: startDate!,
                      endDate: endDate!,
                      location: locationController.text,
                    );
                    
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ConfirmationScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                  }
                },
                child: const Text('Confirm Booking'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
