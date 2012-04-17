#import "PatternParser.h"

@class PredicateMatcher;
@protocol QueryScanner;

@interface PredicateParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithScanner:(id <QueryScanner>)scanner;

@end
