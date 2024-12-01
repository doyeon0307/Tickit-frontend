import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tickit/core/loading_status.dart';
import 'package:tickit/ui/common/component/custom_loading.dart';
import 'package:tickit/ui/common/component/custom_network_image.dart';
import 'package:tickit/ui/common/component/error_snack_bar.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';
import 'package:tickit/ui/home/home_state.dart';
import 'package:tickit/ui/home/home_view_model.dart';
import 'package:tickit/ui/ticket/const/ticket_mode.dart';
import 'package:tickit/ui/ticket/ticket_view.dart';
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
              onSelectedItem: (index) async {
                final deleted = await pushWithoutNavBar<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TicketView(
                          mode: TicketMode.detail,
                          id: state.previews[index].id,
                        ),
                  ),
                );
                if (deleted == true) {
                  await viewModel.initView();
                }
              }
            ),
          ),
          if (state.initLoading == LoadingStatus.loading)
            const Center(
              child: CustomLoading(),
            ),
        ],
      ),
    );
  }
}
