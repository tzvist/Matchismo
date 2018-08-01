//
//  PlayingCardDeck.h
//  Matchismo
//
//  Created by Tzvi Straus on 25/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "Deck.h"

/// Object representing Deck of \c PlayingCard.
@interface PlayingCardDeck : Deck

/// initializes with a full deck (52 cards)
- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end
