
import 'package:api_call/dart_json_class.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


   @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final HttpService httpService = HttpService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex Json Request"),
      ),
      body: FutureBuilder<List<Posts>?>(
      
        future: httpService.getPosts(),
        builder: (context, snapshot){
           final datamar = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              
               itemCount: datamar!.length,
              itemBuilder: (context, index){
                final postData = datamar[index];
                 return Text(postData.data!.first.title!);
              });
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        }
        ),
    );
  }

  // Widget item(Posts postData){
    
  //     return ListTile(
      
  //       title: Text(postData.data!.title!),
  //        //subtitle: Text(postData.data!.date!),
  //     );
  // }
}
