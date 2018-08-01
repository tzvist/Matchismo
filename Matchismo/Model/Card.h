//
//  Card.h
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Object represents a card.
@interface Card : NSObject

/// Card contents.
@property (strong, nonatomic) NSString *contents;

/// Card is chosen.
@property (nonatomic, getter=isChosen) BOOL chosen;

/// Card participates in a match.
@property (nonatomic, getter=isMatched) BOOL matched;

/// Returns score of matching self with a list of \c otherCards.
- (int)match:(NSArray *)otherCards;

@end
