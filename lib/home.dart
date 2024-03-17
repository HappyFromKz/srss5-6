import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_7/news/news_bloc.dart';
import 'package:practice_7/news/news_repository.dart';
import 'package:practice_7/shared_preferences.dart';
import 'package:practice_7/user.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {

  NewUser user = NewUser();
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      UserPage(user: widget.user),
      SecondPage(),
      ThirdPage(),
      NewsPage()
    ];
  }

  int _currentIndex = 0;

  //interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Начальная страница
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.two_k),
            label: 'Страница 2',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.three_g_mobiledata_outlined),
            label: 'Страница 3',
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Новости',
            backgroundColor: Colors.blue
          ),
        ],
        // fixedColor: Colors.blue,
        currentIndex: _currentIndex, 
        selectedItemColor: Colors.black, 
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


// ignore: must_be_immutable
class UserPage extends StatelessWidget {

  NewUser user = NewUser();
  UserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('UserPage'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            ListTile(
              title: Text('${user.fullname}', style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.person, size: 30,),
            ),
            ListTile(
              title: Text('${user.phone}', style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.phone, size: 30,),
            ),
            ListTile(
              title: Text('${sharedPreference.email}', style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.email, size: 30,),
            ),
            ListTile(
              title: Text('${user.lifeStory}', style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.hourglass_bottom, size: 30,),
            ),
            ListTile(
              title: Text('${user.country}', style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.map, size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Вторая страница'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Третья страница'),
    );
  }
}



class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(NewsRepository())..add(LoadPostsEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text('News Page'),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(state.posts[index].title, style: TextStyle(fontSize: 18, color: Colors.red),),
                        SizedBox(height: 10,),
                        Text(state.posts[index].body, style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is NewsLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('News page'),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: const Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}