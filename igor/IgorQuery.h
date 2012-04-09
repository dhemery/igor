#import "Pattern.h"

@protocol SubjectMatcher;

@interface IgorQuery : Pattern

+ (IgorQuery *)forPattern:(NSString *)pattern;

- (id <SubjectMatcher>)parse;


@end
