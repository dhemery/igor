@protocol Combinator;
@protocol QueryScanner;

@protocol CombinatorParser <NSObject>

- (id <Combinator>)parseCombinatorFromScanner:(id <QueryScanner>)scanner;

@end