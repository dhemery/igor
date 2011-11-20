//
//  PropertyInspector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyInspector : NSObject
-(BOOL) class:(Class)c hasProperty:(NSString*)propertyName;
-(NSSet*) propertyNamesForClass:(Class)c;
-(void) logSortedPropertyNamesForClass:(Class)c;
-(NSArray*) sortedPropertyNamesForClass:(Class)c;
@end
