//
//  PropertyValueMatcher.h
//  igor
//
//  Created by Dale Emery on 11/22/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyMatcher.h"

@protocol PropertyValueMatcher <PropertyMatcher>

@property(readonly,retain) NSObject* matchValue;

@end
