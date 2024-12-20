import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/action_button.dart';
import '../components/holiday_list.dart';
import '../cubit/holiday_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HolidayCubit>().fetchHolidays();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Holidays',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal,
              Colors.tealAccent,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Upcoming Holidays',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'View the list of public holidays in England and Wales.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<HolidayCubit, HolidayState>(
                  builder: (context, state) {
                    if (state is HolidayLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HolidayLoaded) {
                      return HolidayList(holidays: state.holidays);
                    } else if (state is HolidayError) {
                      return Center(
                        child: Text(
                          'Error: ${state.message}',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    }
                    return const Center(child: Text('No holidays available'));
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ActionButton(
                  text: 'Go to Profile',
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
