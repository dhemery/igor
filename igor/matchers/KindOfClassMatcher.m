//
//  KindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "KindOfClassMatcher.h"

@implementation KindOfClassMatcher

+(KindOfClassMatcher*) forClass:(Class)targetClass {
    return [[KindOfClassMatcher alloc] initWithTargetClass:targetClass];
}

-(BOOL) matchesView:(UIView *)view {
    return [view isKindOfClass:self.targetClass];
}

@end
