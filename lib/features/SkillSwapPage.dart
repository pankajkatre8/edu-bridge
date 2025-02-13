import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

enum SkillType { offer, request }
enum SkillCategory { technology, design, business, language, other }

class Skill {
  final String id;
  final String name;
  final String user;
  final String level;
  final String location;
  final SkillType type;
  final double rating;
  final int sessionsCompleted;
  final SkillCategory category;
  final String description;
  final List<String> availableTimeSlots;
  final bool isOnline;
  final List<String> badges;
  final String imageUrl;

  Skill({
    required this.id,
    required this.name,
    required this.user,
    required this.level,
    required this.location,
    required this.type,
    required this.rating,
    required this.sessionsCompleted,
    required this.category,
    required this.description,
    required this.availableTimeSlots,
    required this.isOnline,
    required this.badges,
    required this.imageUrl,
  });
}

class EnhancedSkillCard extends StatelessWidget {
  final Skill skill;
  final VoidCallback onTap;
  final VoidCallback onMatch;

  const EnhancedSkillCard({
    Key? key, // Add Key? key here
    required this.skill,
    required this.onTap,
    required this.onMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  skill.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    skill.user,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                          '${skill.rating} (${skill.sessionsCompleted} sessions)'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillSwapPage extends StatefulWidget {
  const SkillSwapPage({Key? key}) : super(key: key);

  @override
  _SkillSwapPageState createState() => _SkillSwapPageState();
}

class _SkillSwapPageState extends State<SkillSwapPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  List<Skill> _skills = [];
  List<Skill> _filteredSkills = [];
  bool _showMatchingProgress = false;
  SkillCategory? _selectedCategory;
  String? _selectedLevel;
  bool _showOnlineOnly = false;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadSkills();
    _startPeriodicRefresh();
  }

  void _startPeriodicRefresh() {
    _refreshTimer = Timer.periodic(Duration(minutes: 5), (_) {
      if (mounted) {
        _loadSkills();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSkills() async {
    setState(() => _showMatchingProgress = true);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        _skills = [
          Skill(
            id: '1',
            name: 'AI Programming',
            user: 'Tech Mentor',
            level: 'Advanced',
            location: 'Global',
            type: SkillType.offer,
            rating: 4.8,
            sessionsCompleted: 42,
            category: SkillCategory.technology,
            description:
                'Expert in machine learning and AI development with 5+ years of experience. Specializing in neural networks and deep learning.',
            availableTimeSlots: ['Mon 2-4PM', 'Wed 3-5PM', 'Fri 1-3PM'],
            isOnline: true,
            badges: ['Top Mentor', 'AI Expert'],
            imageUrl: 'https://example.com/avatar1',
          ),
          Skill(
            id: '2',
            name: 'Sustainable Design',
            user: 'Eco Innovator',
            level: 'Intermediate',
            location: 'Online',
            type: SkillType.request,
            rating: 4.5,
            sessionsCompleted: 28,
            category: SkillCategory.design,
            description:
                'Passionate about eco-friendly design principles and sustainable architecture.',
            availableTimeSlots: ['Tue 1-3PM', 'Thu 4-6PM'],
            isOnline: true,
            badges: ['Eco-Certified', 'Innovation Leader'],
            imageUrl: 'https://example.com/avatar2',
          ),
        ];
        _applyFilters();
      });
    } catch (e) {
      _showErrorSnackbar('Failed to load skills. Please try again.');
    } finally {
      setState(() => _showMatchingProgress = false);
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: _loadSkills,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _applyFilters() {
    setState(() {
      _filteredSkills = _skills.where((skill) {
        if (_selectedCategory != null && skill.category != _selectedCategory) {
          return false;
        }
        if (_selectedLevel != null && skill.level != _selectedLevel) {
          return false;
        }
        if (_showOnlineOnly && !skill.isOnline) {
          return false;
        }
        if (_searchController.text.isNotEmpty) {
          final query = _searchController.text.toLowerCase();
          return skill.name.toLowerCase().contains(query) ||
              skill.user.toLowerCase().contains(query) ||
              skill.description.toLowerCase().contains(query);
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildEnhancedAppBar(),
      body: _buildEnhancedBody(),
      floatingActionButton: _buildEnhancedFAB(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildEnhancedAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Skill Exchange',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Connect • Learn • Grow', style: TextStyle(fontSize: 12)),
        ],
      ),
      actions: [
        _buildNotificationBadge(),
        IconButton(
          icon: Icon(Icons.leaderboard),
          onPressed: _showEnhancedLeaderboard,
          tooltip: 'Global Leaderboard',
        ),
        // IconButton( // Removed Profile Button
        //   icon: Icon(Icons.person),
        //   onPressed: _showProfile,
        //   tooltip: 'Profile',
        // ),
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Find Skills'),
          Tab(text: 'My Exchanges'),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: _showNotifications,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Text(
              '3',
              style: TextStyle(color: Colors.white, fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildSkillsTab(),
        _buildExchangesTab(),
      ],
    );
  }

  Widget _buildSkillsTab() {
    return Column(
      children: [
        _buildEnhancedSearch(),
        _buildFilterChips(),
        Expanded(
          child: _showMatchingProgress
              ? _buildLoadingState()
              : _filteredSkills.isEmpty
                  ? _buildEmptyState()
                  : _buildEnhancedSkillGrid(),
        ),
      ],
    );
  }

  Widget _buildExchangesTab() {
    return Center(
      child: Text('My Exchanges Coming Soon!'),
    );
  }

  Widget _buildEnhancedSearch() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search skills, mentors, or topics...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _applyFilters();
                  },
                ),
              IconButton(
                icon: Icon(Icons.tune),
                onPressed: _showAdvancedFilters,
              ),
            ],
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) => _applyFilters(),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: Text('Online Only'),
            selected: _showOnlineOnly,
            onSelected: (selected) {
              setState(() {
                _showOnlineOnly = selected;
                _applyFilters();
              });
            },
          ),
          SizedBox(width: 8),
          ...SkillCategory.values.map((category) => Padding(
                padding: EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category.toString().split('.').last),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                      _applyFilters();
                    });
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildEnhancedSkillGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: _filteredSkills.length,
      itemBuilder: (context, index) {
        return EnhancedSkillCard(
          skill: _filteredSkills[index],
          onTap: () => _showEnhancedSkillDetails(_filteredSkills[index]),
          onMatch: () => _initiateEnhancedSkillMatch(_filteredSkills[index]),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading Global Skill Network...',
              style: Theme.of(context).textTheme.titleSmall),
          SizedBox(height: 10),
          Text('Connected to 42 countries',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No skills found',
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Text('Try adjusting your filters',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildEnhancedFAB() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Share Skill'),
      onPressed: _showAddSkillForm,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
      },
    );
  }

  void _showEnhancedSkillDetails(Skill skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSkillDetailHeader(skill),
                      _buildSkillDescription(skill),
                      _buildAvailabilitySection(skill),
                      _buildUserInfo(skill),
                      _buildBadges(skill),
                      _buildContactOptions(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillDetailHeader(Skill skill) {
    return Row(
      children: [
        Expanded(
          child: Text(
            skill.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  Widget _buildSkillDescription(Skill skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          skill.description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAvailabilitySection(Skill skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        ...skill.availableTimeSlots.map((timeSlot) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.blueGrey, size: 20),
                  SizedBox(width: 8),
                  Text(timeSlot, style: TextStyle(fontSize: 16)),
                ],
              ),
            )),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUserInfo(Skill skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the Mentor',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(skill.imageUrl),
              radius: 30,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.user,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${skill.rating} (${skill.sessionsCompleted} sessions)',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBadges(Skill skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badges',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: skill.badges
              .map((badge) => Chip(
                    label: Text(badge),
                    backgroundColor: Colors.teal[100],
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildContactOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.chat),
              label: Text('Chat'),
              onPressed: () {
                // Implement chat functionality
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.phone),
              label: Text('Call'),
              onPressed: () {
                // Implement call functionality
              },
            ),
          ],
        ),
      ],
    );
  }

  void _initiateEnhancedSkillMatch(Skill skill) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Match'),
          content: Text('Do you want to request a session with ${skill.user}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmation(skill);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmation(Skill skill) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Match Requested'),
          content: Text(
              'Your request to connect with ${skill.user} for ${skill.name} has been sent.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filter Options',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Category',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    children: SkillCategory.values.map((category) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(category.toString().split('.').last),
                          selected: _selectedCategory == category,
                          onSelected: (bool selected) {
                            setModalState(() {
                              _selectedCategory = selected ? category : null;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text('Level', style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: _selectedLevel,
                    hint: Text('Select Level'),
                    items: <String>['Beginner', 'Intermediate', 'Advanced']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setModalState(() {
                        _selectedLevel = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Online Only',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Checkbox(
                        value: _showOnlineOnly,
                        onChanged: (bool? value) {
                          setModalState(() {
                            _showOnlineOnly = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _applyFilters();
                        });
                      },
                      child: Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddSkillForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Share Your Skill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Skill Name'),
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Description'),
              ),
              // Add more form fields as necessary
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to save the new skill
                Navigator.of(context).pop();
              },
              child: Text('Share'),
            ),
          ],
        );
      },
    );
  }

  void _showEnhancedLeaderboard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Global Leaderboard'),
          content: Text('Leaderboard content coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Profile')),
          body: Center(child: Text('Profile page content coming soon!')),
        ),
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notifications'),
          content: Text('No new notifications.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
