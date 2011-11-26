//
//  PropertyValueEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyValueMatcher.h"
#import "PropertyExistsMatcher.h"

@interface PropertyValueEqualsMatcher : PropertyExistsMatcher <PropertyValueMatcher>

+(id) forProperty:(NSString*)propertyName value:(NSObject*)value;

@end