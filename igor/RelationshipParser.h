#import "CombinatorParser.h"
#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;

@interface RelationshipParser : NSObject <SubjectPatternParser, CombinatorParser>

@property (strong) NSArray *subjectPatternParsers;

+ (RelationshipParser *)parserWithCombinatorParsers:(NSArray *)combinatorParsers;

@end
