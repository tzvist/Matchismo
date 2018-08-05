// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;

@end

@implementation SetCardGameViewController

@dynamic cardBottuns;

- (Deck *)creatDeck {
  return [[SetCardDeck alloc] init];
}

- (uint)calcCardMatchMode {
  return 3;
}

- (NSString *)imageName:(SetCard *)SetCard {
  if (SetCard.isChosen) {
    return @"cardfront2";
  }
  return @"cardfront";
}

- (void)updateButton:(UIButton *)cardButton withCard:(Card*)card {
  if ([card isKindOfClass: @"SetCard"]) {
    return;
  }
  SetCard *setCard = (SetCard *)card;
  [cardButton setAttributedTitle:setCard.attributedContents forState:UIControlStateNormal];
  
  NSString *imageName = [self imageName:setCard ];
  UIImage *image = [UIImage imageNamed:imageName];

  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  cardButton.enabled = !setCard.isMatched;
}

@end

NS_ASSUME_NONNULL_END
