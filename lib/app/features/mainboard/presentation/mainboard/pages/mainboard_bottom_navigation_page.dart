import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/states/mainboard_state.dart';
import 'mainboard_button_page.dart';

class MainboardBottomNavigationPage extends StatelessWidget {
  const MainboardBottomNavigationPage({
    Key? key,
    required this.currentPage,
    required this.pages,
    required this.onSelect,
  }) : super(key: key);

  final MainboardState? currentPage;
  final List<MainboardState>? pages;
  final void Function(MainboardState) onSelect;

  @override
  Widget build(BuildContext context) {
    final bottomColor = currentPage!.maybeWhen(
      helpCenter: () => DesignSystemColors.helpCenterButtonBar,
      orElse: () => DesignSystemColors.white,
    );

    return BottomAppBar(
      elevation: 20.0,
      color: bottomColor,
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtond(),
        ),
      ),
    );
  }

  List<Widget> _buildButtond() {
    return pages!
        .map(
          (e) => (e == const MainboardState.helpCenter())
              ? Container(width: 64)
              : MainboarButtonPage(
                  currentPage: e,
                  pageSelected: currentPage,
                  onSelect: (v) => onSelect(v),
                ),
        )
        .toList();
  }
}
