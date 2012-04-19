@protocol Combinator <NSObject>

- (NSArray *)relativesOfView:(UIView *)view;

- (NSArray *)inverseRelativesOfView:(UIView *)subject;

@end
