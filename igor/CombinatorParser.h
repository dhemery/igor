#import "Combinator.h"
#import "CombinatorParser.h"

@protocol QueryScanner;

@protocol CombinatorParser <NSObject>

- (id <Combinator>)parseCombinatorFromScanner:(id <QueryScanner>)scanner;

@end

@interface CombinatorParser : NSObject <CombinatorParser>
@end