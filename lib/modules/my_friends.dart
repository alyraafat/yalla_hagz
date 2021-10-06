
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_hagz/shared/components.dart';
import 'package:yalla_hagz/shared/constants.dart';
import 'package:yalla_hagz/shared/cubit/cubit.dart';
import 'package:yalla_hagz/shared/cubit/states.dart';


class MyFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return (state is MyFriendsState) ? Scaffold(
            appBar: AppBar(
              title: Text(

                'Friends',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: defaultColor,
                          child: TextButton(
                            onPressed:() {
                            },
                            child: Text(
                              'Friends',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToRequests();
                            },
                            child: Text(
                              'Requests',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToSearch();
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context , index) => myFriend(),
                      separatorBuilder: (context , index) => myDivider(),
                      itemCount: 20
                  ),
                ]
                ,
              ),
            ),
          ) : (state is MyFriendRequestsState) ?
          Scaffold(
            appBar: AppBar(
              title: Text(

                'Friends',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToMyFriends();
                            },
                            child: Text(
                              'Friends',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: defaultColor,
                          child: TextButton(
                            onPressed:() {
                            },
                            child: Text(
                              'Requests',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToSearch();
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context , index) => myRequests(),
                      separatorBuilder: (context , index) => myDivider(),
                      itemCount: 20
                  ),
                ]
                ,
              ),
            ),
          ) :
          Scaffold(
            appBar: AppBar(
              title: Text(

                'Friends',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToMyFriends();
                            },
                            child: Text(
                              'Friends',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.grey[300],
                          child: TextButton(
                            onPressed:() {
                              cubit.changeToRequests();
                            },
                            child: Text(
                              'Requests',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: defaultColor,
                          child: TextButton(
                            onPressed:() {
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Card(
                      elevation: 5,
                      child: defaultFormField(
                        context: context,
                        prefix: Icons.search,
                        text: 'Search',
                      )
                  ),
                ]
                ,
              ),
            ),
          ) ;
        }
    );
  }
}
