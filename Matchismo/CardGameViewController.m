//  Created by Tzvi Straus.

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lastResultDescription;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardBottuns;

@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

/// Models \c game
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSString *resultDescriptions;

@end

@implementation CardGameViewController

@synthesize game = _game;

- (CardMatchingGame *)game {
  if (!_game) {
    _game = [self createNewGame];
  }
  return _game;
}

- (uint)calcCardMatchMode {
  assert(NO);
}

- (void)viewWillAppear:(BOOL)animated {
  if(!self.resultDescriptions) {
    self.resultDescriptions = @"";
  }
  [self updateUI];
}

//
//- (void)viewDidDisappear:(BOOL)animated {
//  _game = nil;
//  self.resultDescriptions = @"";
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  if (![segue.identifier isEqualToString:@"show_history"]) {
    return;
  }
  HistoryViewController *history = (HistoryViewController *)segue.destinationViewController;
  history.history = self.resultDescriptions;
}

- (IBAction)changeCardMatchMode {
  self.game.numCardMatchMode = [self calcCardMatchMode];
}

- (Deck *)creatDeck { // abstract method
  assert(NO);
}

- (CardMatchingGame *)createNewGame {
  Deck *deck = [self creatDeck];
  NSUInteger cardCount = [self.cardBottuns count];
  uint numCardMatchMode = [self calcCardMatchMode];
  
  return [[CardMatchingGame alloc] initWithCardCount:cardCount usingDeck:deck numCardMatchMode:numCardMatchMode];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger cardButtonIndex = [self.cardBottuns  indexOfObject:sender];
  [self.game chooseCardAtIndex:cardButtonIndex];
  [self updateUI];
}

- (IBAction)redeal {
  _game = nil;
  self.resultDescriptions = @"";
  [self updateUI];
}

- (void) updateUI {
  
  for ( NSUInteger cardButtonIndex = 0; cardButtonIndex < self.cardBottuns.count; cardButtonIndex++ ) {
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    UIButton *cardButton = self.cardBottuns[cardButtonIndex];
    [self updateButton:cardButton withCard:card];
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastResultDescription.text = self.game.lastResultDescription;
  if (self.game.lastResultDescription) {
    self.resultDescriptions = [self.resultDescriptions stringByAppendingString:@"\n"];
    self.resultDescriptions = [self.resultDescriptions stringByAppendingString:self.game.lastResultDescription];
  }
}

- (void)updateButton:(UIButton *)cardButton withCard:(Card*)card {
  assert(NO);
};

@end

NS_ASSUME_NONNULL_END
