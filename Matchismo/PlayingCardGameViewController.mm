// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (Deck *)creatDeck {
  return [[PlayingCardDeck alloc] init];
}
@end

NS_ASSUME_NONNULL_END
#
