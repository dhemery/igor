//
//  PropertyValueEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyExistsSelector.h"

@interface PropertyValueEqualsSelector : PropertyExistsSelector

@property(readonly,retain) NSObject* desiredValue;

+(PropertyValueEqualsSelector*) selectorWithPropertyName:(NSString*)propertyName value:(NSObject*)value;

@end
