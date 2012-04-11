@protocol SubjectMatcher <NSObject>

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root;

@end