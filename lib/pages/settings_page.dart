import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final schedulingProvider =
    ChangeNotifierProvider((ref) => SchedulingProvider());

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<SharedPreferences> sharedPreferencesAsyncValue =
        ref.watch(sharedPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: sharedPreferencesAsyncValue.when(
        data: (prefs) {
          // Retrieve the switch state from SharedPreferences
          final bool notificationSwitch =
              prefs.getBool('notificationSwitch') ?? false;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SwitchButton(
                  context: context,
                  ref: ref,
                  notificationSwitch: notificationSwitch,
                  prefs: prefs),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          // Handle error
          return const Center(child: Text('Error fetching SharedPreferences'));
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class SwitchButton extends StatefulWidget {
  SwitchButton({
    super.key,
    required this.context,
    required this.ref,
    required this.notificationSwitch,
    required this.prefs,
  });

  final BuildContext context;
  final WidgetRef ref;
  final SharedPreferences prefs;
  bool notificationSwitch;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant Notification',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              'Enable Notification',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Switch(
          value: widget.notificationSwitch,
          onChanged: (value) async {
            setState(() {
              widget.notificationSwitch = value;
              widget.prefs.setBool('notificationSwitch', value);
            });

            // If the switch is turned on, schedule the restaurant notification
            if (value) {
              widget.ref.read(schedulingProvider).scheduledRestaurant(value);
            } else {
              // If the switch is turned off, cancel the scheduled restaurant notification
              widget.ref.read(schedulingProvider).cancelScheduledRestaurant();
            }
          },
        ),
      ],
    );
  }
}
