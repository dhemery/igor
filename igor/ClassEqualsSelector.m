//
//  ClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassEqualsSelector.h"

@implementation ClassEqualsSelector
@synthesize targetClass;
    
-(ClassEqualsSelector*) initWithTargetClass:(Class)aTargetClass {
    if(self = [super init]) {
        targetClass = aTargetClass;
    }
    return self;
}

-(BOOL)matchesView:(UIView *)view {
    return targetClass == [view class];
}
@end

