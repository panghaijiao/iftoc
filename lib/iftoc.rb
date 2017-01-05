require "iftoc/version"
require 'pathname'

module Iftoc

  $fontNameRegexpStr = /font-family: "(.*)"/
  $iconRegexpStr = /.icon-(.*):before { content: "\\(.*)"/

  def parseSVGFontName(xmlContext)
    fontelement = xmlContext.root.elements["defs"].elements["font"]
    return fontelement.elements["font-face"].attributes["font-family"]
  end

  def parseSVGIconFont(xmlContext)
    iconfonts = Hash.new
    fontelement = xmlContext.root.elements["defs"].elements["font"]
    fontelement.get_elements("glyph").each { |font|
      name = font.attributes["glyph-name"]
      unicode = font.attributes["unicode"].to_s.delete("#x;")
      if unicode.length == 4 then
        iconfonts[name] = unicode
      end
    }
    return iconfonts
  end

  def parseCSSFontName(file)
      file.each_line do |line|
          line.chomp!
          $fontNameRegexpStr =~ line
          fontName = $1
          if fontName then
              return fontName
          end
      end
      return nil
  end
  
  def parseCSSIconFont(file)
      iconfonts = Hash.new
      file.each_line do |line|
          line.chomp!
          $iconRegexpStr =~ line
          name = $1
          if name then
              iconfonts[name] = $2
          end
      end
      return iconfonts
  end
  
  def generateHFile(iconfontMap)
      string1 = <<-EOB
//
//  IconFont.h
//  AutoCoding
//
      EOB
      
      string2 = <<-EOB
//  Copyright © 2017年 olinone. All rights reserved.
//
      
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
      
#define theIconFont [IconFont shareInstance]
      
@interface IconFont : NSObject
      
+ (instancetype)shareInstance;
      
+ (UIFont *)iconFontWithSize:(CGFloat)size;
      
      EOB
      
      hString = string1 + "//  Created by AutoCoding on " + Time.new.strftime("%Y/%m/%d") + ".\n" + string2
      
      iconfontMap.keys.each do |key|
          hString = hString + "@property (readonly) NSString *icon" + key + ";\n\n"
      end
      
      hString = hString + "@end"
      
      return hString
  end
  
  def generateMFile(iconFontName, iconfontMap)
      string1 = <<-EOB
//
//  IconFont.m
//  AutoCoding
//
      EOB
      
      string2 = <<-EOB
//  Copyright © 2017年 olinone. All rights reserved.
//
      
#import "IconFont.h"
      
@implementation IconFont
      
+ (instancetype)shareInstance {
    static IconFont *iconFont = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iconFont = [IconFont new];
    });
    return iconFont;
}
      
+ (UIFont *)iconFontWithSize:(CGFloat)size {
      EOB

    mString = string1 + "//  Created by AutoCoding on " + Time.new.strftime("%Y/%m/%d") + ".\n" + string2 + "    return [UIFont fontWithName:@\"" + iconFontName + "\" size:size];" + "\n}\n\n"

    iconfontMap.each { |key, value|
      mString = mString + "- (NSString *)icon" + key + " {\n";
      mString = mString + "    return @\"\\U0000" + value + "\";" + "\n}\n\n"
    }

    mString = mString + "@end"

    return mString
  end
          
  def putStringToFile(text, path)
          hio = File.open(path, "w+")
          hio.puts(text)
          hio.close
  end

  module_function :parseSVGFontName
  module_function :parseSVGIconFont
  module_function :parseCSSFontName
  module_function :parseCSSIconFont
  module_function :generateHFile
  module_function :generateMFile
  module_function :putStringToFile

end
