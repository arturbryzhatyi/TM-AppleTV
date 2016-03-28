//
//  TextAnalyzer.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/24/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextAnalyzer.h"

@implementation TextAnalyzer

+ (void)analyze:(NSString *)str
{
    NSString *question = @"What is the weather in San Francisco?";
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes: [NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
    tagger.string = question;
    [tagger enumerateTagsInRange:NSMakeRange(0, [question length])
                          scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
                         options:options
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          
        NSString *token = [question substringWithRange:tokenRange];
        NSString *breaks = @"\n\n\n\n\n\n";
        NSLog(@"%@ %@: %@ %@", breaks, token, tag, breaks);
    }];
    
/*
    str = @"Hey Siri, what's on my calendar today?";
    
    NSLinguisticTaggerOptions option = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
    
//    int taggerOption = INT32_C(option.rawValue);
    
    NSString *preferredLanguage = [[NSLocale preferredLanguages] firstObject];
    
    NSArray *tagSchemes = [NSLinguisticTagger availableTagSchemesForLanguage:preferredLanguage];
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagSchemes options:option];
    
    NSRange fullRange = NSMakeRange(0, str.length);
    
    [tagger setString:str];
    
    [tagger enumerateTagsInRange:fullRange
                          scheme:NSLinguisticTagSchemeLexicalClass
                         options:option
                      usingBlock:^(NSString * _Nonnull tag, NSRange tokenRange, NSRange sentenceRange, BOOL * _Nonnull stop) {
                          
                          NSLog(@"%@ - %@", [str substringWithRange:tokenRange], tag);
                      }];
*/
}

@end
