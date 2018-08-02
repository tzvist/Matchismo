// Created by Tzvi Straus.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class for game view controller.
/// must implement below methods.
@interface CardGameViewController : UIViewController

{
@protected
  CardMatchingGame *_game;
}
/// protected
- (Deck *)creatDeck;

/// protected
- (uint)calcCardMatchMode;

/// protected
- (void) updateButton:(NSUInteger) cardButtonIndex;


/// protected
//- (NSString *)imageName:(Card *)card;

/// protected
///- (NSString *)cardContents:(Card *)card;


@end


NS_ASSUME_NONNULL_END
