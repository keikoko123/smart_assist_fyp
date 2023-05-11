import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist_fyp/common/widgets/error.dart';
import 'package:smart_assist_fyp/common/widgets/loader.dart';
import 'package:smart_assist_fyp/features_0_common/auth/repository/auth_repository.dart';
import 'package:smart_assist_fyp/features_3_chat_n_gallery/mobile_layout_screen.dart';
import 'package:smart_assist_fyp/features_4_news_n_events/community_home.dart';
import 'package:smart_assist_fyp/landing_screen.dart';
import 'features_0_common/auth/controller/auth_controller.dart';
import 'features_1_smarthome/myhome.dart';
import 'features_2_smartassist/screens/basic_assist.dart';
import 'features_2_smartassist/screens/family_side.dart';
import 'features_2_smartassist/screens/community_side.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Home extends ConsumerStatefulWidget {
  static const String routeName = '/APP_HOME';

  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  //-------------------------//-------------------------//-------------------------
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void textToSpeech(String text) async {
    await flutterTts.setLanguage("yue-HK");
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    await flutterTts.setSharedInstance(true); //for ios
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'yue_HK',
    );
    setState(() {});
  }

  void _startListeningEng() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      print(_lastWords);
      //_stopListening();
      speechRouting(_lastWords);
    });
  }

  //-------------------------//-------------------------//-------------------------
  void _startListening2() async {
    await _speechToText.listen(
      onResult: _onSpeechResult2,
      localeId: 'yue_HK',
    );
    setState(() {});
  }

  void _onSpeechResult2(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      //_stopListening();
      jotNote(_lastWords);
    });
  }

  //聲明無類型等同於聲明void.
  jotNote(String x) {
    start_jot() {}
  }
  //-------------------------//-------------------------//-------------------------

  speechRouting(String x) {
    // RegExp reg = new RegExp(r'[abc]'.format);

    // bool isAbc = reg.hasMatch(x)

    // List<String> keywords = [
    //   "首頁", "Homepage",
    //   "小幫手", "Assist",
    //   "聊天","Chat",
    //   "Community", "社區"
    //   ];
    //https://blog.csdn.net/yanggenye/article/details/71216134 ,根据关键字提取整段话中关键字

    switch (x) {
      // case '幫我寄底xzcasasdaa':
      // case '幫我記低':
      //   currentTab = 1;
      //   //currentScreen = MyHome();
      //   _stopListening();
      //   _startListening2(); //NLP拆翻開個時間  2月17號,9點要約左阿明飲茶
      //   break;

      case 'home':
      case '去home':
      case '去空':
      case '虛空':
      case '去首頁':
        currentTab = 0;
        currentScreen = MyHome();
        _stopListening();
        textToSpeech("於Home Page, 可以自定義智能設備");

        break;

      case 'assist':
      case 'assistant':
      case '小幫手':
      case '去小幫手':
      case '搵小幫手':
        currentTab = 1;
        currentScreen = Basic_Assist();
        _stopListening();
        textToSpeech("於Assist Page, 可選擇你需要的小幫手");

        break;

      case '去相簿':
      case '相簿':
      case '賞舞':
      case '想抱抱':
        currentTab = 2;
        currentScreen = MobileLayoutScreen();
        _stopListening();
        textToSpeech("右上可更改相簿排列");

        break;

      case 'chatroom':
      case '去傾偈':
      case 'community':
      case '去community':
      case '去社區':
        currentTab = 3;
        currentScreen = Community_Side();
        _stopListening();
        textToSpeech("");

        break;

      default:
    }
  }

  int currentTab = 0;
  final List<Widget> screens = [
    MyHome(),
    Basic_Assist(),
    MobileLayoutScreen(),
    Community_Side(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MyHome();

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Container(
        height: height * 0.09,
        width: height * 0.10,
        child: FloatingActionButton(
          heroTag: "btn1_Home",
          child: Icon(
            Icons.mic,
            size: width * 0.11,
          ),
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
        ),
      ),
      //!!!! floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        textToSpeech("歡迎使用Smart Home");

                        currentScreen = MyHome();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          size: width * 0.13,
                          color: currentTab == 0 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          '  Home  ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: currentTab == 0
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(0),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        textToSpeech("歡迎使用Smart Assist");

                        currentScreen = const Basic_Assist();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.handshake,
                          size: width * 0.13,
                          color: currentTab == 1 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Assist',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: currentTab == 1
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Row(),
              SizedBox(
                width: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(6),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        textToSpeech("歡迎來到Family頁面，");

                        currentTab = 2;

                        currentScreen = const MobileLayoutScreen();
                        // ref.watch(userDataAuthProvider).when(
                        //       data: (user) {
                        //         if (user == null) {
                        //           debugPrint('loading');
                        //         }
                        //         currentTab = 2;

                        //         currentScreen = const MobileLayoutScreen();

                        //         //return const SigninScreen();
                        //         //return const MobileLayoutScreen();
                        //       },
                        //       error: (err, trace) {
                        //         return ErrorScreen(
                        //           error: err.toString(),
                        //         );
                        //       },
                        //       loading: () => const Loader(),
                        //     );

                        //!currentScreen = const MobileLayoutScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                          size: width * 0.12,

                          //Icons.chat,
                          color: currentTab == 2 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Family',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: currentTab == 2
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(4),
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        textToSpeech("於Community界面，可以選擇不同的TAG來觀看資訊, 點擊可開啟新聞詳情和參加活動");
                        currentScreen = const CommunityHome();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business,
                          size: width * 0.12,

                          //Icons.group,
                          color: currentTab == 3 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Community',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: currentTab == 3
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
