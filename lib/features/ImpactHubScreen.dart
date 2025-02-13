import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart' show FadeInLeft, FadeIn;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impact Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
      ),
      home: const ImpactHubScreen(),
    );
  }
}

class ImpactHubScreen extends StatefulWidget {
  const ImpactHubScreen({Key? key}) : super(key: key);

  @override
  _ImpactHubScreenState createState() => _ImpactHubScreenState();
}

class _ImpactHubScreenState extends State<ImpactHubScreen> {
  late Future<List<Topic>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _topicsFuture = fetchTopics();
  }

  Future<List<Topic>> fetchTopics() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Topic(
        'ImpactForge',
        Icons.build,
        Colors.blue[100]!,
        'Collaborative workspace for social impact projects',
      ),
      Topic(
        'LiveLabs',
        Icons.computer,
        Colors.orange[100]!,
        'Real-time experimentation and prototyping environment',
      ),
      Topic(
        'EarnWise',
        Icons.attach_money,
        Colors.purple[100]!,
        'Financial empowerment and wealth management hub',
      ),
      Topic(
        'HubHive',
        Icons.group_work,
        Colors.green[100]!,
        'Community-driven collaboration and networking space',
      ),
      Topic(
        'ChangeLab',
        Icons.settings,
        Colors.red[100]!,
        'Innovation lab for systemic change initiatives',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: const Text('Impact Hub'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<Topic>>(
        future: _topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No topics found.'));
          } else {
            final topics = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: topics.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return HoverAnimation(
                    topic: topics[index],
                    index: index,
                    onTap: () => _onTopicPressed(topics[index].title),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void _onTopicPressed(String title) {
    // Navigation logic here
  }
}

class HoverAnimation extends StatefulWidget {
  final Topic topic;
  final int index;
  final VoidCallback onTap;

  const HoverAnimation({
    Key? key,
    required this.topic,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  _HoverAnimationState createState() => _HoverAnimationState();
}

class _HoverAnimationState extends State<HoverAnimation> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: FadeInLeft(
          delay: Duration(milliseconds: widget.index * 150),
          child: TopicCard(
            topic: widget.topic,
            index: widget.index,
            isHovered: _isHovered,
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int index;
  final bool isHovered;
  final VoidCallback onTap;

  const TopicCard({
    Key? key,
    required this.topic,
    required this.index,
    required this.isHovered,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isHovered ? 0.2 : 0.1),
              spreadRadius: isHovered ? 2 : 1,
              blurRadius: isHovered ? 10 : 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              _buildIndicator(),
              const SizedBox(width: 20),
              _buildContent(),
              const Spacer(),
              _buildArrow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Container(
      width: 6,
      height: 50,
      decoration: BoxDecoration(
        color: _getColorForIndex(),
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            _getColorForIndex().withOpacity(0.8),
            _getColorForIndex().withOpacity(0.4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(topic.icon, color: _getColorForIndex(), size: 28),
            const SizedBox(width: 12),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(
            topic.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return AnimatedRotation(
      turns: isHovered ? 0.1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: _getColorForIndex(),
        size: 20,
      ),
    );
  }

  Color _getColorForIndex() {
    const colors = [Colors.blue, Colors.orange, Colors.purple, Colors.green, Colors.red];
    return colors[index % colors.length];
  }
}

class Topic {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  Topic(this.title, this.icon, this.color, this.description);
}