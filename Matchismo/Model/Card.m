// Created by Tzvi Straus.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Card

- (int) match:(NSArray *) otherCards {
  for (Card * card in otherCards) {
    if ([self.contents isEqualToString:card.contents]) {
      return 1;
    }
  }
  return 0;
}

@end

NS_ASSUME_NONNULL_END
