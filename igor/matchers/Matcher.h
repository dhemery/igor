//
//  Selector.h
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol Matcher

- (BOOL)matchesView:(UIView *)view;

@end
