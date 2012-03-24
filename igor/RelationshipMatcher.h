@protocol RelationshipMatcher <NSObject>

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)root;

@end