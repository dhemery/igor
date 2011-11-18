//
//  ClassSelector.m
//  
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "ClassSelector.h"

@implementation ClassSelector
@synthesize targetClass;

-(ClassSelector*) initWithTargetClass:(Class)aTargetClass {
    if(self = [super init]) {
        targetClass = aTargetClass;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Unimplemented method"
                                 userInfo:nil];
}
@end
