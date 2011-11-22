//
//  ClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "MemberOfClassMatcher.h"

@implementation MemberOfClassMatcher
    
+(MemberOfClassMatcher*) forClass:(Class)targetClass {
    return [[MemberOfClassMatcher alloc] initWithTargetClass:targetClass];
}

-(BOOL)matchesView:(UIView *)view {
    return [view isMemberOfClass:self.targetClass];
}
@end
