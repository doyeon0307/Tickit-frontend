import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/custom_network_image.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/const/app_colors.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/home/home_state.dart';
import 'package:tickit/ui/home/home_view_model.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final HomeState state = ref.watch(homeViewModelProvider);

    useEffect(() {
      Future(() => viewModel.initView());
      return null;
    }, []);

    useEffect(() {
      if (state.errorMsg.isNotEmpty) {
        Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(message: state.errorMsg),
          ),
        );
      }

      return null;
    }, [state.errorMsg]);

    Future<void> tmp() async {}

    return DefaultLayout(
      child: Stack(
        children: [
          Center(
            child: VerticalCardPager(
              titles: List.generate(
                state.previews.length,
                (index) => "",
              ),
              images: state.previews
                  .map(
                    (e) => Hero(
                      tag: e.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CustomNetworkImage(url: e.image),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (state.initLoading == LoadingStatus.loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CustomLoading(),
              ),
            ),
        ],
      ),
    );
  }
}
