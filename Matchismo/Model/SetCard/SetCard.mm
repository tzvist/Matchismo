// Created by Tzvi Straus.

#import "SetCard.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface SetCard()

/// SetCard number.
@property (nonatomic, readwrite) NSUInteger number;

/// SetCard symbol.
@property (nonatomic, readwrite) NSUInteger symbol;

/// SetCard shading.
@property (nonatomic, readwrite) NSUInteger shading;

/// SetCard color.
@property (nonatomic, readwrite) NSUInteger color;

@end

@implementation SetCard

- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(NSUInteger)symbol
                       shading:(NSUInteger)shading
                         color:(NSUInteger)color {
  if (self = [super init]) {
    self.number = number;
    self.symbol = symbol;
    self.shading = shading;
    self.color = color;
  }
  return self;
}

+ (NSArray *)validSymbols {
  return @[@"■",@"●",@"▲" ];
}

+ (NSArray *)validColors {
  return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

+ (NSArray *)validShadings {
  return @[@(0.0f),@(0.4f), @(1.0f)];
}
@dynamic attributedContents;
- (NSAttributedString *)attributedContents {
  NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
  NSString *symbol = [SetCard validSymbols][self.symbol];
  for (int i = 0 ; i<=self.number; i++) {
    [content.mutableString appendString:symbol];
  }
  
  NSNumber *valueAlpha = [SetCard validShadings][self.shading];
  UIColor *color = [SetCard validColors][self.color] ;

  float alpha = [valueAlpha floatValue];
  UIColor *colorWithAlpha = [color colorWithAlphaComponent:alpha];
  NSRange fullRange =  [content.string rangeOfString:content.string];
  [content addAttribute:NSForegroundColorAttributeName value:colorWithAlpha range:fullRange];
  [content addAttribute:NSStrokeWidthAttributeName value:@(-5) range: fullRange];
  [content addAttribute:NSStrokeColorAttributeName value:color range:fullRange];
  
  return content;
}

- (NSString *)contents {
  return @"";
}

- (BOOL)allDifferentArray:(NSArray *)numbers {
  for (int i = 0 ; i < numbers.count; i++) {
    long num1 = [numbers[i] longValue];
    for (int j = 0 ; j< i; j++) {
      long num2 = [numbers[j] longValue];
      if (num1 == num2) {
       return NO;
      }
    }
  }
  return YES;
}

- (BOOL)allEqualArray:(NSArray *)numbers {
  for (NSNumber *num in numbers) {
    if (![num isEqual:numbers[0]]) {
      return NO;
    }
  }
  return YES;
}

- (BOOL)allEqualOrAllDifferentArray:(NSArray *)characteristics {
  return ([self allEqualArray:characteristics] ||
          [self allDifferentArray:characteristics]);
}

- (int)match:(NSArray *) otherCards {
  NSMutableArray *characteristics = [[NSMutableArray alloc] init];
  for (SetCard *card in otherCards) {
    [characteristics addObject: @(card.number)];
  }
  if (! [self allEqualOrAllDifferentArray:characteristics]) {
    return 0;
  }
  [characteristics removeAllObjects];
  
  for (SetCard *card in otherCards) {
    [characteristics addObject: @(card.symbol)];
  }
  if (! [self allEqualOrAllDifferentArray:characteristics]) {
    return 0;
  }
  [characteristics removeAllObjects];
  
  for (SetCard *card in otherCards) {
    [characteristics addObject: @(card.shading)];
  }
  if (! [self allEqualOrAllDifferentArray:characteristics]) {
    return 0;
  }
  [characteristics removeAllObjects];
  
  for (SetCard *card in otherCards) {
    [characteristics addObject: @(card.color)];
  }
  if (! [self allEqualOrAllDifferentArray:characteristics]) {
    return 0;
  }
  return 1;
}

+ (NSUInteger)OptionsCount {
  return 3;
}

@end

NS_ASSUME_NONNULL_END
