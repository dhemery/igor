//
//  ClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassEqualsSelector.h"

@implementation ClassEqualsSelector
    
-(BOOL)matchesView:(UIView *)view {
    return self.targetClass == [view class];
}
@end
