//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Tzvi Straus on 25/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

/// Object represents a card matching game.
@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes Deck with the given parameters.
///
/// @param cardCount num of cards in the game.
/// @param deck used to draw  random cards.
/// @param numMode the amount of cards in a match.
- (instancetype)initWithCardCount:(NSUInteger)cardCount
                        usingDeck:(Deck *)deck
                 numCardMatchMode:(uint)numMode
                 NS_DESIGNATED_INITIALIZER;

/// Represents choosing a card \c index, in a card match.
- (void)chooseCardAtIndex:(NSUInteger) index;

/// Returns the card at \c index.
- (Card *)cardAtIndex:(NSUInteger) index;

/// Represents the current \c score.
@property (nonatomic, readonly) NSInteger score;

/// Represents the number of cards to be matched in the game.
@property (nonatomic) uint numCardMatchMode;

/// Text description of the last result.
@property (nonatomic, readonly) NSString *lastResultDescription;
@end
