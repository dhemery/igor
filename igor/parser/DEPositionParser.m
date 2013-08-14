#import "DEPositionParser.h"
#import "DEQueryScanner.h"
#import "DEUniversalMatcher.h"
#import "DEPositionMatcher.h"

static NSSet* _positionPatterns;

@implementation DEPositionParser

+(void) initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _positionPatterns = [NSSet setWithArray:@[@"empty", @"first-child", @"last-child", @"only-child"]];
    });
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    if (![scanner skipString:@":"]) {
        return nil;
    }

    NSString *expression;

    if (![scanner scanPositionPatternIntoString:&expression])
        [scanner failBecause:@"Expected a position pattern after the :"];
    
    if (![_positionPatterns containsObject:expression])
        [scanner failBecause:[NSString stringWithFormat:@"Expected to be one of valid position pattern (%@)", _positionPatterns]];

    return [DEPositionMatcher matcherForPosition:expression];
}

@end
