//
//  PropertyDescription.m
//  igor
//
//  Created by Dale Emery on 11/20/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyDescription.h"

@implementation PropertyDescription
@synthesize sourceType, sourceName, propertyName;

-(PropertyDescription*) initWithPropertyName:(NSString*)thePropertyName sourceName:(NSString*)theSourceName sourceType:(NSString*)theSourceType {
    if(self = [super init]) {
        propertyName = thePropertyName;
        sourceName = theSourceName;
        sourceType = theSourceType;
    }
    return self;
}

-(NSUInteger) hash {
    return [propertyName hash] + [sourceName hash] + [sourceType hash];
}

-(BOOL) isEqual:(id)object {
    PropertyDescription* other = (PropertyDescription*)other;
    return [propertyName isEqual:other.propertyName]
    && [sourceName isEqual:other.sourceName]
    && [sourceType isEqual:other.sourceType];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Property %@ declared on %@ %@", propertyName, sourceType, sourceName];
}

+(PropertyDescription*) descriptionWithPropertyName:(NSString*)propertyName sourceName:(NSString*)sourceName sourceType:(NSString*)sourceType {
    return [[PropertyDescription alloc] initWithPropertyName:propertyName sourceName:sourceName sourceType:sourceType];
}

@end
