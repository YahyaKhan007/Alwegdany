import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:signal_lab/data/model/banner_model/banner_model.dart';
import 'package:signal_lab/data/model/blogs_model/blogs_model.dart';
import 'package:signal_lab/data/model/faqs/faqs_model.dart';

import '../../data/model/reports/reports_model.dart';

class NewApiClient {
  static const String baseUrl = 'https://alwegdany.com/';
  static const String abousUs = 'api/about-us';
  static const String blog = 'api/get-blogs';
  static const String reports = 'api/get-reports';
  static const String faqs = 'api/faqs';
  static const String banners = 'api/banners';

// ^   Getting Blogs
  Future<List<BlogsDataModel>?> getBlogs() async {
    log('click  1');
    String url = baseUrl + blog;

    try {
      var response = await http.get(Uri.parse(url));

      log(response.statusCode.toString());
      List<BlogsDataModel> blogsList = [];

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var blogs = jsonResponse['data']['blogs'];

        // Iterate through the faqs list
        for (var blog in blogs) {
          // ^ making FaqsModel from Json
          var blogModel = BlogsDataModel.fromJson(blog);
          blogsList.add(blogModel);
        }
      }
      return blogsList;
    } catch (e, stackTrace) {
      log('\n\nstack trace: $stackTrace\n\n');
      return null;
    }
  }

  // ^   Getting abous us
  Future<List<ReportsDataModel>?> getReports() async {
    log('click  1');
    String url = baseUrl + reports;

    try {
      var response = await http.get(Uri.parse(url));

      log(response.statusCode.toString());
      List<ReportsDataModel> reportsList = [];

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var reports = jsonResponse['data']['blogs'];

        // Iterate through the faqs list
        for (var report in reports) {
          // ^ making FaqsModel from Json
          var reportModel = ReportsDataModel.fromJson(report);
          reportsList.add(reportModel);
        }
      }
      return reportsList;
    } catch (e, stackTrace) {
      log('\n\nstack trace: $stackTrace\n\n');
      return null;
    }
  }

  // ^   Getting Reports
  Future<void> getAboutUs() async {
    return;
  }

  // ^   Getting banners
  Future<List<BannerModel>?> getBanners() async {
    String url = baseUrl + banners;

    try {
      var response = await http.get(Uri.parse(url));

      log(response.statusCode.toString());
      List<BannerModel> bannerList = [];

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var banners = jsonResponse['data']['banners']; 

        // Iterate through the faqs list
        for (var banner in banners) {
          // ^ making FaqsModel from Json
          var bannerModel = BannerModel.fromJson(banner);
          bannerList.add(bannerModel);
        }
      }
      return bannerList;
    } catch (e, stackTrace) {
      log('\n\nstack trace: $stackTrace\n\n');
      return null;
    }
  }

  // ~ ---------------------------------------------------
  // ~ ---------------------------------------------------
  // ~ ---------------------------------------------------
  // ~ ---------------------------------------------------
  // ~ ---------------------------------------------------
  // ~ ---------------------------------------------------

  // ^   Getting Faqs
  Future<List<FAQsModel>?> getFaqs() async {
    String url = baseUrl + faqs;

    try {
      var response = await http.get(Uri.parse(url));

      log(response.statusCode.toString());
      List<FAQsModel> faqsList = [];

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var faqs = jsonResponse['data']['faqs'];

        // Iterate through the faqs list
        for (var faq in faqs) {
          // ^ making FaqsModel from Json
          var faqModel = FAQsModel.fromJson(faq);
          faqsList.add(faqModel);
        }
      }
      return faqsList;
    } catch (e, stackTrace) {
      log('\n\nstack trace: $stackTrace\n\n');
      return null;
    }
  }
}
