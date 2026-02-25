/// Central export file for common UI imports across the app.
///
/// Use in screens/widgets:
/// ```dart
/// import 'package:puntgpt_nick/core/app_imports.dart';
/// ```
///
/// Includes: Flutter, third-party packages, constants, router, utils, widgets,
/// and responsive utilities. Add screen-specific imports (providers, models,
/// feature widgets) separately.

// Flutter (hide RefreshCallback - clash cupertino vs material)
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

// Third-party (hide DeviceType to avoid clash with responsive_builder)
export 'package:animate_do/animate_do.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;
export 'package:go_router/go_router.dart';
export 'package:provider/provider.dart';
export 'package:shimmer/shimmer.dart';

// App - Constants
export 'package:puntgpt_nick/core/constants/constants.dart';
export 'package:puntgpt_nick/core/constants/text_style.dart';
export 'package:puntgpt_nick/core/enum/app_enums.dart';

// Router
export 'package:puntgpt_nick/core/router/app/app_router.dart';
export 'package:puntgpt_nick/core/router/app/app_routes.dart';
export 'package:puntgpt_nick/core/router/web/web_router.dart';
export 'package:puntgpt_nick/core/router/web/web_routes.dart' hide WebRouteExtension;

// Utils
export 'package:puntgpt_nick/core/utils/app_toast.dart';
export 'package:puntgpt_nick/core/utils/custom_loader.dart';
export 'package:puntgpt_nick/core/utils/date_formater.dart';
export 'package:puntgpt_nick/core/utils/de_bouncing.dart';
export 'package:puntgpt_nick/core/utils/field_validators.dart';
export 'package:puntgpt_nick/core/helper/date_picker.dart';

// Widgets
export 'package:puntgpt_nick/core/widgets/app_devider.dart';
export 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
export 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
export 'package:puntgpt_nick/core/widgets/app_text_field.dart';
export 'package:puntgpt_nick/core/widgets/image_widget.dart';
export 'package:puntgpt_nick/core/widgets/app_check_box.dart';
export 'package:puntgpt_nick/core/widgets/app_text_field_drop_down.dart';
export 'package:puntgpt_nick/core/widgets/on_button_tap.dart';

// Responsive
export 'package:puntgpt_nick/responsive/responsive_builder.dart';
