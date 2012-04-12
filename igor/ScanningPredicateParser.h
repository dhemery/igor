#import "PredicateParser.h"

@class PredicateMatcher;
@protocol IgorQueryScanner;

@interface ScanningPredicateParser : NSObject <PredicateParser>

+ (id<PredicateParser>)parserWithScanner:(id<IgorQueryScanner>)scanner;

@end
