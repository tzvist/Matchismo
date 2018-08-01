//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastResultDescription;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;

@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

/// Models \c game
@property ( strong,nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

@synthesize game = _game;

- (CardMatchingGame *)game {
  if ( !_game) {
    _game = [self createNewGame];
  }
  return _game;
}

- (void)setGame:(CardMatchingGame *)game {
  _game = game;
}

- (uint)getNumCardMatchMode {
  switch (self.modeSwitch.selectedSegmentIndex) {
    case 0:
      return 2;
    case 1:
      return 3;
    case 2:
      return 4;
  }
  assert(NO);
}

- (IBAction)changeCardMatchMode {
  self.game.numCardMatchMode = [self getNumCardMatchMode];
}

- (CardMatchingGame *)createNewGame {
  Deck *deck = [[PlayingCardDeck alloc] init];
  NSUInteger cardCount = [self.cardBottuns count];
  uint numCardMatchMode = [self getNumCardMatchMode];
  
  return [[CardMatchingGame alloc] initWithCardCount:cardCount usingDeck:deck numCardMatchMode:numCardMatchMode];
}

- (CardMatchingGame *)CreateCardMatchingGame {
  Deck *deck = [[PlayingCardDeck alloc] init];
  NSUInteger cardCount = self.cardBottuns.count;
  uint numCardMatchMode = [self getNumCardMatchMode];
  
  return [[CardMatchingGame alloc] initWithCardCount:cardCount usingDeck:deck numCardMatchMode:numCardMatchMode];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  self.modeSwitch.enabled = NO;
  NSUInteger cardButtonIndex = [self.cardBottuns  indexOfObject:sender];
  [self.game chooseCardAtIndex:cardButtonIndex];
  [self updateUI];
}

- (IBAction)redeal {
  self.game = nil;
  [self updateUI];
  self.modeSwitch.enabled = YES;
}

- (void) updateUI {
  for ( NSUInteger cardButtonIndex = 0; cardButtonIndex < self.cardBottuns.count; cardButtonIndex++ ) {
    [self updateButton:cardButtonIndex];
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastResultDescription.text = self.game.lastResultDescription;
}

- (NSString *)imageName:(Card *)card {
  if (card.isChosen) {
    return @"cardfront";
  }
  return @"cardback";
}

- (NSString *)cardContents:(Card *)card {
  if (card.isChosen) {
    return card.contents;
  }
  return @"";
}
- (void) updateButton:(NSUInteger) cardButtonIndex {
  
  Card *card = [self.game cardAtIndex:cardButtonIndex];
  UIButton *cardButton = self.cardBottuns[cardButtonIndex];
  
  NSString *imageName = [self imageName:card ];
  NSString *cardContents = [self cardContents:card];
  UIImage *image = [UIImage imageNamed:imageName];
  
  [cardButton setBackgroundImage:image forState:UIControlStateNormal];
  [cardButton setTitle:cardContents forState:UIControlStateNormal];
  cardButton.enabled = !card.isMatched;
}

@end
