// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;

@end

@implementation PlayingCardGameViewController

//@dynamic game;
@dynamic cardBottuns;

- (Deck *)creatDeck {
  return [[PlayingCardDeck alloc] init];
}

- (uint)calcCardMatchMode {
  return 2;
}

- (NSString *)imageName:(PlayingCard *)playCard {
  if (playCard.isChosen) {
    return @"cardfront";
  }
  return @"cardback";
}

- (NSString *)cardContents:(PlayingCard *)playCard{
  if (playCard.isChosen) {
    return playCard.contents;
  }
  return @"";
}

- (void) updateButton:(NSUInteger) cardButtonIndex {
  Card *card = [_game cardAtIndex:cardButtonIndex];
  if ([card isKindOfClass: @"PlayingCard"]) {
    return;
  }
  PlayingCard *playCard = (PlayingCard *)card;
  UIButton *cardButton = self.cardBottuns[cardButtonIndex];

  NSString *imageName = [self imageName:playCard ];
  NSString *cardContents = [self cardContents:playCard];
  UIImage *image = [UIImage imageNamed:imageName];

  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  [cardButton setTitle:cardContents forState:UIControlStateNormal];

  cardButton.enabled = !playCard.isMatched;
}

@end

NS_ASSUME_NONNULL_END
