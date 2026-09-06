import 'package:catalog_core/catalog_core.dart';

import '../l10n/app_localizations.dart';

/// The name of a Looks group as the user reads it; an unknown group
/// (from a newer version) shows as stored.
String looksGroupLabel(AppLocalizations t, String group) => switch (group) {
  'size' => t.looksGroupSize,
  'colours' => t.looksGroupColours,
  'pattern' => t.looksGroupPattern,
  'fur' => t.looksGroupFur,
  'tail' => t.looksGroupTail,
  'ears' => t.looksGroupEars,
  'marks' => t.looksGroupMarks,
  'crest' => t.looksGroupCrest,
  'beak' => t.looksGroupBeak,
  'ring' => t.looksGroupRing,
  _ => group,
};

/// The name of a Looks value as the user reads it. Values are shared
/// across groups (black is black on a coat or a beak); yes and no are
/// the app's own.
String looksValueLabel(AppLocalizations t, String group, String value) =>
    switch (value) {
      'yes' => t.valueYes,
      'no' => t.valueNo,
      'small' => t.looksValueSmall,
      'medium' => t.looksValueMedium,
      'large' => t.looksValueLarge,
      'black' => t.looksValueBlack,
      'white' => t.looksValueWhite,
      'grey' => t.looksValueGrey,
      'brown' => t.looksValueBrown,
      'ginger' => t.looksValueGinger,
      'cream' => t.looksValueCream,
      'golden' => t.looksValueGolden,
      'tan' => t.looksValueTan,
      'green' => t.looksValueGreen,
      'blue' => t.looksValueBlue,
      'yellow' => t.looksValueYellow,
      'red' => t.looksValueRed,
      'orange' => t.looksValueOrange,
      'pink' => t.looksValuePink,
      'white bib' => t.looksValueWhiteBib,
      'white paws' => t.looksValueWhitePaws,
      'white tail tip' => t.looksValueWhiteTailTip,
      'blaze' => t.looksValueBlaze,
      'mask' => t.looksValueMask,
      'spots' => t.looksValueSpots,
      'patches' => t.looksValuePatches,
      'stripes' => t.looksValueStripes,
      'scar' => t.looksValueScar,
      'notched ear' => t.looksValueNotchedEar,
      'ear tip' => t.looksValueEarTip,
      'collar' => t.looksValueCollar,
      'short' => t.looksValueShort,
      'long' => t.looksValueLong,
      'hairless' => t.looksValueHairless,
      'bobtail' => t.looksValueBobtail,
      'none' => t.looksValueNone,
      'curled' => t.looksValueCurled,
      'upright' => t.looksValueUpright,
      'floppy' => t.looksValueFloppy,
      'folded' => t.looksValueFolded,
      'rounded' => t.looksValueRounded,
      'solid' => t.looksValueSolid,
      'tabby' => t.looksValueTabby,
      'tortoiseshell' => t.looksValueTortoiseshell,
      'calico' => t.looksValueCalico,
      'colourpoint' => t.looksValueColourpoint,
      'bicolour' => t.looksValueBicolour,
      'tuxedo' => t.looksValueTuxedo,
      'brindle' => t.looksValueBrindle,
      'merle' => t.looksValueMerle,
      'spotted' => t.looksValueSpotted,
      'patched' => t.looksValuePatched,
      'tricolour' => t.looksValueTricolour,
      'sable' => t.looksValueSable,
      _ => value,
    };

/// A stored Looks line as one readable line: `Size: Medium · Colours:
/// Black, White`, in the device language.
String looksDisplay(AppLocalizations t, String value) {
  final looks = parseLooks(value);
  final parts = [
    for (final g in looksGroupOrder)
      if (looks[g] case final values?)
        '${looksGroupLabel(t, g)}: '
            '${(values.toList()..sort()).map((v) => looksValueLabel(t, g, v)).join(', ')}',
  ];
  return parts.isEmpty ? value : parts.join(' · ');
}
