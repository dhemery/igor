//
//  ClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "MemberOfClassMatcher.h"

@implementation MemberOfClassMatcher

@synthesize matchClass;

-(id) initForClass:(Class)aClass {
    if(self = [super init]) {
        matchClass = aClass;
    }
    return self;
}

+(id) forClass:(Class)aClass {
    return [[self alloc] initForClass:aClass];
}

-(BOOL)matchesView:(UIView *)view {
    return [view isMemberOfClass:self.matchClass];
}
@end
