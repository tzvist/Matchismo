
//
//  Deck.h
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

/// Object represents a deck of \c Card.
@interface Deck : NSObject

/// Adds a \c card to the end of the deck.
- (void)addCard:(Card *)card;

/// Returns (and pops) a random card from the deck.
- (Card *)drawRandomCard;

@end
