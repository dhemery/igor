@protocol Combinator;

@protocol CombinatorParser <NSObject>

- (id <Combinator>)parseCombinator;

@end