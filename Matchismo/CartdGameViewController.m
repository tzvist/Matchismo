//
//  ViewController.m
//  Matchismo
//
//  Created by Tzvi Straus on 24/07/2018.
//  Copyright © 2018 Tzvi Straus. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lastResultDescription;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitch;
@property ( strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@end

@implementation ViewController

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
    default:
      assert(NO);
      return 2;
  }
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
  NSUInteger cardCount = [self.cardBottuns count];
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
  for ( NSUInteger cardButtonIndex = 0; cardButtonIndex < [self.cardBottuns count]; cardButtonIndex++ ) {
    [self updateButton: cardButtonIndex];
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastResultDescription.text = self.game.lastResultDescription;
}

- (void) updateButton:(NSUInteger) cardButtonIndex {
  Card *card = [self.game cardAtIndex:cardButtonIndex];
  
  NSString * imageName;
  NSString * cardContents;
  
  if (card.isChosen){
    imageName = @"cardfront";
    cardContents = card.contents;
  }else {
    imageName = @"cardback";
    cardContents = @"";
  }
  UIButton *cardButton = self.cardBottuns[cardButtonIndex];
  [self setCardUI:cardButton imageName:imageName cardContents:cardContents isEnabled:(BOOL) !card.isMatched];
}

- (void) setCardUI:(UIButton *) card imageName:(NSString *) imageName
      cardContents:(NSString *) cardContents isEnabled:(BOOL)isEnabled {
  UIImage * image = [UIImage imageNamed:imageName];
  [card setBackgroundImage: image  forState:UIControlStateNormal];
  [card setTitle: cardContents forState:UIControlStateNormal];
  card.enabled = isEnabled;
}

@end
