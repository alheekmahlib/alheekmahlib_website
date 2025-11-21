import 'dart:developer';
import 'dart:ui';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/extensions/dimensions.dart';
import '../../core/widgets/widgets.dart';
import '../controllers/general_controller.dart';
import 'data/model/our_app_info_model.dart';

part 'controllers/apps_info_controller.dart';
part 'screen/our_apps_screen.dart';
part 'widgets/app_card_widget.dart';
part 'widgets/apps_grid_skeleton_widget.dart';
part 'widgets/apps_info.dart';
