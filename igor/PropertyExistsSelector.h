//
//  AttributeExistsSelector.h
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Selector.h"

@interface PropertyExistsSelector : NSObject <Selector>

@property(retain) NSString* propertyName;

+(PropertyExistsSelector*) selectorWithPropertyName:(NSString*)propertyName;

@end
