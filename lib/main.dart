import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData.dark(),
      home: PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  final String name = "Ayush Kumar";
  final String bio = "Passionate Flutter Developer";

  final List<Map<String, dynamic>> skills = [
    {'label': 'Flutter', 'icon': FontAwesomeIcons.mobile},
    {'label': 'Java', 'icon': FontAwesomeIcons.java},
    {'label': 'Python', 'icon': FontAwesomeIcons.python},
    {'label': 'Pandas', 'icon': FontAwesomeIcons.database},
    {'label': 'HTML', 'icon': FontAwesomeIcons.html5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portfolio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/ayush1.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              bio,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Connect with me:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  url: 'https://www.linkedin.com/in/ayushkumarjsr/',
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.github,
                  url: 'https://github.com/ayush6447',
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.youtube,
                  url: 'https://www.youtube.com/@ayu_shhh_',
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Skills & Technologies:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return SkillCard(
                    label: skills[index]['label'],
                    icon: skills[index]['icon'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 30, color: Colors.white),
      onPressed: () async {
        Uri uri;

        if ((url.contains('@') && !url.startsWith('http')) &&
            !url.startsWith('mailto:')) {
          uri = Uri(scheme: 'mailto', path: url);
        } else {
          uri = Uri.parse(url);
        }

        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      },
    );
  }
}

class SkillCard extends StatelessWidget {
  final String label;
  final IconData icon;

  SkillCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.tealAccent),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
