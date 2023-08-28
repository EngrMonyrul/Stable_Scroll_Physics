import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<String> cameraActions = ['ID Card', 'Documents', 'QR Code', 'Bar Code'];
  String selectedAction = 'ID Card';
  PageController pageController = PageController(viewportFraction: 0.25);



  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int currentIndex = pageController.page?.round() ?? 0;
      print(currentIndex);
      print(pageController.page?.round());
      setState(() {
        selectedAction = cameraActions[currentIndex];
        print(selectedAction);
      });
    });
  }

  void selectAction(String action) {
    setState(() {
      selectedAction = action;
      print(selectedAction);
    });

    int index = cameraActions.indexOf(action);
    print(index);
    print(cameraActions.indexOf(action));
    int middleIndex = cameraActions.length ~/ 2;
    print(middleIndex);
    int offsetIndex = index - middleIndex;
    print(offsetIndex);

    pageController.jumpToPage(pageController.page!.toInt() + offsetIndex);
    print(pageController.page!.toInt() + offsetIndex);
  }

  Widget getCameraContent() {
    switch (selectedAction) {
      case 'ID Card':
        return Center(
          child: Text('ID Card Camera'),
        );
      case 'Documents':
        return Center(
          child: Text('Documents Camera'),
        );
      case 'QR Code':
        return Center(
          child: Text('QR Code Camera'),
        );
      case 'Bar Code':
        return Center(
          child: Text('Bar Code Camera'),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: getCameraContent(),
            ),
          ),
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: pageController,
              itemCount: cameraActions.length,
              itemBuilder: (context, index) {
                return Center(
                  child: ActionButton(
                    title: cameraActions[index],
                    isSelected: selectedAction == cameraActions[index],
                    onPressed: () {
                      selectAction(cameraActions[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  ActionButton({required this.title, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isSelected ? Colors.blue : Colors.grey),
      ),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
