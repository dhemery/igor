//
//  KindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "KindOfClassSelector.h"

@implementation KindOfClassSelector
@synthesize targetClass;

-(KindOfClassSelector*) initWithTargetClass:(Class)aTargetClass {
    if(self = [super init]) {
        targetClass = aTargetClass;
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    return [view isKindOfClass:targetClass];
}

@end
