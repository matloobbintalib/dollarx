import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/authentication/cubits/logout/logout_cubit.dart';
import 'package:dollarax/modules/authentication/cubits/logout/logout_state.dart';
import 'package:dollarax/modules/bank_account/pages/bank_account_page.dart';
import 'package:dollarax/modules/history/pages/history_page.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_cubit.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_state.dart';
import 'package:dollarax/modules/kyc_verification/pages/kyc_verification_page.dart';
import 'package:dollarax/modules/profile/pages/support_page.dart';
import 'package:dollarax/modules/profile/pages/update_profile_page.dart';
import 'package:dollarax/modules/webpage/pages/html_content_page.dart';
import 'package:dollarax/modules/webpage/pages/webview_screen.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/dialogs/dialogs.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../authentication/pages/login_page.dart';
import '../../user/cubits/user_cubit.dart';
import '../../user/repository/user_account_repository.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final bool isFromDashboard;

  const ProfilePage({super.key, required this.isFromDashboard});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  final Uri _url = Uri.parse('https://dollarax.com/delete_account');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  bool isKycTabClick = false;
  bool isEditProfileClick = false;
  bool isBankInfoTabClick = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogoutCubit(sl()),
        ),
        BlocProvider(
          create: (context) => DashBoardRefreshCubit(sl())..dashBoardRefresh(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Profile",
          leftBorder: true,
          backArrow: !widget.isFromDashboard,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<DashBoardRefreshCubit, DashBoardRefreshState>(
          builder: (context, userProfileState) {
        if(userProfileState.dashBoardStatus == DashBoardRefreshStatus.loading){
          return Center(
            child: LoadingIndicator(),
          );
        }
        if(userProfileState.dashBoardStatus == DashBoardRefreshStatus.success){
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          imageUrl: (_userAccountRepository
                              .getUserFromDb()
                              .profilePic !=
                              null &&
                              _userAccountRepository
                                  .getUserFromDb()
                                  .profilePic
                                  .toString()
                                  .isNotEmpty)
                              ? "https://dollarax.com/" +
                              _userAccountRepository
                                  .getUserFromDb()
                                  .profilePic
                                  .toString()
                              : "assets/images/png/placeholder.jpg",
                          placeholder: (context, url) => SizedBox(
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/png/placeholder.jpg',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Image.asset(
                              'assets/images/png/placeholder.jpg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userAccountRepository
                                  .getUserFromDb()
                                  .name
                                  .toString(),
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              _userAccountRepository
                                  .getUserFromDb()
                                  .referralId
                                  .toString(),
                              style: context.textTheme.bodySmall,
                            ),
                            Text(
                              _userAccountRepository
                                  .getUserFromDb()
                                  .email
                                  .toString(),
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          NavRouter.push(context, UpdateProfilePge(userModel:  userProfileState.dashboardModel!.user,)).then((value) {
                            context.read<DashBoardRefreshCubit>()..dashBoardRefresh();
                          });
                        },
                        icon: Image.asset(
                          "assets/images/png/ic_edit.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ProfileWidget(
                  onTap: () {
                    isKycTabClick = true;
                    isBankInfoTabClick = false;
                    NavRouter.push(
                        context,
                        KycVerificationPage(
                          userModel: userProfileState.dashboardModel!.user,
                        )).then((value) {
                      context.read<DashBoardRefreshCubit>()..dashBoardRefresh();
                    });
                  },
                  leadingPath: 'assets/images/png/kyc_verification.png',
                  title: 'KYC Verification',
                ),
                ProfileWidget(
                  onTap: () {
                    NavRouter.push(
                        context,
                        BankAccountPage(
                          userModel: userProfileState.dashboardModel!.user,
                        ));
                  },
                  leadingPath: 'assets/images/png/settings.png',
                  title: 'Payment Info',
                ),
                ProfileWidget(
                  onTap: () {
                    NavRouter.push(context, SupportPage());
                  },
                  leadingPath: 'assets/images/png/support.png',
                  title: 'Support',
                ),
                ProfileWidget(
                  onTap: () {
                    NavRouter.push(context, HistoryPage());
                  },
                  leadingPath: 'assets/images/png/history.png',
                  title: 'History',
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ListTile(
                    onTap: () {},
                    horizontalTitleGap: 12,
                    contentPadding: EdgeInsets.only(left: 20, right: 16),
                    leading: Image.asset(
                      'assets/images/png/ic_language.png',
                      height: 40,
                      width: 40,
                    ),
                    trailing: Text(
                      "English",
                      style: TextStyle(color: AppColors.secondary, fontSize: 15),
                    ),
                    title: Text(
                      "Language",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                ProfileWidget(
                  onTap: () {
                    NavRouter.push(
                        context, HtmlContentPage(pageTitle: 'Privacy Policy'));
                  },
                  leadingPath: 'assets/images/png/ic_privacy_policy.png',
                  title: 'Privacy Policy',
                ),
                ProfileWidget(
                  onTap: () {
                    NavRouter.push(context,
                        HtmlContentPage(pageTitle: 'Terms & Conditions'));
                  },
                  leadingPath: 'assets/images/png/ic_term_conditions.png',
                  title: 'Terms & Conditions',
                ),
                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) async {
                    if (state.logoutStatus == LogoutStatus.loading) {
                      ToastLoader.show();
                    }
                    if (state.logoutStatus == LogoutStatus.success) {
                      await context.read<UserCubit>().logout();
                      ToastLoader.remove();
                      DisplayUtils.showToast(context,'Logout Successfully!');
                      NavRouter.pushAndRemoveUntil(context, LoginPage());
                    }
                    if (state.logoutStatus == LogoutStatus.error) {
                      DisplayUtils.showToast(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return ProfileWidget(
                      onTap: () async {
                        final confirmed =
                        await Dialogs.showLogOutConfirmationDialog(context);
                        if (confirmed && context.mounted) {
                          context.read<LogoutCubit>()..logout();
                        }
                      },
                      leadingPath: 'assets/images/png/logout.png',
                      title: 'Logout',
                    );
                  },
                ),
                ProfileWidget(
                  onTap: () async {
                    final confirmed =
                    await Dialogs.showDeleteAccountConfirmationDialog(
                        context);
                    if (confirmed && context.mounted) {
                      _launchUrl();
                    }
                  },
                  leadingPath: 'assets/images/png/ic_delete.png',
                  title: 'Delete Account',
                ),
              ],
            ),
          );
        }

        if (userProfileState.dashBoardStatus == DashBoardRefreshStatus.error) {
          return Center(
            child: Text(
              userProfileState.message,
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return EmptyWidget();
          },
        ),
      ),
    );
  }
}
