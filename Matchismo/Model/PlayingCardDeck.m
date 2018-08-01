//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Tzvi Straus on 25/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init {
 
  if (self = [super init]) {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard *newCard = [[PlayingCard alloc]
                                initWithSuit:suit andRank:rank];
        [self addCard:newCard];
      }
    }
  }
  return self;
}

@end
