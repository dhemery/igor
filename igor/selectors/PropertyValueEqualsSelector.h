//
//  PropertyValueEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Selector.h"

@interface PropertyValueEqualsSelector : NSObject<Selector>

@property(readonly,retain) NSObject* desiredValue;
@property(readonly,retain) NSString* propertyName;

+(PropertyValueEqualsSelector*) selectorWithPropertyName:(NSString*)propertyName value:(NSObject*)value;

@end
