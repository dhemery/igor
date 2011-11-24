//
//  PropertyValueEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyExistsMatcher.h"

@interface PropertyValueEqualsMatcher : NSObject <PropertyValueMatcher>

@property(readonly,retain) NSString* matchProperty;

+(id) forProperty:(NSString*)propertyName value:(NSObject*)value;

@end
