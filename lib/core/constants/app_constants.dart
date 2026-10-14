// Application-wide constants for SIMAHA Offline.
//
// Assumptions for Tahap A (documented per PRD rule #2):
// - Default SKS limit for semester-1 students: 20 SKS.
// - Grade ranges (customizable later in settings, Tahap H):
//   A: >=85, AB: 80-84, B: 75-79, BC: 70-74, C: 60-69, D: 50-59, E: <50.
// - Grade weights: A=4, AB=3.5, B=3, BC=2.5, C=2, D=1, E=0.
// - Risk levels: <30 Aman, 30-60 Waspada, >60 Kritis.

/// Database file name on device.
const String kDatabaseFileName = 'simaha.db';

/// Key used in flutter_secure_storage for the SQLCipher raw key (hex).
const String kDbKeyStorageKey = 'simaha_db_raw_key_hex';

/// App storage: device id key.
const String kDeviceIdStorageKey = 'simaha_device_id';

/// Default SKS cap for first-semester students (no prior IPS).
const int kDefaultFirstSemesterSksCap = 20;

/// SKS caps by previous IPS (PRD section 5, exact).
const double kSksCapIpsA = 3.00;
const double kSksCapIpsB = 2.50;
const double kSksCapIpsC = 2.00;

/// Search performance budget: 100 rows <= 500 ms (PRD nonfunctional).
const int kSearchBudgetMs = 500;

/// Pagination defaults.
const int kDefaultPageSize = 20;

/// Grade table: (minScore, letter, weight).
const List<GradeBand> kGradeBands = <GradeBand>[
  GradeBand(minScore: 85, letter: 'A', weight: 4.0),
  GradeBand(minScore: 80, letter: 'AB', weight: 3.5),
  GradeBand(minScore: 75, letter: 'B', weight: 3.0),
  GradeBand(minScore: 70, letter: 'BC', weight: 2.5),
  GradeBand(minScore: 60, letter: 'C', weight: 2.0),
  GradeBand(minScore: 50, letter: 'D', weight: 1.0),
  GradeBand(minScore: 0, letter: 'E', weight: 0.0),
];

/// Small immutable value for a grade band.
class GradeBand {
  const GradeBand({
    required this.minScore,
    required this.letter,
    required this.weight,
  });

  final double minScore;
  final String letter;
  final double weight;
}

/// Risk level thresholds.
const double kRiskSafeMax = 30.0;
const double kRiskWatchMax = 60.0;

/// Auto-lock default (minutes). Configurable in Tahap H.
const int kDefaultAutoLockMinutes = 5;

/// Max PIN failures before temporary lock (Tahap B enforces this).
const int kMaxPinFailures = 5;
