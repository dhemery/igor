//
//  IdentityMatcher.m
//  igor
//
//  Created by Dale Emery on 3/20/12.
//  Copyright (c) 2012 Dale H. Emery. All rights reserved.
//

#import "IdentityMatcher.h"
#import "Matcher.h"

@implementation IdentityMatcher {
    UIView* matchView;
}

+(IdentityMatcher*) forView:(UIView*)view {
    return [[IdentityMatcher alloc] initForView:view];
}

-(IdentityMatcher*) initForView:(UIView*)view {
    if(self = [super init]) {
        matchView = view;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return matchView == view;
}
@end
