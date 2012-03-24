#import "AlwaysMatcher.h"


@implementation AlwaysMatcher

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)root {
    return YES;
}
@end