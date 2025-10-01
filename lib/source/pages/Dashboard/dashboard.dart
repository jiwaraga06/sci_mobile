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
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return Container();
                    }
                    if (state is ProfileLoaded == false) {
                      return Container();
                    }
                    var data = (state as ProfileLoaded).json;
                    return Container(
                      margin: const EdgeInsets.only(left: 12, right: 12),
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(color: colorBlueNavy, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/img/user.png", height: 50),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hallo ,", style: TextStyle(fontSize: 16, color: Colors.white)),
                                  const SizedBox(height: 2),
                                  Text(data['username'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(onTap: logout, child: Icon(Icons.logout, size: 25, color: Colors.white)),
                              const SizedBox(width: 6),
                              Icon(Icons.notification_important_rounded, size: 25, color: Colors.white),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, stockOpnameScreen);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: colorBlueNavy, borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag, size: 35, color: Colors.white),
                              SizedBox(height: 10),
                              Text("Stock Opname", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
