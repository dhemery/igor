#import <OCHamcrestIOS/HCBaseMatcher.h>

#import "MatchesViewInTree.h"

@interface MatchesView : HCBaseMatcher

+ (MatchesView *) view:(UIView *)view;
+ (MatchesViewInTree *) view:(UIView *)view inTree:(UIView *)tree;

@end
