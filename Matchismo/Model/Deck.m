//
//  Deck.m
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "Deck.h"
@interface Deck()

/// Array of cards in the deck.
@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  };
  return _cards;
}

- (void)addCard:(Card *)card {
  [self.cards addObject:card];
}

- (Card *)drawRandomCard {
  if (!self.cards || self.cards.count == 0) {
    return nil;
  }
  unsigned index = arc4random() % self.cards.count;
  Card *randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  
  return randomCard;
}

@end
