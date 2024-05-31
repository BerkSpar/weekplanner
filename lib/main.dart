import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final activities = [
  Activity(
    title: "Planning",
    subtitle: "Set time for tasks",
    duration: const Duration(hours: 1),
    kind: Kind.handsOn,
    weekday: Weekday.monday,
  ),
  Activity(
    title: "Define",
    subtitle: "Big idea and essential questions",
    duration: const Duration(hours: 1),
    kind: Kind.handsOn,
    weekday: Weekday.monday,
  ),
  Activity(
    title: "Matriz CSD",
    subtitle: "Guiding questions",
    duration: const Duration(minutes: 30),
    kind: Kind.handsOn,
    weekday: Weekday.monday,
  ),
  Activity(
    title: "Desk Research",
    duration: const Duration(minutes: 30),
    kind: Kind.handsOn,
    weekday: Weekday.monday,
  ),
  // Tuesday
  Activity(
    title: "Plan Interview",
    subtitle:
        "Elaborate forms/questions, reach out to users and schedule interviews.",
    duration: const Duration(hours: 2, minutes: 30),
    kind: Kind.handsOn,
    weekday: Weekday.tuesday,
  ),
  Activity(
    title: "Validate",
    subtitle: "Ask mentors",
    duration: const Duration(minutes: 30),
    kind: Kind.talk,
    weekday: Weekday.tuesday,
  ),
  // Wednesday
  Activity(
    title: "Status Report II",
    duration: const Duration(hours: 1),
    kind: Kind.presentation,
    weekday: Weekday.wednesday,
  ),
  Activity(
    title: "Workshop",
    subtitle: "UX Cards",
    duration: const Duration(minutes: 45),
    kind: Kind.talk,
    weekday: Weekday.wednesday,
  ),
  Activity(
    title: "SOS Day",
    subtitle: "Go back to pendencies",
    duration: const Duration(minutes: 15, hours: 1),
    kind: Kind.handsOn,
    weekday: Weekday.wednesday,
  ),
  // Thursday
  Activity(
    title: "Interview",
    subtitle: "Make interviews and go to other places",
    duration: const Duration(hours: 1, minutes: 30),
    kind: Kind.handsOn,
    weekday: Weekday.thursday,
  ),
  Activity(
    title: "Benchmarking",
    subtitle: "Research for similar cases",
    duration: const Duration(hours: 1, minutes: 30),
    kind: Kind.handsOn,
    weekday: Weekday.thursday,
  ),
  // Friday
  Activity(
    title: "Interview",
    subtitle: "Make interviews and go to other places",
    duration: const Duration(hours: 2),
    kind: Kind.handsOn,
    weekday: Weekday.friday,
  ),
  Activity(
    title: "Documentation",
    subtitle: "Week 2 and 3",
    duration: const Duration(hours: 1),
    kind: Kind.tasks,
    weekday: Weekday.friday,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kind> selectedKinds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ActivityDialog();
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Investigate I",
                  style: TextStyle(
                    color: Color(0xFF64677C),
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const Spacer(),
                ...Kind.all
                    .map((kind) => KindItem(
                        kind: kind,
                        isActive: selectedKinds.isNotEmpty
                            ? selectedKinds.contains(kind)
                            : true,
                        onTap: () {
                          if (selectedKinds.contains(kind)) {
                            setState(() {
                              selectedKinds.remove(kind);
                            });
                            return;
                          }

                          setState(() {
                            selectedKinds.add(kind);
                          });
                        }))
                    .toList()
                    .withDivider(const SizedBox(width: 24))
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Weekday.all
                  .map((weekday) {
                    return Expanded(
                      child: WeekdayColumn(
                        weekday: weekday,
                        selectedKinds: selectedKinds,
                      ),
                    );
                  })
                  .toList()
                  .withDivider(const SizedBox(width: 32))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Kind {
  final String name;
  final Color primary;
  final Color dark;

  const Kind({
    required this.name,
    required this.primary,
    required this.dark,
  });

  static const all = [talk, handsOn, presentation, tasks];

  static const talk = Kind(
    name: "Talks/Workshops",
    primary: Color(0xFFD5EED1),
    dark: Color(0xFFB8E1B1),
  );

  static const handsOn = Kind(
    name: "Hands-on",
    primary: Color(0xFFDBE0FA),
    dark: Color(0xFFBBC3EE),
  );

  static const presentation = Kind(
    name: "Presentation",
    primary: Color(0xFFFFD5D5),
    dark: Color(0xFFF6B3B3),
  );

  static const tasks = Kind(
    name: "Tasks",
    primary: Color(0xFFFBE9BC),
    dark: Color(0xFFFFCF87),
  );
}

class Weekday {
  final String name;

  const Weekday({
    required this.name,
  });

  static const all = [
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
  ];

  static const monday = Weekday(name: "MONDAY");
  static const tuesday = Weekday(name: "TUESDAY");
  static const wednesday = Weekday(name: "WEDNESDAY");
  static const thursday = Weekday(name: "THURSDAY");
  static const friday = Weekday(name: "FRIDAY");
}

class Activity {
  String title;
  String? subtitle;
  Duration duration;
  Kind kind;
  Weekday weekday;

  Activity({
    required this.title,
    this.subtitle,
    required this.duration,
    required this.kind,
    required this.weekday,
  });
}

class ActivityDialog extends StatefulWidget {
  final Activity? activity;

  const ActivityDialog({
    super.key,
    this.activity,
  });

  @override
  State<ActivityDialog> createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  late Activity activity = widget.activity ??
      Activity(
        title: "",
        duration: const Duration(minutes: 30),
        kind: Kind.handsOn,
        weekday: Weekday.monday,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        decoration: ShapeDecoration(
          color: activity.kind.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: activity.title,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Color(0xFF141417),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: activity.subtitle,
              decoration: InputDecoration(
                hintText: "Write the description here...",
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Color(0xFF141417),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: activity.duration,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        activity.duration = value as Duration;
                      });
                    },
                    items: [
                      const Duration(minutes: 15),
                      const Duration(minutes: 30),
                      const Duration(minutes: 45),
                      const Duration(hours: 1),
                      const Duration(hours: 1, minutes: 15),
                      const Duration(hours: 1, minutes: 30),
                      const Duration(hours: 2),
                      const Duration(hours: 2, minutes: 30),
                      const Duration(hours: 3)
                    ]
                        .map((duration) => DropdownMenuItem(
                              value: duration,
                              child: Text(
                                duration.format(),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: activity.kind,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: Kind.all
                        .map((kind) => DropdownMenuItem(
                              value: kind,
                              child: Text(kind.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        activity.kind = value as Kind;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: activity.weekday,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: Weekday.all
                        .map((weekday) => DropdownMenuItem(
                              value: weekday,
                              child: Text(weekday.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        activity.weekday = value as Weekday;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KindItem extends StatelessWidget {
  final Kind kind;
  final VoidCallback? onTap;
  final bool isActive;

  const KindItem({
    super.key,
    required this.kind,
    this.onTap,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        Container(
          height: 24,
          width: 24,
          decoration: ShapeDecoration(
            color: isActive ? kind.primary : Colors.grey.shade300,
            shape: const CircleBorder(),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          kind.name,
          style: TextStyle(
            color: isActive ? const Color(0xFF1D1D1D) : Colors.grey,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }
}

class WeekdayColumn extends StatelessWidget {
  final Weekday weekday;
  final List<Kind> selectedKinds;

  const WeekdayColumn({
    super.key,
    required this.weekday,
    this.selectedKinds = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 700,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderCard(name: weekday.name),
          const SizedBox(height: 16),
          ...activities
              .where((activity) => activity.weekday == weekday)
              .map((activity) {
                return ActivityCard(
                  title: activity.title,
                  subtitle: activity.subtitle,
                  duration: activity.duration,
                  kind: activity.kind,
                  isSelected: selectedKinds.isNotEmpty
                      ? selectedKinds.contains(activity.kind)
                      : true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ActivityDialog(activity: activity);
                      },
                    );
                  },
                );
              })
              .toList()
              .withDivider(const SizedBox(height: 8)),
        ],
      ),
    );
  }
}

extension on List<Widget> {
  List<Widget> withDivider(Widget divider) {
    return List.generate(length * 2 - 1, (index) {
      if (index.isEven) {
        return this[index ~/ 2];
      } else {
        return divider;
      }
    });
  }
}

class HeaderCard extends StatelessWidget {
  final String name;

  const HeaderCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            name,
            style: const TextStyle(
              color: Color(0xFF585858),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Duration duration;
  final Kind kind;
  final bool isSelected;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    this.subtitle,
    required this.title,
    required this.kind,
    required this.duration,
    this.onTap,
    this.isSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: duration.inMinutes,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            color: isSelected ? kind.primary : Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Color(0xFF141417),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (subtitle != null)
                        Expanded(
                          child: Text(
                            subtitle!,
                            maxLines: 30,
                            style: const TextStyle(
                              color: Color(0xFF141417),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: isSelected ? kind.dark : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(duration.format()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Duration {
  String format() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    if (hours == 0) {
      return "${minutes}min";
    }

    if (minutes == 0) {
      return "${hours}h";
    }

    return "${hours}h$minutes";
  }
}
