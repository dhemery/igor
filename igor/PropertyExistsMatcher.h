//
//  AttributeExistsSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyMatcher.h"
#import "PropertyInspector.h"

@interface PropertyExistsMatcher : NSObject <PropertyMatcher>

@property(readonly,retain) NSString* matchProperty;

+(id) forProperty:(NSString*)propertyName;
-(id) initForProperty:(NSString*)propertyName;

@end
