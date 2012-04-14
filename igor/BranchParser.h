#import "SubjectPatternParser.h"

@protocol IgorQueryScanner;
@class RelationshipParser;

@interface BranchParser : NSObject <SubjectPatternParser>

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner relationshipParser:(RelationshipParser *)relationshipParser;


@end