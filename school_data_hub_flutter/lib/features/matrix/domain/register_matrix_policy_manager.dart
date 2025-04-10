import 'dart:convert';
import 'dart:developer';

import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:watch_it/watch_it.dart';

final _secureStorage = ServerpodSecureStorage();
final _envManager = di<EnvManager>();
