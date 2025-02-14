import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart' show FadeInLeft;

class AllTopicsScreen extends StatefulWidget {
  const AllTopicsScreen({Key? key}) : super(key: key);

  @override
  _AllTopicsScreenState createState() => _AllTopicsScreenState();
}

class _AllTopicsScreenState extends State<AllTopicsScreen> {
  final List<Topic> topics = [
    Topic(
      'Edubank',
      Icons.school,
      Colors.blue[100]!,
      "Financial literacy resources for students.",
      Colors.blue,
    ),
    Topic(
      'Geogigs',
      Icons.location_on,
      Colors.orange[100]!,
      "Connecting students with local learning opportunities.",
      Colors.green,
    ),
    Topic(
      'Nanocerts',
      Icons.verified,
      Colors.purple[100]!,
      "Skill-based certifications for career readiness.",
      Colors.purple,
    ),
    Topic(
      'SmartStudy',
      Icons.lightbulb,
      Colors.green[100]!,
      "Personalized learning plans for every student.",
      Colors.orange,
    ),
    Topic(
      'CareerGenie',
      Icons.work,
      Colors.red[100]!,
      "Guidance for students to explore future career paths.",
      Colors.red,
    ),
    Topic(
      'Voice Voyage',
      Icons.mic,
      Colors.pink[100]!,
      "Improve communication skills through interactive exercises.",
      Colors.pink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Topics'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTopicPressed(String title) {
    print('$title tapped!');
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
  final bool isHovered;
  final VoidCallback onTap;

  const TopicCard({
    Key? key,
    required this.topic,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(topic.icon, color: topic.accentColor, size: 28),
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
                        topic.details,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedRotation(
                turns: isHovered ? 0.1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: topic.accentColor,
                  size: 20,
                ),
              ),
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
        color: topic.accentColor,
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            topic.accentColor.withOpacity(0.8),
            topic.accentColor.withOpacity(0.4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class Topic {
  final String title;
  final IconData icon;
  final Color color;
  final String details;
  final Color accentColor;

  Topic(this.title, this.icon, this.color, this.details, this.accentColor);
}