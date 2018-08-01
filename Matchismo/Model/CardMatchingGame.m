//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Tzvi Straus on 25/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;

/// List of cards to match.
@property (nonatomic, strong) NSMutableArray *cards; // of Card

/// Queue conating currently chosen cards.
@property (nonatomic, strong) NSMutableArray *chosenCardsQueue; // of Card

@property (nonatomic, strong, readwrite) NSString *lastResultDescription;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)cardCount
                 usingDeck:(Deck *)deck
                 numCardMatchMode:(uint)numMode {
  assert(numMode >= 2);
  assert(numMode <= cardCount);
  
  if (self = [super init]) {
    self.numCardMatchMode = numMode;
    
    for (NSUInteger i = 0 ; i < cardCount; i++) {
      Card *card = [deck drawRandomCard];
      if(!card) {
        self = nil;
        return self;
      }
      [self.cards addObject:card];
    }
  }
  return self;
}

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)chosenCardsQueue {
  if (!_chosenCardsQueue) {
    _chosenCardsQueue = [[NSMutableArray alloc] init];
  }
  return _chosenCardsQueue;
}

- (Card *)cardAtIndex:(NSUInteger)index {
  if (index >= [self.cards count]) {
    return nil;
  }
  return self.cards[index];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)popChosenCardsQueue {
  assert([self.chosenCardsQueue count] > 0);
  Card *unchoose = self.chosenCardsQueue[0];
  unchoose.chosen = NO;
  [self.chosenCardsQueue removeObjectAtIndex:0];
}

- (void)calcScoreMismatch:(NSString *)cardsString {
  self.score -= MISMATCH_PENALTY;
  self.lastResultDescription = [[NSString alloc]
                                initWithFormat:
                                @"%@ don't match! %d points penalty!",
                                cardsString, MISMATCH_PENALTY];
}

- (void)calcScoreMatch:(NSString *)cardsString matchCount:(uint)matchCount matchScore:(uint)matchScore {
  uint addToScore = matchScore*(matchCount)*MATCH_BONUS;
  self.score += addToScore;
  self.lastResultDescription = [[NSString alloc]
                                initWithFormat:
                                @" Matched %@ for %d points.",
                                cardsString, addToScore ];
  
  for (Card * otherCard in self.chosenCardsQueue){
    otherCard.matched = YES;
  }
  [self.chosenCardsQueue removeAllObjects];
}

- (void)calScore:(uint)matchScore matchCount:(uint)matchCount
     cardsString:(NSString *)cardsString {
  if (matchCount == 0) {
    [self calcScoreMismatch:cardsString];
  } else {
    [self calcScoreMatch:cardsString matchCount:matchCount matchScore:matchScore];
  }
}

- (void)tryToMatch {
  uint matchCount = 0;
  uint matchScoreSum = 0;
  NSString *cardsStr =  [self cardsNames];
  for (Card * card in [self.chosenCardsQueue reverseObjectEnumerator]){
    assert(!card.isMatched);
    assert(card.isChosen);
    NSInteger matchScore = [card match:self.chosenCardsQueue];
    if (matchScore) {
      matchScoreSum += matchScore;
      matchCount+=1;
      card.matched = YES;
      [self.chosenCardsQueue removeObject:card];
    }
  }
  [self calScore:matchScoreSum matchCount:matchCount cardsString: cardsStr];
}

- (void)chooseNewCard:(Card *)card {
  assert(![self.chosenCardsQueue containsObject:card]);
  self.score -= COST_TO_CHOOSE;
  card.chosen = YES;
  [self.chosenCardsQueue addObject:card];
  self.lastResultDescription = [self cardsNames];

  if ([self.chosenCardsQueue count] < self.numCardMatchMode) {
    return;
  }
  
  [self tryToMatch];
  
  if ([self.chosenCardsQueue count] < self.numCardMatchMode) {
    return;
  }
  [self popChosenCardsQueue];
}

- (NSString *)cardsNames {
  NSMutableString *cardNames = [[NSMutableString alloc] init];
  for (Card * card in self.chosenCardsQueue) {
    [cardNames appendString:card.contents];
  }
  return cardNames;
}

- (void)unChooseCard:(Card *)card {
  card.chosen = NO;
  [self.chosenCardsQueue removeObject:card];
  self.lastResultDescription = [self cardsNames];
}

- (void)chooseCardAtIndex:(NSUInteger)index{
  Card *card = [self cardAtIndex:index];
  assert(card);
  assert(!card.isMatched);
  
  if(card.isChosen){
    [self unChooseCard:card];
    return;
  }
  [self chooseNewCard:card];
}

@end
