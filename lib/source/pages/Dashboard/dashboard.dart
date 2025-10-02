part of '../index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void logout() {
    MyDialog.dialogInfo(context, "Apakan Anda yakin ingin Logout ?", () {}, () {
      BlocProvider.of<AuthCubit>(context).logout(context);
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlueNavy,
        elevation: 0.0,
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Container();
            }
            if (state is ProfileLoaded == false) {
              return Container();
            }
            var data = (state as ProfileLoaded).json;

            return Text("Hallo , ${data['username'].toString()}", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500));
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 8.5,
                    decoration: const BoxDecoration(color: colorBlueNavy),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(62, 63, 63, 63),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 5), // changes position of shadow
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 120,
                            margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 120,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('assets/img/landing.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(12),
                              childAspectRatio: 1, // width / height = 1 -> kotak
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, stockOpnameScreen);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(color: colorMerah1, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.all_inbox_sharp, size: 30, color: Colors.white),
                                        const SizedBox(height: 6),
                                        AutoSizeText('Stock Opname',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                        AutoSizeText('(Finished Goods)',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: colorMerah1, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.all_inbox_sharp, size: 30, color: Colors.white),
                                        const SizedBox(height: 6),
                                        AutoSizeText('Stock Opname',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                        AutoSizeText('(Sparepart)',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: colorYellow2, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.web, size: 30, color: Colors.white),
                                        const SizedBox(height: 6),
                                        AutoSizeText('Consumable Issue',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: colorYellow2, borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.paste_outlined, size: 30, color: Colors.white),
                                        const SizedBox(height: 6),
                                        AutoSizeText('Put Away',
                                            maxLines: 1, minFontSize: 14, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
