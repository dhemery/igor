//
//  PropertyInspector.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyInspector : NSObject
-(void) logPropertyDescriptionsForClass:(Class)c;
-(BOOL) object:(id)object hasProperty:(NSString*)propertyName;
-(NSSet*) propertyNamesForClass:(Class)c;
-(NSArray*) sortedPropertyNamesForClass:(Class)c;
-(id) valueOfProperty:(NSString*)propertyName forObject:(id)object;
@end
