//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyExistsMatcher.h"
#import "PropertyInspector.h"

@implementation PropertyExistsMatcher

@synthesize matchProperty, property;

+(id) forProperty:(NSString*)propertyName {
    return [[self alloc] initForProperty:(NSString*)propertyName];
}

-(id) initForProperty:(NSString*)propertyName {
    if(self = [super init]) {
        property = [PropertyInspector forProperty:propertyName];
    }
    return self;
}

-(NSString*) matchProperty {
    return property.propertyName;
}

-(BOOL) matchesView:(UIView *)view {
    return [property existsOn:view];
}

@end
