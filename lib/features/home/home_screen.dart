import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'ImpactHubScreen.dart';
import '../Profile/ProfilePage.dart'; // Ensure this import is correct

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> testimonials = const [
    {
      'text':
          "Edu Bridge isn't just an app; it's a lifeline for students like me who want to learn, grow, and make a difference.",
      'author': "Sejal Bejaj",
      'color': Colors.grey,
      'icon': Icons.format_quote,
    },
    {
      'text':
          "I love the edutainment videos—they make learning so fun! Plus, the skill exchange helped me pick up coding basics. Amazing app!",
      'author': "Suraj Khairnar",
      'color': Color.fromARGB(255, 209, 179, 206),
      'icon': Icons.format_quote,
    },
    {
      'text':
          "The best educational platform I've used. The courses are comprehensive and the community support is fantastic!",
      'author': "Rahul Sharma",
      'color': Colors.blue,
      'icon': Icons.format_quote,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context), // Pass context here
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildServicesSection(context),
                const SizedBox(height: 20),
                _buildImageCards(),
                const SizedBox(height: 20),
                _buildTestimonials(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello,",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Bhavik Patil",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('👋'),
                        WavyAnimatedText('👋'),
                        WavyAnimatedText('👋'),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        print("Wave icon tapped");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                _navigateToProfile(context); // Call the navigation method here
              },
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
  Widget _buildSearchBar() {
    TextEditingController searchController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      _performSearch(value);
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    _performSearch(searchController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/search.png',
                      height: 18,
                      width: 18,
                      color: Colors.orange[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            print("Settings icon tapped");
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.settings,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      print("Searching for: $query");
    } else {
      print("Please enter a search term");
    }
  }

  Widget _buildServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Services",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[100]!, Colors.blue[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildServiceButton(
                      context,
                      "All Topics",
                      Icons.trending_up,
                      Colors.cyan[100]!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildServiceButton(
                      context,
                      "Skills Swap",
                      Icons.psychology,
                      Colors.green[50]!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildServiceButton(
                      context,
                      "Launch Pad",
                      Icons.rocket_launch_rounded,
                      Colors.purple[50]!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildServiceButton(
                      context,
                      "Impact Hub",
                      Icons.hub,
                      Colors.pink[50]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
Widget _buildServiceButton(
      BuildContext context, String text, IconData icon, Color color) {
    return ElevatedButton(
      onPressed: () {
        if (text == "All Topics") {
          Navigator.pushNamed(context, '/all-topics');
        } else if (text == "Impact Hub") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ImpactHubScreen(),
            ),
          );
        } else if (text == "Skills Swap") {
          Navigator.pushNamed(context, '/skill-swap');
        } else if (text == "Launch Pad") {
          // Corrected: Ensure no trailing space
          Navigator.pushNamed(
              context, '/launchpad'); // Navigate to LaunchPadScreen
        } else {
          print("$text button pressed"); // Default case for debugging
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildImageCards() {
    final List<Map<String, dynamic>> courses = [
      {
        "image": "assets/images/Ngo.jpg",
        "title": "Introduction to Flutter",
        "description": "Learn the basics of Flutter development.",
        "rating": "4.5 â­",
      },
      {
        "image": "assets/images/ngo2.jpg",
        "title": "UI/UX Design",
        "description": "Master the art of designing user interfaces.",
        "rating": "4.7 â­",
      },
      {
        "image": "assets/images/course3_thumbnail.png",
        "title": "Data Science Basics",
        "description": "Get started with data science and machine learning.",
        "rating": "4.8 â­",
      },
      {
        "image": "assets/images/course4_thumbnail.png",
        "title": "Web Development",
        "description": "Build responsive websites from scratch.",
        "rating": "4.6 â­",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Featured Courses",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailsScreen(course: course),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildCourseCard(course),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              course["image"],
              height: 80, // Reduced from 120
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course["title"],
                  style: const TextStyle(
                    fontSize: 15, // Reduced from 16
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  course["description"],
                  style: TextStyle(
                    fontSize: 11, // Reduced from 12
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      course["rating"],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "What Our Users Say",
            style: TextStyle(
              fontSize: 18, // Reduced from 20
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        SizedBox(
          height: 150, // Reduced from 180
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final testimonial = testimonials[index];
              return FadeIn(
                delay: Duration(milliseconds: index * 200),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // Reduced from 0.85
                  margin: const EdgeInsets.only(right: 12),
                  child: _buildTestimonialCard(
                    testimonial['text'] as String,
                    testimonial['author'] as String,
                    testimonial['color'] as Color,
                    testimonial['icon'] as IconData,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(
      String text, String author, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15), // Reduced from 20
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15), // Slightly smaller radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1, // Reduced from 2
            blurRadius: 6, // Reduced from 8
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 28, // Reduced from 32
            color: color.withOpacity(0.4),
          ),
          Expanded(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  text,
                  textStyle: TextStyle(
                    fontSize: 13, // Reduced from 14
                    height: 1.3, // Tighter line spacing
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                  ),
                  speed: const Duration(
                      milliseconds: 40), // Slightly faster typing
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
          ),
          const SizedBox(height: 8), // Reduced from 10
          Text(
            "- $author",
            style: TextStyle(
              fontSize: 12, // Reduced from 14
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavBarWithAnimation();
  }
}
class BottomNavBarWithAnimation extends StatefulWidget {
  const BottomNavBarWithAnimation({super.key});

  @override
  _BottomNavBarWithAnimationState createState() =>
      _BottomNavBarWithAnimationState();
}

class _BottomNavBarWithAnimationState extends State<BottomNavBarWithAnimation>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (index == 4) { // Edutok index
      Navigator.pushNamed(context, '/edutok');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Trending',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Resources',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ondemand_video),
          label: 'Edutok',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onNavItemTapped, // Updated handler
      type: BottomNavigationBarType.fixed,
    );
  }
}
class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeIn({super.key, required this.child, required this.delay});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailsScreen({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  course["image"],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error_outline),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                course['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course['description'],
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    course['rating'],
                    style: const TextStyle(fontSize: 16),
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

// Add these after CourseDetailsScreen but before BottomNavBarWithAnimation
class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending')),
      body: const Center(child: Text('Trending Content')),
    );
  }
}

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: const Center(child: Text('Educational Resources')),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('Notification Center')),
    );
  }
}
