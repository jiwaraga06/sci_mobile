part of "../index.dart";

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        title: Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                MyDialog.dialogInfo(context, 'Apakah Anda Ingin Keluar ?', () {}, () {
                  BlocProvider.of<AuthCubit>(context).logout(context);
                });
              },
              icon: Icon(Icons.logout_outlined, color: Colors.white)),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileLoaded == false) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var json = (state as ProfileLoaded).json;
              if (json.isEmpty) {
                return Center();
              }
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(Icons.account_circle, color: Colors.black, size: 65),
                    const SizedBox(height: 10),
                    Text(
                      json['username'].toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
