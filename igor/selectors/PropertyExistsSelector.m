//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyInspector.h"
#import "PropertyExistsSelector.h"

@implementation PropertyExistsSelector

@synthesize propertyName;

-(PropertyExistsSelector*) initWithPropertyName:(NSString*)thePropertyName {
    if(self = [super init]) {
        self.propertyName = thePropertyName;
    }
    return self;
}

+(PropertyExistsSelector*) selectorWithPropertyName:(NSString*)propertyName {
    return [[PropertyExistsSelector alloc] initWithPropertyName:(NSString*)propertyName];
}

-(BOOL) matchesView:(UIView *)view {
    return [[PropertyInspector new] object:view hasProperty:propertyName];
}

@end
