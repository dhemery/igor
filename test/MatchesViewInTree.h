#import <OCHamcrestIOS/HCBaseMatcher.h>

@interface MatchesViewInTree : HCBaseMatcher

+ (MatchesViewInTree *) view:(UIView *)targetView inTree:(UIView *)root;

@end
