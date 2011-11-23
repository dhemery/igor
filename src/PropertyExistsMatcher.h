//
//  AttributeExistsSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyValueMatcher.h"

@interface PropertyExistsMatcher : NSObject <PropertyMatcher>

+(id) forProperty:(NSString*)propertyName;

@end
