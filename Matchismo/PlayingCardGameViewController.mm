// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()

@end

@implementation PlayingCardGameViewController

- (Deck *)creatDeck {
  return [[PlayingCardDeck alloc] init];
}

- (uint)calcCardMatchMode {
  return 2;
}

- (void)updateButton:(UIButton *)cardButton withCard:(Card*)card {
  if (![card isKindOfClass:[PlayingCard class]]) {
    return;
  }
  PlayingCard *playCard = (PlayingCard *)card;
  
  NSString *cardContents = [self cardContents:playCard];
  
  NSString *imageName = [self imageName:playCard];
  UIImage *image = [UIImage imageNamed:imageName];
  
  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  [cardButton setTitle:cardContents forState:UIControlStateNormal];
  
  cardButton.enabled = !playCard.isMatched;
}

- (NSAttributedString *)cardConnten:(Card *)card {
  if (![card isKindOfClass:[PlayingCard class]]) {
    return [[NSAttributedString alloc] init];
  }
  PlayingCard *playCard = (PlayingCard *)card;
  return [[NSAttributedString alloc] initWithString:playCard.contents];
}


- (NSString *)imageName:(PlayingCard *)playCard {
  if (playCard.isChosen) {
    return @"cardfront";
  }
  return @"cardback";
}

- (NSString *)cardContents:(PlayingCard *)playCard {
  if (playCard.isChosen) {
    return playCard.contents;
  }
  return @"";
}

@end

NS_ASSUME_NONNULL_END
