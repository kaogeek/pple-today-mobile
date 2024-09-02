// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../bindings/account_merge_binding.dart';
import '../bindings/connect_social_media_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/detail_first_binding.dart';
import '../bindings/doing_binding.dart';
import '../bindings/edit_profile_binding.dart';
import '../bindings/edit_profile_text_field_binding.dart';
import '../bindings/first_page_binding.dart';
import '../bindings/forgot_password_binding.dart';
import '../bindings/hash_tag_binding.dart';
import '../bindings/login_main_binding.dart';
import '../bindings/login_register_binding.dart';
import '../bindings/menu_binding.dart';
import '../bindings/mfp_vote_answering_binding.dart';
import '../bindings/mfp_vote_binding.dart';
import '../bindings/mfp_vote_create_binding.dart';
import '../bindings/mfp_vote_create_item_binding.dart';
import '../bindings/mfp_vote_create_thx_binding.dart';
import '../bindings/mfp_vote_create_view_binding.dart';
import '../bindings/mfp_vote_dashboard_binding.dart';
import '../bindings/mfp_vote_detail_binding.dart';
import '../bindings/mfp_vote_edit_binding.dart';
import '../bindings/mfp_vote_edit_item_binding.dart';
import '../bindings/mfp_vote_edit_thx_binding.dart';
import '../bindings/mfp_vote_edit_view_binding.dart';
import '../bindings/mfp_vote_post_all_binding.dart';
import '../bindings/mfp_vote_resultes_binding.dart';
import '../bindings/mfp_vote_seach_binding.dart';
import '../bindings/mfp_voting_my_point_binding.dart';
import '../bindings/notification_card_binding.dart';
import '../bindings/page_manage_binding.dart';
import '../bindings/page_profile_binding.dart';
import '../bindings/photo_perview_binding.dart';
import '../bindings/point_category_binding.dart';
import '../bindings/point_event_detail_binding.dart';
import '../bindings/point_main_binding.dart';
import '../bindings/point_product_detail_binding.dart';
import '../bindings/post_detail_binding.dart';
import '../bindings/privacy_policy_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/profile_detail_social_binding.dart';
import '../bindings/ranking_binding.dart';
import '../bindings/register_binding.dart';
import '../bindings/register_preview_binding.dart';
import '../bindings/search_binding.dart';
import '../bindings/setting_binding.dart';
import '../bindings/slider_show_lmage_binding.dart';
import '../bindings/sync_page_social_binding.dart';
import '../bindings/used_coupon_binding.dart';
import '../bindings/user_coupon_binding.dart';
import '../bindings/user_point_binding.dart';
import '../bindings/web_view_login_mfp_binding.dart';
import '../bindings/webview_binding.dart';
import '../bindings/webview_emergency_binding.dart';
import '../ui/pages/account_merge_input_otp_page/account_merge_input_otp_page.dart';
import '../ui/pages/account_merge_page/account_merge_page.dart';
import '../ui/pages/connect_social_media_page/connect_social_media_page.dart';
import '../ui/pages/dashboard_page/dashboard_page.dart';
import '../ui/pages/detail_first_page/detail_first_page.dart';
import '../ui/pages/doing_page/doing_page.dart';
import '../ui/pages/edit_profile_page/edit_profile_page.dart';
import '../ui/pages/edit_profile_text_field_page/edit_profile_text_field_page.dart';
import '../ui/pages/first_page_page/first_page_page.dart';
import '../ui/pages/forgot_password_page/forgot_password_page.dart';
import '../ui/pages/hash_tag_page/hash_tag_page.dart';
import '../ui/pages/login_main_page/login_main_page.dart';
import '../ui/pages/login_register_page/login_register_page.dart';
import '../ui/pages/menu_page/menu_page.dart';
import '../ui/pages/mfp_vote_answering_page/mfp_vote_answering_page.dart';
import '../ui/pages/mfp_vote_create_item_page/mfp_vote_create_item_page.dart';
import '../ui/pages/mfp_vote_create_page/mfp_vote_create_page.dart';
import '../ui/pages/mfp_vote_create_thx_page/mfp_vote_create_thx_page.dart';
import '../ui/pages/mfp_vote_create_view_page/mfp_vote_create_view_page.dart';
import '../ui/pages/mfp_vote_dashboard_page/mfp_vote_dashboard_page.dart';
import '../ui/pages/mfp_vote_detail_page/mfp_vote_detail_page.dart';
import '../ui/pages/mfp_vote_edit_item_page/mfp_vote_edit_item_page.dart';
import '../ui/pages/mfp_vote_edit_page/mfp_vote_edit_page.dart';
import '../ui/pages/mfp_vote_edit_thx_page/mfp_vote_edit_thx_page.dart';
import '../ui/pages/mfp_vote_edit_view_page/mfp_vote_edit_view_page.dart';
import '../ui/pages/mfp_vote_page/mfp_vote_page.dart';
import '../ui/pages/mfp_vote_post_all_page/mfp_vote_post_all_page.dart';
import '../ui/pages/mfp_vote_resultes_page/mfp_vote_resultes_page.dart';
import '../ui/pages/mfp_vote_seach_page/mfp_vote_seach_page.dart';
import '../ui/pages/mfp_voting_my_point_page/mfp_voting_my_point_page.dart';
import '../ui/pages/notification_card_page/notification_card_page.dart';
import '../ui/pages/page_manage_page/page_manage_page.dart';
import '../ui/pages/page_profile_page/page_profile_page.dart';
import '../ui/pages/photo_perview_page/photo_perview_page.dart';
import '../ui/pages/point_category_page/point_category_page.dart';
import '../ui/pages/point_event_detail_page/point_event_detail_page.dart';
import '../ui/pages/point_main_page/point_main_page.dart';
import '../ui/pages/point_product_detail_page/point_product_detail_page.dart';
import '../ui/pages/post_detail_page/post_detail_page.dart';
import '../ui/pages/privacy_policy_page/privacy_policy_page.dart';
import '../ui/pages/profile_detail_social_page/profile_detail_social_page.dart';
import '../ui/pages/profile_page/profile_page.dart';
import '../ui/pages/ranking_page/ranking_page.dart';
import '../ui/pages/register_page/register_page.dart';
import '../ui/pages/register_preview_page/register_preview_page.dart';
import '../ui/pages/search_page/search_page.dart';
import '../ui/pages/setting_page/setting_page.dart';
import '../ui/pages/slider_show_image_page/slider_show_image_page.dart';
import '../ui/pages/splash_page/splash_page.dart';
import '../ui/pages/sync_page_social_page/sync_page_social_page.dart';
import '../ui/pages/today_page/today_page.dart';
import '../ui/pages/unknown_route_page/unknown_route_page.dart';
import '../ui/pages/used_coupon_page/used_coupon_page.dart';
import '../ui/pages/user_coupon_page/user_coupon_page.dart';
import '../ui/pages/user_point_page/user_point_page.dart';
import '../ui/pages/web_view_login_mfp_page/web_view_login_mfp_page.dart';
import '../ui/pages/webview_emergency_page/webview_emergency_page.dart';
import '../ui/pages/webview_page/webview_page.dart';
import 'app_routes.dart';

