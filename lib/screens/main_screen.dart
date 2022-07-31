import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double _initialSheetChildSize = 0.4;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  final double _fabPositionPadding = 10;
  bool _isSearchActive = false;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _fabPosition = _initialSheetChildSize * context.size!.height;
      });
    });
  }

  void _onFocusChange() {
    setState(() {
      _isSearchActive = _focus.hasFocus;
    });
  }

  Widget _searchList() {
    return Column(
      children: [
        Card(
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.timelapse,
                    ),
                    minLeadingWidth: 5,
                    title: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Lorem ipsum dolor sit amet",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    )),
                ListTile(
                  leading: const Icon(
                    Icons.search,
                  ),
                  minLeadingWidth: 5,
                  title: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Where to?",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  trailing: const Text(
                    "Map",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ]),
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 100,
          itemBuilder: (BuildContext context, int i) => ListTile(
            leading: const Icon(
              Icons.timelapse,
            ),
            minLeadingWidth: 5,
            title: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5))),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Lorem ipsum dolor sit amit $i'),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Saratov',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        _focus.unfocus();
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 136, 182, 138),
            child: const Center(child: Text('Map')),
          ),
          Positioned(
            bottom: _fabPosition + _fabPositionPadding,
            left: _fabPositionPadding,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: const Color.fromARGB(179, 240, 234, 234),
              child: const Icon(
                Icons.near_me_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              setState(() {
                _widgetHeight = context.size!.height;
                _dragScrollSheetExtent = notification.extent;
                _fabPosition = _dragScrollSheetExtent * _widgetHeight;
              });
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: _initialSheetChildSize,
              minChildSize: 0.07,
              maxChildSize: _isSearchActive ? 0.95 : 0.75,
              builder: (context, scrollController) => Container(
                padding: const EdgeInsets.only(top: 0, left: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: TextFormField(
                        focusNode: _focus,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 239, 237, 237),
                            hintText: "Where to?",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/images/car.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                            suffixIcon: const Icon(Icons.arrow_forward,
                                color: Colors.black)),
                      ),
                    ),
                    _isSearchActive
                        ? _searchList()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: 10,
                              children: [
                                Container(
                                    height: 130,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 237, 237),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Lorem ipsum dolor sit amet',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 17),
                                            ),
                                            const Text('7 min'),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/car.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ))),
                                Container(
                                    height: 130,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 237, 237),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                'Lorem ipsum dolor sit amet',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17)),
                                            const Text('7 min'),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/car.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ))),
                                Container(
                                    height: 130,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 237, 237),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                'Lorem ipsum dolor sit amet',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17)),
                                            const Text('7 min'),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/car.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ))),
                                Container(
                                    height: 130,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 237, 237),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                'Lorem ipsum dolor sit amet',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17)),
                                            const Text('7 min'),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/car.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                    _isSearchActive
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 237, 237),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.asset(
                                            'assets/images/delivery.png',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.fill,
                                          )),
                                      const Text(
                                        'Delivery',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    print('Delivery');
                                  },
                                ),
                                InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 237, 237),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.asset(
                                            'assets/images/eats.png',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.fill,
                                          )),
                                      const Text('Eats')
                                    ],
                                  ),
                                  onTap: () {
                                    print('eats');
                                  },
                                ),
                                InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 237, 237),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.asset(
                                            'assets/images/grocery.png',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.fill,
                                          )),
                                      const Text('Grocery')
                                    ],
                                  ),
                                  onTap: () {
                                    print('Grocery');
                                  },
                                ),
                                InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 239, 237, 237),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.asset(
                                            'assets/images/transportation.jpeg',
                                            width: 45,
                                            height: 45,
                                            fit: BoxFit.fill,
                                          )),
                                      const Text('Transport')
                                    ],
                                  ),
                                  onTap: () {
                                    print('Transport');
                                  },
                                ),
                              ],
                            ),
                          ),
                    _isSearchActive
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Lorem ipsum dolor sit amet',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                    _isSearchActive
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 145,
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 50),
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://img.freepik.com/premium-photo/branch-with-green-leaves-light-green-background-with-space-text_541160-755.jpg?w=2000'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: const Text(
                                        'Lorem ipsum dolor',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )),
                                  const SizedBox(height: 10),
                                  Container(
                                      height: 145,
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, right: 40),
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://threadcurve.com/wp-content/uploads/2022/04/flip-flops-apr122022-02.jpg'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: const Text(
                                          'Lorem ipsum dolor sit amet',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)))
                                ],
                              ),
                              Container(
                                  height: 300,
                                  margin: const EdgeInsets.only(right: 15),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 70),
                                  width:
                                      MediaQuery.of(context).size.width * .43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://c4.wallpaperflare.com/wallpaper/375/854/342/sunset-beach-wallpaper-preview.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                  child: const Text(
                                    'Lorem ipsum dolor sit amet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ))
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
