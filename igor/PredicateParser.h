#import "SimplePatternParser.h"

@class PredicateMatcher;
@protocol IgorQueryScanner;

@interface PredicateParser : NSObject <SimplePatternParser>

+ (id<SimplePatternParser>)parserWithScanner:(id<IgorQueryScanner>)scanner;

@end
