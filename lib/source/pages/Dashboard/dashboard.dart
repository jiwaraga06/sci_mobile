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
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: colorBlueNavy, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hallo ,", style: TextStyle(fontSize: 16, color: Colors.white)),
                              const SizedBox(height: 8),
                              Text(data['username'].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                            ],
                          ),
                          Icon(Icons.notification_important_rounded, size: 25, color: Colors.white)
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                Container(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, stockOpnameScreen);
                        },
                        child: Column(
                          children: [
                            Ink(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: colorBlueLight, borderRadius: BorderRadius.circular(8)),
                                child: Icon(Icons.add_box, color: Colors.white)),
                            SizedBox(height: 10),
                            Text("Stock Opname", style: TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: CustomButton(
              bkackgroundColor: Colors.red[800],
              onTap: logout,
              text: "LOGOUT",
              textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
