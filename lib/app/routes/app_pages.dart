import 'package:get/get.dart';
import 'package:stock_app/app/modules/company_detail/views/payment_admin_view.dart';
import 'package:stock_app/app/modules/company_detail/views/payment_page_admin_midtrans_view.dart';
import 'package:stock_app/app/modules/dashboard/views/detail_technical_view.dart';
import 'package:stock_app/app/modules/dashboard/views/isi_technical_view.dart';
import 'package:stock_app/app/modules/news/views/news_view.dart';
import 'package:stock_app/app/modules/profile/views/subscriber_profile_view.dart';
import 'package:stock_app/app/modules/subscribe/views/add_plan_view.dart';
import 'package:stock_app/app/modules/subscribe/views/detail_analyst_gafixview.dart';
import 'package:stock_app/app/modules/subscribe/views/payment_page_midtrans_view.dart';
import 'package:stock_app/app/modules/subscribe/views/public_post_detail_view.dart';
import 'package:stock_app/core.dart';

import '../modules/analyst_page/bindings/analyst_page_binding.dart';
import '../modules/analyst_page/views/analyst_page_view.dart';
import '../modules/company_detail/bindings/company_detail_binding.dart';
import '../modules/company_detail/views/company_detail_tabel_view.dart';
import '../modules/company_detail/views/company_detail_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dashboard/views/fundamental_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listing/bindings/listing_binding.dart';
import '../modules/listing/views/listing_view.dart';
import '../modules/listing_news/bindings/listing_news_binding.dart';
import '../modules/listing_news/views/listing_news_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/plan/bindings/plan_binding.dart';
import '../modules/porto/bindings/porto_binding.dart';
import '../modules/porto/views/porto_all_detail_view.dart';
import '../modules/porto/views/porto_view.dart';
import '../modules/post/bindings/post_binding.dart';
import '../modules/post/views/post_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/detail_report_view.dart';
import '../modules/profile/views/history_report_view.dart';
import '../modules/profile/views/notification_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/subscribe/bindings/subscribe_binding.dart';
import '../modules/subscribe/views/detail_analyst_view.dart';
import '../modules/subscribe/views/edit_post_view.dart';
import '../modules/subscribe/views/midtrans_view.dart';
import '../modules/subscribe/views/plan_view.dart';
import '../modules/subscribe/views/public_post_view.dart';
import '../modules/subscribe/views/subscribe_and_post_view.dart';
import '../modules/subscribe/views/subscribe_view.dart';
import '../modules/subscribe/views/subsmidtrans_view.dart';
import '../modules/tagihan/bindings/tagihan_binding.dart';
import '../modules/tagihan/views/tagihan_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_DETAIL,
      page: () => CompanyDetailView(),
      binding: CompanyDetailBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PORTO,
      page: () => PortoView(),
      binding: PortoBinding(),
    ),
    GetPage(
      name: _Paths.LISTING,
      page: () => ListingView(),
      binding: ListingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIBE,
      page: () => SubscribeView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.ANALYST_PAGE,
      page: () => AnalystPageView(),
      binding: AnalystPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.LISTING_NEWS,
      page: () => ListingNewsView(),
      binding: ListingNewsBinding(),
    ),
    GetPage(
      name: _Paths.NEWS,
      page: () => NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.TAGIHAN,
      page: () => TagihanView(),
      binding: TagihanBinding(),
    ),
    GetPage(
      name: _Paths.PUBLIC_POST,
      page: () => PublicPostView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.PUBLIC_POST_DETAIL,
      page: () => PublicPostDetailView(),
      binding: SubscribeBinding(),
    ),
    // GetPage(
    //   name: _Paths.PROFILE_REPORT,
    //   page: () => ProfileReportView(),
    //   binding: ProfileBinding(),
    // ),
    GetPage(
      name: _Paths.POST,
      page: () => PostView(),
      binding: PostBinding(),
    ),
    GetPage(
      name: _Paths.PORTO_ALL_DETAIL,
      page: () => PortoAllDetailView(),
      binding: PortoBinding(),
    ),
    GetPage(
      name: _Paths.SUBS_MIDTRANS,
      page: () => SubsMidtransView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_POST_VIEW,
      page: () => EditPostView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.SUBS_AND_POST,
      page: () => SubscribeAndPostView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.ISI_TECHNICAL,
      page: () => IsiTechnicalView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE_MIDTRANS,
      page: () => PaymentPageMidtransView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ANALYST,
      page: () => DetailAnalystView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MIDTRANS,
      page: () => MidtransView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE_ADMIN_MIDTRANS,
      page: () => PaymentPageAdminMidtransView(),
      binding: CompanyDetailBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_ADMIN,
      page: () => PaymentAdminView(),
      binding: CompanyDetailBinding(),
    ),
    GetPage(
      name: _Paths.PLAN,
      page: () => PlanView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PLAN,
      page: () => AddPlanView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.MINE_POST,
      page: () => MinePostView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TECHNICAL,
      page: () => DetailTechnicalView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_DETAIL_TABEL,
      page: () => CompanyDetailTabelView(),
      binding: CompanyDetailBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_REPORT,
      page: () => HistoryReportView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_REPORT,
      page: () => DetailReportView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIBER_PROFILE,
      page: () => SubscriberProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FUNDAMENTAL,
      page: () => FundamentalView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.TECHNICAL,
      page: () => TechnicalView(
        inputHistory: [],
        percentValue: '',
        selectedComparison: '',
        selectedFundamental: '',
        Tampil: [],
      ),
      binding: DashboardBinding(),
    ),
  ];
}
