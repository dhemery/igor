#import "SimpleMatcher.h"

@interface TreeWalker : NSObject

+ (void)walkTree:(UIView *)root withVisitor:(void(^)(UIView *))visitor;

@end
