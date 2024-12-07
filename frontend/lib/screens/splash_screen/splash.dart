// import 'package:flutter/material.dart';
// import 'package:frontend/screens/auth/login_screen.dart'; // Import your login screen
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;  // Track the current page index
//
//   // Define the content for each page (title, description, image)
//   final List<Map<String, String>> onboardingData = [
//     {
//       "title": "Welcome to MyTribe",
//       "description": "Connect with people from your home country while living abroad.",
//       "image": "assets/images/intro1.jpeg",  // Use your own images
//     },
//     {
//       "title": "Find New Friends",
//       "description": "Discover other immigrants and expats who share similar experiences.",
//       "image": "assets/images/intro2.jpeg",
//     },
//     {
//       "title": "Stay Connected",
//       "description": "Share posts, chat, and stay connected with your community.",
//       "image": "assets/images/intro3.webp",
//     },
//     {
//       "title": "Get Started",
//       "description": "Let’s get started by signing up and connecting with others.",
//       "image": "assets/images/intro4.jpeg",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // PageView to swipe through onboarding screens
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: onboardingData.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;  // Update the current page index
//                 });
//               },
//               itemBuilder: (context, index) {
//                 final data = onboardingData[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(data['image']!, height: 400),  // Display image
//                       const SizedBox(height: 20),
//                       Text(
//                         data['title']!,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         data['description']!,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Indicator and buttons at the bottom
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Dots indicating the current page
//               for (int i = 0; i < onboardingData.length; i++)
//                 _buildDot(i),
//
//               const SizedBox(width: 20),
//
//               // Button to skip or proceed based on the page
//               if (_currentPage == onboardingData.length - 1)
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to the login screen after finishing onboarding
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const LoginScreen()),
//                     );
//                   },
//                   child: const Text("Get Started"),
//                 )
//               else
//                 TextButton(
//                   onPressed: () {
//                     _pageController.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeIn,
//                     );
//                   },
//                   child: const Text("Next"),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDot(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: 10,
//       width: 10,
//       margin: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//         color: _currentPage == index ? Colors.deepPurple : Colors.grey,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/login_screen.dart'; // Import your login screen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;  // Track the current page index

  // Define the content for each page (title, description, image)
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to MyTribe",
      "description":
      "Connect with people from your home country while living abroad. MyTribe helps you build a community no matter where you are.",
      "image": "assets/images/intro1.jpeg",  // Use your own images
    },
    {
      "title": "Find New Friends",
      "description":
      "Meet other immigrants and expats who share your experiences and culture. Make lasting connections with like-minded people.",
      "image": "assets/images/intro2.jpeg",
    },
    {
      "title": "Stay Connected",
      "description":
      "Share posts, chat, and stay connected with your community. MyTribe keeps you in touch with those who matter most.",
      "image": "assets/images/intro3.webp",
    },
    {
      "title": "Get Started",
      "description":
      "Sign up now to begin your journey. Start connecting with others and experience the power of MyTribe.",
      "image": "assets/images/intro4.jpeg",
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App name at the top
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              "MyTribe",  // The name of your app
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),  // Add some space between the app name and the image

          // PageView to swipe through onboarding screens
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;  // Update the current page index
                });
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(data['image']!, height: 300, fit: BoxFit.cover),  // Display image
                      const SizedBox(height: 20),
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle( fontWeight:FontWeight.bold, fontSize: 20, color: Colors.black54, height: 1.5, fontFamilyFallback: ['Noto Sans']),


                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Indicator and buttons at the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dots indicating the current page
              for (int i = 0; i < onboardingData.length; i++)
                _buildDot(i),

              const SizedBox(width: 20),

              // Button to skip or proceed based on the page
              if (_currentPage == onboardingData.length - 1)
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the login screen after finishing onboarding
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Get Started"),
                )
              else
                TextButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text("Next"),
                ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.deepPurple : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
