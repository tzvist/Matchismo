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
  [cardButton setAttributedTitle:[self cardConnten:setCard] forState:UIControlStateNormal];
  
  NSString *imageName = [self imageName:setCard ];
  UIImage *image = [UIImage imageNamed:imageName];

  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  cardButton.enabled = !setCard.isMatched;
}






/////------------------------------




- (NSArray *)validSymbols {
  return @[@"■",@"●",@"▲"];
}

- (NSArray *)validColors {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

- (NSArray *)validShadings {
  return @[@(0.0f), @(0.4f), @(1.0f)];
}
- (NSAttributedString *)cardConnten:(Card *)card {
  SetCard *setCard = (SetCard *)card;
  NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
  NSString *symbol = [self validSymbols][setCard.symbol];
  for (int i = 0 ; i<= setCard.number; i++) {
    [content.mutableString appendString:symbol];
  }
  
  NSNumber *valueAlpha = [self validShadings][setCard.shading];
  UIColor *color = [self validColors][setCard.color] ;
  
  float alpha = [valueAlpha floatValue];
  UIColor *colorWithAlpha = [color colorWithAlphaComponent:alpha];
  NSRange fullRange =  [content.string rangeOfString:content.string];
  [content addAttribute:NSForegroundColorAttributeName value:colorWithAlpha range:fullRange];
  [content addAttribute:NSStrokeWidthAttributeName value:@(-5) range: fullRange];
  [content addAttribute:NSStrokeColorAttributeName value:color range:fullRange];
  
  return content;
}










@end

NS_ASSUME_NONNULL_END
