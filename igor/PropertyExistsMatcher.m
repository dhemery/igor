//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "NSObject+PropertyInspector.h"
#import "PropertyExistsMatcher.h"

@implementation PropertyExistsMatcher

@synthesize matchProperty;

-(id) initForProperty:(NSString*)thePropertyName {
    if(self = [super init]) {
        matchProperty = thePropertyName;
    }
    return self;
}

+(id) forProperty:(NSString*)propertyName {
    return [[PropertyExistsMatcher alloc] initForProperty:(NSString*)propertyName];
}

-(BOOL) matchesView:(UIView *)view {
    return [view hasProperty:self.matchProperty];
}

@end
