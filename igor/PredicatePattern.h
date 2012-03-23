@class PredicateMatcher;

@interface PredicatePattern : NSObject

-(PredicateMatcher*)parse:(NSScanner*)scanner;

@end
