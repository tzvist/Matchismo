// Created by Tzvi Straus.

#import <UIKit/UIKit.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

/// Abstract class for game view controller.
/// must implement below methods.
@interface CardGameViewController : UIViewController

/// Creats the relvanet For subclasses.
- (Deck *)creatDeck;

@end

NS_ASSUME_NONNULL_END
