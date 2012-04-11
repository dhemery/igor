#import <OCHamcrestIOS/HCBaseMatcher.h>

#import "MatchesViewInTree.h"

@interface MatchesView : HCBaseMatcher

+ (MatchesView *) view:(UIView *)targetView;
+ (MatchesViewInTree *) view:(UIView *)targetView inTree:(UIView *)root;

@end
