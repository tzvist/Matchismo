// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Tzvi Straus.

#import "HistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *text;
@end

@implementation HistoryViewController
- (void)viewWillAppear:(BOOL)animated {
  [self.text setAttributedText:self.resultHistory];
}

@end

NS_ASSUME_NONNULL_END
