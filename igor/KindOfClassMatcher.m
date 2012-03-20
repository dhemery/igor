//
//  KindOfClassSelector.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "KindOfClassMatcher.h"

@implementation KindOfClassMatcher

@synthesize matchClass;

-(NSString*) description {
    return [NSString stringWithFormat:@"[KindOfClassMatcher:[matchClass:%@]]", matchClass];
}

+(KindOfClassMatcher*) forClass:(Class)targetClass {
    return [[self alloc] initForClass:targetClass];
}

-(KindOfClassMatcher*) initForClass:(Class)targetClass {
    if(self = [super init]) {
        matchClass = targetClass;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [view isKindOfClass:self.matchClass];
}

@end
