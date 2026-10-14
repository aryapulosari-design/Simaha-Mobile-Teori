import 'package:flutter/foundation.dart';

/// Global gate status read by go_router redirect (outside widget tree).
/// [SessionNotifier] is the only writer.
///
/// Login mudah-aman: default terkunci. main.dart menentukan setup/lock
/// sebelum frame pertama agar tidak ada flash halaman yang salah.
enum GateStatus { setup, lock, ok }

final gateListenable = ValueNotifier<GateStatus>(GateStatus.lock);
