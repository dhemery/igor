//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Igor : NSObject
- (NSMutableSet *)selectViewsFromRoot:(UIView *)root;
+ (Igor *)igorFor:(NSString *)selectorString;
@end