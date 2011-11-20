//
//  PropertyInspector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//


@interface NSObject (PropertyInspector)

-(BOOL) hasProperty:(NSString*)propertyName;
-(void) logPropertyDescriptions;
-(NSSet*) propertyDescriptions;
-(NSSet*) propertyNames;
-(NSArray*) sortedPropertyNames;
-(id) valueOfProperty:(NSString*)propertyName;

@end
