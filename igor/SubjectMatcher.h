@protocol SubjectMatcher <NSObject>

- (BOOL)matchesView:(UIView *)view withinTree:(UIView *)root;

@end