const _defaultTransition = Transition.native;

class AppPages {
  static final unknownRoutePage = GetPage(
    name: AppRoutes.UNKNOWN,
    page: () => UnknownRoutePage(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.TODAY,
      page: () => TodayPage(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.DOING,
      page: () => DoingPage(),
      binding: DoingBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PAGE_PROFILE,
      page: () => PageProfilePage(),
      binding: PageProfileBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.POST_DETAIL,
      page: () => PostDetailPage(),
      binding: PostDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION_CARD,
      page: () => NotificationCardPage(),
      binding: NotificationCardBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.LOGIN_REGISTER,
      page: () => LoginRegisterPage(),
      binding: LoginRegisterBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.REGISTER_PREVIEW,
      page: () => RegisterPreviewPage(),
      binding: RegisterPreviewBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PRIVACY_POLICY,
      page: () => PrivacyPolicyPage(),
      binding: PrivacyPolicyBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.LOGIN_MAIN,
      page: () => LoginMainPage(),
      binding: LoginMainBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SYNC_PAGE_SOCIAL,
      page: () => SyncPageSocialPage(),
      binding: SyncPageSocialBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MENU,
      page: () => MenuPage(),
      binding: MenuBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.WEBVIEW_EMERGENCY,
      page: () => WebviewEmergencyPage(),
      binding: WebviewEmergencyBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.WEBVIEW,
      page: () => WebviewPage(),
      binding: WebviewBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ACCOUNT_MERGE,
      page: () => AccountMergePage(),
      binding: AccountMergeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ACCOUNT_MERGE_INPUT_OTP,
      page: () => AccountMergeInputOtpPage(),
      binding: AccountMergeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => SettingPage(),
      binding: SettingBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CONNECT_SOCIAL_MEDIA,
      page: () => ConnectSocialMediaPage(),
      binding: ConnectSocialMediaBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PAGE_MANAGE,
      page: () => PageManagePage(),
      binding: PageManageBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SLIDER_SHOW_IMAGE,
      page: () => SliderShowImagePage(),
      binding: SliderShowImageBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.HASH_TAG,
      page: () => HashTagPage(),
      binding: HashTagBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE_TEXT_FIELD,
      page: () => EditProfileTextFieldPage(),
      binding: EditProfileTextFieldBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.WEB_VIEW_LOGIN_MFP,
      page: () => WebViewLoginMfpPage(),
      binding: WebViewLoginMfpBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PROFILE_DETAIL_SOCIAL,
      page: () => ProfileDetailSocialPage(),
      binding: ProfileDetailSocialBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_DASHBOARD,
      page: () => MfpVoteDashboardPage(),
      binding: MfpVoteDashboardBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_DETAIL,
      page: () => MfpVoteDetailPage(),
      binding: MfpVoteDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE,
      page: () => MfpVotePage(),
      binding: MfpVoteBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_POST_ALL,
      page: () => MfpVotePostAllPage(),
      binding: MfpVotePostAllBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_SEACH,
      page: () => MfpVoteSeachPage(),
      binding: MfpVoteSeachBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_RESULTES,
      page: () => MfpVoteResultesPage(),
      binding: MfpVoteResultesBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_CREATE,
      page: () => MfpVoteCreatePage(),
      binding: MfpVoteCreateBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_CREATE_ITEM,
      page: () => MfpVoteCreateItemPage(),
      binding: MfpVoteCreateItemBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_CREATE_VIEW,
      page: () => MfpVoteCreateViewPage(),
      binding: MfpVoteCreateViewBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_CREATE_THX,
      page: () => MfpVoteCreateThxPage(),
      binding: MfpVoteCreateThxBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_ANSWERING,
      page: () => MfpVoteAnsweringPage(),
      binding: MfpVoteAnsweringBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_EDIT,
      page: () => MfpVoteEditPage(),
      binding: MfpVoteEditBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_EDIT_ITEM,
      page: () => MfpVoteEditItemPage(),
      binding: MfpVoteEditItemBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_EDIT_VIEW,
      page: () => MfpVoteEditViewPage(),
      binding: MfpVoteEditViewBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTING_MY_POINT,
      page: () => MfpVotingMyPointPage(),
      binding: MfpVotingMyPointBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MFP_VOTE_EDIT_THX,
      page: () => MfpVoteEditThxPage(),
      binding: MfpVoteEditThxBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.DETAIL_FIRST,
      page: () => DetailFirstPage(),
      binding: DetailFirstBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.FIRST_PAGE,
      page: () => FirstPagePage(),
      binding: FirstPageBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.POINT_MAIN,
      page: () => const PointMainPage(),
      binding: PointMainBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.USER_COUPON,
      page: () => const UserCouponPage(),
      binding: UserCouponBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.RANKING,
      page: () => const RankingPage(),
      binding: RankingBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.USER_POINT,
      page: () => const UserPointPage(),
      binding: UserPointBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.POINT_EVENT_DETAIL,
      page: () => const PointEventDetailPage(),
      binding: PointEventDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.POINT_PRODUCT_DETAIL,
      page: () => const PointProductDetailPage(),
      binding: PointProductDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.POINT_CATEGORY,
      page: () => const PointCategoryPage(),
      binding: PointCategoryBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.USED_COUPON,
      page: () => const UsedCouponPage(),
      binding: UsedCouponBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PHOTO_PERVIEW,
      page: () => const PhotoPerviewPage(),
      binding: PhotoPerviewBinding(),
      transition: _defaultTransition,
    ),
  ];
}
