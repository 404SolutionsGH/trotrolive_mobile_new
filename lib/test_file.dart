import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/widgets/shimmer_effect.dart';
import 'theme/bloc/theme_bloc.dart';
import 'theme/bloc/theme_event.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final Dio _dio = Dio();
  List<dynamic> _events = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    loadCachedEvents();
    fetchEvents();
  }

  Future<void> loadCachedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_events');

    if (cachedData != null) {
      final decoded = jsonDecode(cachedData);
      setState(() {
        _events = decoded;
        _isLoading = false;
      });
    }
  }

  Future<void> cacheEvents(List<dynamic> events) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_events', jsonEncode(events));
  }

  Future<void> fetchEvents() async {
    try {
      final response =
          await _dio.get('https://angularworldclub.com/api/executives');
      debugPrint('FULL RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        final body = response.data;
        final fetchedEvents = body['executives'] ?? [];

        await cacheEvents(fetchedEvents);

        setState(() {
          _events = fetchedEvents;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch events.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              fetchEvents();
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          )
        ],
      ),
      body: _isLoading
          ? const StationShimmerTile()
          : _error != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (_, index) {
                    final event = _events[index];

                    return ListTile(
                      leading: event['profileImageUrl'] != null &&
                              event['profileImageUrl']
                                  .toString()
                                  .startsWith('data:image')
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                base64Decode(
                                  event['profileImageUrl']
                                      .toString()
                                      .split(',')
                                      .last,
                                ),
                              ),
                            )
                          : const CircleAvatar(child: Icon(Icons.event)),
                      title: Text(event['fullname']?.toString() ?? 'No Title'),
                      subtitle: Text(event['email']?.toString() ?? 'No Date'),
                      trailing: Text(event['membershipCode']?.toString() ?? ''),
                    );
                  },
                ),
    );
  }
}
