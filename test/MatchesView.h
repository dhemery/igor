#import <OCHamcrestIOS/HCBaseMatcher.h>

@class MatchesViewInTree;

@interface MatchesView : HCBaseMatcher

+ (MatchesView *) view:(UIView *)targetView;
+ (MatchesViewInTree *) view:(UIView *)targetView inTree:(UIView *)root;

@end
