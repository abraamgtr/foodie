import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/Commons/Theme/App_Colors.dart';
import 'package:foodie_app/Domain/Repository/Fruits/Fruits_repo.dart';
import 'package:foodie_app/Domain/Repository/Store/Product_repo.dart';
import 'package:foodie_app/Features/Pages/home/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required HomeBloc homeBloc,
    Key? key,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();
  AppColors _appColors = AppColors();
  List<FruitsRepo> _fruits = [
    FruitsRepo.fromJson(
        {"name": "Orange", "image": "assets/images/orange.png"}),
    FruitsRepo.fromJson({"name": "Banana", "image": "assets/images/banana.png"})
  ];
  List<ProductRepo> _products = [
    ProductRepo.fromJson({"name": "Orange\nJuice", "price": 9.5}),
    ProductRepo.fromJson({"name": "Banana\nJuice", "price": 11.5}),
    ProductRepo.fromJson({"name": "Banana\nJuice", "price": 11.5}),
  ];

  @override
  void initState() {
    super.initState();
    _fruits[0].color = _appColors.orangeColor;
    _fruits[1].color = _appColors.yellowColor;
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: widget._homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorHomeState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: TextButton(
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InHomeState) {
            return _mainWidget();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._homeBloc.add(LoadHomeEvent());
  }

  _mainWidget() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Choose the\nfruits you love.",
                style: TextStyle(
                    color: _appColors.darkBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                height: 70.0,
                child: ListView.builder(
                  itemCount: _fruits.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4.0,
                      shadowColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                    color:
                                        _fruits[index].color?.withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    _fruits[index].imgae ?? "",
                                    scale: 7.0,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                _fruits[index].name ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: _appColors.darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: _appColors.orangeColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 400.0,
                child: ListView.builder(
                  itemCount: _products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Positioned(
                          top: 30.0,
                          left: 14.0,
                          right: 14.0,
                          child: Container(
                            height: 250.0,
                            width: 250.0,
                            margin: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                color:
                                    _appColors.lightBlueColor.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                        ),
                        Positioned(
                          top: 50.0,
                          left: 40.0,
                          right: 40.0,
                          child: Container(
                            height: 250.0,
                            margin: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                color:
                                    _appColors.lightBlueColor.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                          ),
                        ),
                        Container(
                          height: 250.0,
                          width: 250.0,
                          margin: EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                              color: _appColors.lightBlueColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      "${_products[index].name?.split("\n")[0]}\n",
                                  style: TextStyle(
                                    color: _appColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.0,
                                  ),
                                ),
                                TextSpan(
                                  text: _products[index].name?.split("\n")[1],
                                  style: TextStyle(
                                    color:
                                        _appColors.whiteColor.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.0,
                                  ),
                                ),
                              ]),
                            ),
                            Positioned(
                              right: -70.0,
                              child: Image.asset(
                                "assets/images/orange-juice.png",
                                scale: 2.0,
                              ),
                            ),
                            Positioned(
                              left: 8.0,
                              bottom: 40.0,
                              child: Text(
                                "\$",
                                style: TextStyle(
                                  color: _appColors.darkBlueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 20.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price",
                                      style: TextStyle(
                                        color: _appColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                      )),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "${_products[index].price?.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: _appColors.darkBlueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
