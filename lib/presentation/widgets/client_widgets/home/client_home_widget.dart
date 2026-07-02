// class ClientHomeWidget extends StatefulWidget {
//   const ClientHomeWidget({super.key});
//
//   @override
//   State<ClientHomeWidget> createState() => _ClientHomeWidgetState();
// }
//
// class _ClientHomeWidgetState extends State<ClientHomeWidget> {
//   int _selectedIndex = 0;
//
//   static const workers = [
//     {
//       'name': 'Manoj Rajkumar',
//       'role': 'Senior Care Specialist',
//       'rating': 4.9,
//       'reviews': 128,
//       'distance': 1.2,
//       'badges': ['Pet Friendly', 'Non-Smoker'],
//     },
//     {
//       'name': 'Sarah Williams',
//       'role': 'Disability Support Worker',
//       'rating': 4.8,
//       'reviews': 96,
//       'distance': 2.4,
//       'badges': ['First Aid', 'NDIS'],
//     },
//     {
//       'name': 'John Mathew',
//       'role': 'Community Support Worker',
//       'rating': 4.7,
//       'reviews': 74,
//       'distance': 3.1,
//       'badges': ['Driver', 'Pet Friendly'],
//     },
//     {
//       'name': 'Priya Sharma',
//       'role': 'Registered Nurse',
//       'rating': 5.0,
//       'reviews': 213,
//       'distance': 0.8,
//       'badges': ['CPR', 'First Aid', 'NDIS'],
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F6F6),
//       bottomNavigationBar: ClientBottomNavBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
//           children: [
//             /// Header
//             Row(
//               children: [
//                 SvgPicture.asset(
//                   'assets/images/placeholder.svg',
//                   width: 18,
//                   height: 18,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   'Home',
//                   style: NdisThemeStyle.headlineLarge.copyWith(
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const Icon(Icons.keyboard_arrow_down, size: 18),
//                 const Spacer(),
//                 Stack(
//                   children: [
//                     const Icon(Icons.notifications_none, size: 28),
//                     Positioned(
//                       right: 2,
//                       top: 2,
//                       child: Container(
//                         width: 8,
//                         height: 8,
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 4),
//
//             Text(
//               '1 Fernshaw Street, Macgregor, QLD 4109',
//               style: NdisThemeStyle.bodyMedium.copyWith(
//                 color: Colors.grey,
//               ),
//             ),
//
//             const SizedBox(height: 28),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Find Workers',
//                     style: NdisThemeStyle.headlineMedium.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: NimoraColors.jobTabWhiteTitleColor,
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/images/filter_icon.svg',
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Ask AI or Search',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: SvgPicture.asset(
//                     'assets/images/ai_auto.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 28),
//
//             Text(
//               '${workers.length} WORKERS NEARBY',
//               style: NdisThemeStyle.bodyMedium.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             ...workers.map(
//                   (worker) => Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: WorkerCard(
//                   name: worker['name'] as String,
//                   role: worker['role'] as String,
//                   rating: worker['rating'] as double,
//                   reviews: worker['reviews'] as int,
//                   distance: worker['distance'] as double,
//                   badges: List<String>.from(
//                     worker['badges'] as List,
//                   ),
//                   onTap: () {
//                     context.push(AppRoutes.workerDetail);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/core/theme/app_theme.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/home/worker_card.dart';
import 'package:nimora_worker/routes/app_router.dart';

class ClientHomeWidget extends StatelessWidget {
  const ClientHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final workers = [
      {
        'name': 'Manoj Rajkumar',
        'role': 'Senior Care Specialist',
        'rating': 4.9,
        'reviews': 128,
        'distance': 1.2,
        'badges': ['Pet Friendly', 'Non-Smoker'],
      },
      {
        'name': 'Sarah Williams',
        'role': 'Disability Support Worker',
        'rating': 4.8,
        'reviews': 96,
        'distance': 2.4,
        'badges': ['First Aid', 'NDIS'],
      },
      {
        'name': 'John Mathew',
        'role': 'Community Support Worker',
        'rating': 4.7,
        'reviews': 74,
        'distance': 3.1,
        'badges': ['Driver', 'Pet Friendly'],
      },
      {
        'name': 'Priya Sharma',
        'role': 'Registered Nurse',
        'rating': 5.0,
        'reviews': 213,
        'distance': 0.8,
        'badges': ['CPR', 'First Aid', 'NDIS'],
      },
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        children: [
          /// Header
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/placeholder.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 4),
              Text(
                'Home',
                style: NdisThemeStyle.headlineLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 18),

              const Spacer(),

              Stack(
                children: [
                  const Icon(Icons.notifications_none, size: 28),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            '1 Fernshaw Street, Macgregor, QLD 4109',
            style: NdisThemeStyle.bodyMedium.copyWith(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Find Workers',
                  style: NdisThemeStyle.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: NimoraColors.jobTabWhiteTitleColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/filter_icon.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              hintText: 'Ask AI or Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  'assets/images/ai_auto.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            '${workers.length} WORKERS NEARBY',
            style: NdisThemeStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...workers.map(
                (worker) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: WorkerCard(
                name: worker['name'] as String,
                role: worker['role'] as String,
                rating: worker['rating'] as double,
                reviews: worker['reviews'] as int,
                distance: worker['distance'] as double,
                badges: List<String>.from(worker['badges'] as List),
                onTap: () {
                  context.push(AppRoutes.workerDetail);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}