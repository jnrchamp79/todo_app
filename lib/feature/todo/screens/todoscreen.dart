import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/todo/provider/todo_provider.dart';
import 'package:todo_app/feature/todo/widget/widget.dart';

class Todoscreen extends ConsumerStatefulWidget {
  const Todoscreen({super.key});

  @override
  ConsumerState<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends ConsumerState<Todoscreen> {

  //print our git dey workkk ooo
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final searchController = TextEditingController();

  

 //  List <Todomodel> list = [];
    List <Todomodel> providerList = [];
    List <Todomodel> listCopy = [];

  bool isSearching = false;
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener((){
      if(searchController.text.trim().isNotEmpty){
        searchTodo();
      }else{
       // list.clear();
      //  list.addAll(listCopy);
        setState(() {});
      }
      
    });
  }

   void showMyDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please enter you Todo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green
          ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController,),
              TextField(controller: subTitleController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isEdit){
                  ref.read(todoProvider.notifier).editTodo(index, Todomodel(titleController.text, subTitleController.text));
                 // list.removeAt(index);
                  //list.insert(index, Todomodel(titleController.text, subTitleController.text));
                  //listCopy.removeAt(index);
                 // listCopy.insert(index, Todomodel(titleController.text, subTitleController.text));
                  
                }
                else{
                  ref.read(todoProvider.notifier).addTodo(Todomodel(titleController.text, subTitleController.text));
                 // list.add(Todomodel(titleController.text, subTitleController.text));
                  //listCopy.add(Todomodel(titleController.text, subTitleController.text));

                }

               
                setState(() {});
                titleController.text ="";
                subTitleController.text = "";
                Navigator.pop(context);
              },
              child:Text (isEdit? "Edit Todo" : "Add Todo",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),)
            ),
          ],
        );
      },
    );
  }
   void searchTodo(){
    searchTodo();
  //  list.clear();
   // print(list);
   // print(listCopy);
   // print(searchController.text.toLowerCase());
   // for(var value in listCopy){
   //   if(value.title.toString().toLowerCase().contains(searchController.text.toLowerCase()) || value.subTitle.toString().toLowerCase().contains(searchController.text.toLowerCase()) ){
    //    list.add(value);

     // }
   // }
    // print(list);
   // print(listCopy);
    //setState(() {});
   }
  @override
  Widget build(BuildContext context) {
    var providerList = ref.watch(todoProvider);
  
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title:isSearching?TextField(controller: searchController,): Text("Manage Lists", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green
        ),),
        actions: [GestureDetector(
          onTap: () {
            isSearching = !isSearching;
            setState(() {});
            
          },
         
            child: Icon(Icons.search, 
            color: Colors.grey,),
          ),
        SizedBox(width: 20,),
        Icon(Icons.more_vert,
        color: Colors.grey,),
        SizedBox(width: 20,),],),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: providerList.length,
          itemBuilder: (context, index){

            return Card(
              color: Colors.white,
              child: ListTile(

                leading: GestureDetector(
                  onTap: () {
                    isEdit = true;
                    //setState(() {});
                     var model = providerList[index];
                      titleController.text = model.title;
                      subTitleController.text = model.subTitle;
                      ref.read(todoProvider.notifier).editTodo(index, Todomodel(titleController.text, subTitleController.text));
                      showMyDialog(index);
                      
        
                  },
                  child: Icon(Icons.edit)
                  ),


                trailing: GestureDetector(
                  onTap: (){
                    ref.read(todoProvider.notifier).deleteTodo(index);
                  },
                  child: Icon(Icons.delete,
                  color: Colors.red,),
                ),


                title: Text(providerList[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(providerList[index].subTitle),
              ),
            ); 
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
          isEdit = false;
          showMyDialog(-1);
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.playlist_add),),
        


        
      );
    
  }
}

