@protocol Combinator <NSObject>

- (NSArray *)relativesOfView:(UIView *)view;

- (NSArray *)inverseRelativesOfView:(UIView *)subject;

- (NSArray *)inverseRelativesOfView:(UIView *)subject inTree:(UIView *)root;

@end
