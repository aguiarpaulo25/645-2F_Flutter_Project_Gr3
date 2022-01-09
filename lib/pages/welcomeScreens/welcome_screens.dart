import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/auth/authentification_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF02f0f0),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF02f0f0),
                Color(0xFF04bdbd),
                Color(0xFF018786),
                Color(0xFF006666),
              ],
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthenticationWrapper())),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ).tr(),
                    ),
                  ),
                  Container(
                    height: 600.0,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/tshirt.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                const Text(
                                  'ConnectTshirtTitle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                  ),
                                ).tr(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                const Text(
                                  'ConnectTshirtText',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ).tr()
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                40.0, 40.0, 40.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/current_data.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                const Text(
                                  'CurrentDataTitle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                  ),
                                ).tr(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                const Text(
                                  'CurrentDataText',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ).tr()
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/compare.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                const Text(
                                  'CompareDataTitle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                  ),
                                ).tr(),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                const Text(
                                  'CompareDataText',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ).tr()
                              ],
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  _currentPage != _numPages - 1
                      ? Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: FlatButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ).tr(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AuthenticationWrapper()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Start',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ).tr(),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              )),
        ),
      ),
    );
  }
}
