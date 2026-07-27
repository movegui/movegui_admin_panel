import 'package:flutter/material.dart';

@immutable
class MoveGuiColors extends ThemeExtension<MoveGuiColors> {
  final Color restaurant;
  final Color pressing;
  final Color supermarket;
  final Color pharmacy;
  final Color delivery;

  const MoveGuiColors({
    required this.restaurant,
    required this.pressing,
    required this.supermarket,
    required this.pharmacy,
    required this.delivery,
  });

  @override
  MoveGuiColors copyWith({
    Color? restaurant,
    Color? pressing,
    Color? supermarket,
    Color? pharmacy,
    Color? delivery,
  }) {
    return MoveGuiColors(
      restaurant: restaurant ?? this.restaurant,
      pressing: pressing ?? this.pressing,
      supermarket: supermarket ?? this.supermarket,
      pharmacy: pharmacy ?? this.pharmacy,
      delivery: delivery ?? this.delivery,
    );
  }

  @override
  MoveGuiColors lerp(
    ThemeExtension<MoveGuiColors>? other,
    double t,
  ) {
    if (other is! MoveGuiColors) return this;

    return MoveGuiColors(
      restaurant: Color.lerp(restaurant, other.restaurant, t)!,
      pressing: Color.lerp(pressing, other.pressing, t)!,
      supermarket: Color.lerp(supermarket, other.supermarket, t)!,
      pharmacy: Color.lerp(pharmacy, other.pharmacy, t)!,
      delivery: Color.lerp(delivery, other.delivery, t)!,
    );
  }


  /*
  ThemeData(
  extensions: [
    const MoveGuiColors(
      restaurant: Colors.orange,
      pressing: Colors.indigo,
      supermarket: Colors.green,
      pharmacy: Colors.teal,
      delivery: Colors.purple,
    ),
  ],
)
final colors = Theme.of(context).extension<MoveGuiColors>()!;
color: colors.restaurant
color: colors.delivery
  */
}