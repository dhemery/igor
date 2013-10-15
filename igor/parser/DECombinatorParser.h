@protocol DECombinator;
@protocol DEQueryScanner;

@protocol DECombinatorParser <NSObject>

- (id <DECombinator>)parseCombinatorFromScanner:(id <DEQueryScanner>)scanner;

@end

@interface DECombinatorParser : NSObject <DECombinatorParser>
@end