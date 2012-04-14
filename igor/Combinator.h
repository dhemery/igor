@protocol Combinator <NSObject>

- (BOOL)collectMatchingRelativesOfViews:(NSArray *)targetViews inTree:(UIView *)tree intoArray:(NSMutableArray *)matchingRelatives;

@end