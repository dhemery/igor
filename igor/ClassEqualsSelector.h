//
//  ClassEqualsSelector.h
//  igor
//
//  Created by Dale Emery on 11/9/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Selector.h"

@interface ClassEqualsSelector : NSObject <Selector>
-(ClassEqualsSelector*) initWithTargetClass:(Class)targetClass;
@end
