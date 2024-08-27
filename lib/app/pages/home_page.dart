import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_test/app/core/client.dart';
import 'package:tractian_test/app/models/companies_model.dart';
import 'package:tractian_test/app/pages/asset_page.dart';
import 'package:tractian_test/app/repositories/remote/companies_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = CompaniesRepositoryImpl(client);
  List<CompaniesModel> companies = [];

  @override
  void initState() {
    super.initState();

    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    final companiesData = await _repository.fetchCompanies();

    setState(() {
      companies = companiesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF17192D),
        title: SvgPicture.asset(
          'assets/logo.svg',
          fit: BoxFit.contain,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(21),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: companies.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AssetPage(
                        id: companies[index].id,
                      );
                    },
                  ));
                },
                child: Container(
                  height: 78,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  margin: const EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2188FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/company_icon.svg'),
                      const SizedBox(width: 16),
                      Text(
                        companies[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
