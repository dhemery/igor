//
//  Created by Dale on 11/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MapOperationCommand+IgorAdditions.h"

#import <UIKit/UIView.h>
#import "Igor.h"

@implementation MapOperationCommand (IgorAdditions)

- (NSArray *)selectViewsUsingUIQueryWithSelector:(NSString *)queryString{
    NSLog( @"Using Igor to select views with selector: %@", queryString );
    return [[Igor selectViewsThatMatchQuery:queryString] allObjects];
}

@end