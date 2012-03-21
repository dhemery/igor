
#import "TreeWalker.h"

@implementation TreeWalker

+(void) walkTree:(UIView*)root withVisitor:(void(^)(UIView*))visit {
    visit(root);
    for(id subview in [root subviews]) {
        [self walkTree:subview withVisitor:visit];
    }
}

@end
