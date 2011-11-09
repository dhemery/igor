//
//  ClassEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassEqualsSelector.h"

@implementation ClassEqualsSelector {
@private
    Class matchClass;
}

-(ClassEqualsSelector*) initWithClass:(Class)aClass {
    if(self = [super init]) {
        matchClass = aClass;
    }
    return self;
}

-(BOOL)matchesView:(UIView *)view {
    return matchClass == [view class];
}
@end

