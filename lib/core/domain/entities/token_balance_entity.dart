import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_balance_entity.freezed.dart';

@freezed
sealed class TokenBalanceEntity with _$TokenBalanceEntity {
  const factory TokenBalanceEntity({
    required String tokenId,
    required String symbol,
    required String balance,
    required String iconUrl,
  }) = _TokenBalanceEntity;
}
