import 'package:bebrain/model/policy_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  final int id;
  const PolicyScreen({super.key, required this.id});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late MainProvider _mainProvider;
  late Future<PolicyModel> _policyFuture;

  void _initializeFuture() async {
    _policyFuture = _mainProvider.fetchPages(widget.id);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFutureBuilder(
        future: _policyFuture,
        onRetry: () {
          setState(() {
            _initializeFuture();
          });
        },
        onComplete: (context, snapshot) {
          final page = snapshot.data!;
          return CustomScrollView(
            slivers: [
              const SliverAppBar(pinned: true),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.data!.title!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        page.data!.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colorPalette.grey66,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
