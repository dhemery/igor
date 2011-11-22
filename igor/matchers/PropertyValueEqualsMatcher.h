//
//  PropertyValueEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyExistsMatcher.h"

@interface PropertyValueEqualsMatcher : PropertyExistsMatcher

@property(readonly,retain) NSObject* desiredValue;

+(PropertyValueEqualsMatcher*) forProperty:(NSString*)propertyName value:(NSObject*)value;

-(PropertyValueEqualsMatcher*) initWithPropertyName:(NSString*)propertyName value:(NSObject*)value;

@end
