//
//  Card.m
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *) otherCards {
  for (Card * card in otherCards) {
    if ([self.contents isEqualToString:card.contents]) {
      return 1;
    }
  }
  return 0;
}

@end
