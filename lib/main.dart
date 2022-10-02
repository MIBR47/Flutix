import 'package:bwa_flutix/bloc/user_bloc.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      initialData: null,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              theme: themeState.themeData,
              // theme: ThemeData(
              //   // primarySwatch: mainColor,
              //   colorScheme: ColorScheme.fromSwatch()
              //       .copyWith(secondary: accentColor2, primary: accentColor2),
              //   // inputDecorationTheme: InputDecorationTheme(
              //   //   border: OutlineInputBorder(
              //   //     borderSide: const BorderSide(color: Colors.black),
              //   //     borderRadius: BorderRadius.circular(40),
              //   //   ),
              //   //   contentPadding: EdgeInsets.symmetric(
              //   //     vertical: 22,
              //   //     horizontal: 26,
              //   //   ),
              //   //   labelStyle: const TextStyle(
              //   //     color: Colors.amber,
              //   //     fontSize: 16,
              //   //   ),
              //   //   focusedBorder: OutlineInputBorder(
              //   //     borderSide: const BorderSide(color: acc),
              //   //     borderRadius: BorderRadius.circular(10),
              //   //   ),
              //   //   enabledBorder: OutlineInputBorder(
              //   //     borderSide: const BorderSide(color: Colors.black),
              //   //     borderRadius: BorderRadius.circular(10),
              //   //   ),
              //   // ),
              // ),
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            );
          },
        ),
      ),
    );
  }
}

//  Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   SignInSignUpResult result = await AuthServices.singUp(
//                     "ilham3@gmail.com",
//                     "12345678",
//                     "Ilham",
//                     ["Action", "Superhero", "Drama"],
//                     "Korean",
//                   );
//                   if (result.user == null) {
//                     print(result.message?.message.toString());
//                     print("error");
//                   } else {
//                     print(result.user.toString());
//                   }
//                 },
//                 child: Text('Sign up'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   SignInSignUpResult result = await AuthServices.signIn(
//                     "ilham3@gmail.com",
//                     "123456789",
//                   );
//                   if (result.user == null) {
//                     print(result.message?.message.toString());
//                     print("error");
//                   } else {
//                     print(result.user.toString());
//                   }
//                 },
//                 child: Text('Sign In'),
//               ),
//             ],
//           ),
//         ),
//       ),
