//
//  AttributeExistsSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@interface PropertyExistsMatcher : NSObject <Matcher>

@property(retain) NSString* propertyName;

+(PropertyExistsMatcher*) forProperty:(NSString*)propertyName;

-(PropertyExistsMatcher*) initWithPropertyName:(NSString*)propertyName;

@end
