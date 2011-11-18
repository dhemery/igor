//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SelectorEngineRegistry.h"

@interface Igor : NSObject<SelectorEngine>
-(NSArray*) selectViewsWithSelector:(NSString*)selectorString fromRoot:(UIView*)root;
@end