import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body style
  static get bodyMediumMontaga => theme.textTheme.bodyMedium!.montaga;
  static get bodyMediumMontaga13 =>
      theme.textTheme.bodyMedium!.montaga.copyWith(
        fontSize: 13.fSize,
      );
}

extension on TextStyle {
  TextStyle get montaga {
    return copyWith(
      fontFamily: 'Montaga',
    );
  }

  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }

  TextStyle get numans {
    return copyWith(
      fontFamily: 'Numans',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
}
