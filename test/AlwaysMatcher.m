#import "AlwaysMatcher.h"


@implementation AlwaysMatcher

- (BOOL)matchesView:(UIView *)view  inTree:(UIView *)root{
    return YES;
}
@end