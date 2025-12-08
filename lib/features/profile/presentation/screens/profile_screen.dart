import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/colors/colors.dart';
import 'package:pixabay_image_feed/core/utils/app_size.dart';
import 'package:pixabay_image_feed/core/utils/gen/assets.gen.dart';
import 'package:pixabay_image_feed/core/widgets/app_divider.dart';
import 'package:pixabay_image_feed/core/widgets/app_scaffold.dart';
import 'package:pixabay_image_feed/core/widgets/coffee_app_list_tile.dart';
import 'package:pixabay_image_feed/features/profile/presentation/widgets/user_profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Profile'), automaticallyImplyLeading: false),
      body: FadeInDown(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Dimens.largePadding),
              UserProfileImageWidget(width: 110, height: 110),
              SizedBox(height: Dimens.largePadding),
              Text(
                'M Dev',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('m.dev.studio@gmail.com'),
              SizedBox(height: Dimens.largePadding),
              CoffeeAppListTile(
                onTap: () {},
                title: 'My orders',
                leadingIconPath: Assets.icons.receipt,
                icon: Icons.receipt,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Payment methods',
                leadingIconPath: Assets.icons.cardPos,
                icon: Icons.payment,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Addresses',
                leadingIconPath: Assets.icons.location,
                icon: Icons.location_city_sharp,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Wallet',
                leadingIconPath: Assets.icons.wallet,
                icon: Icons.wallet,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Notification',
                leadingIconPath: Assets.icons.notification,
                trailing: Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: true,
                    onChanged: (final value) {},
                    // activeTrackColor: CoffeeAppColors.secondaryColor,
                  ),
                ),
                padding: EdgeInsets.zero,
                icon: Icons.notifications,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Feedback',
                leadingIconPath: Assets.icons.noteText,
                icon: Icons.note,
              ),
              AppDivider(),
              CoffeeAppListTile(
                onTap: () {},
                title: 'Logout',
                leadingIconPath: Assets.icons.logout,
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
