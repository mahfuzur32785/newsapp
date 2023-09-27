import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:newsapp/core/remote_name.dart';
import 'package:newsapp/global_widget/custom_image.dart';
import 'package:newsapp/module/home/controller/home_controller_cubit.dart';
import 'package:newsapp/utils/constant.dart';
import 'package:newsapp/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = "";
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeControllerCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FE),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Homepage",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<HomeControllerCubit, HomeControllerState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is HomeControllerLoading) {
              print("Loading0");
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeControllerError) {
              print("Loading1");
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: redColor),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              );
            }
            if (state is HomeControllerLoaded) {
              return RefreshIndicator(
                key: refreshKey,
                onRefresh: () => homeBloc.getHomeData(),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search here..."
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate(List.generate(
                              homeBloc.homeModel!.articles.length, (index) {
                            if (homeBloc.homeModel!.articles[index].title.toLowerCase().contains(searchValue)) {
                              return GestureDetector(
                                onTap: () {
                                  Utils.closeKeyBoard(context);
                                  Navigator.pushNamed(
                                      context,
                                      RouteNames.homeDetailsPage,
                                      arguments: homeBloc.homeModel!.articles[index]
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.transparent),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: const Offset(0, 5))
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CustomImage(
                                            path:
                                            "${homeBloc.homeModel!.articles[index].urlToImage}",
                                            height: 100,
                                            width: 100,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: Text(
                                                "${homeBloc.homeModel!.articles[index].title}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text("${homeBloc.homeModel!.articles[index].description}")
                                    ],
                                  ),
                                ),
                              );
                            }
                            else{
                              return Container();
                            }
                      }))),
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
