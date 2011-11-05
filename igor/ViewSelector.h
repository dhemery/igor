//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ViewSelector : NSObject
- (NSMutableSet *)selectViewsFromRoot:(UIView *)root;
+ (ViewSelector *)selectorFor:(NSString *)selectorString;
@end