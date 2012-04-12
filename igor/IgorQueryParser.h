@protocol SubjectMatcher;
@protocol IgorQueryScanner;
#import "InstanceChainParser.h"


@interface IgorQueryParser : NSObject

- (id<SubjectMatcher>)parseMatcherFromQuery:(NSString *)query;

+ (IgorQueryParser *)withQueryScanner:(id <IgorQueryScanner>)scanner instanceChainParser:(id <InstanceChainParser>)instanceChainParser;

@end
