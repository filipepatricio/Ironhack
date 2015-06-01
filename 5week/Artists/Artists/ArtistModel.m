//
//  ArtistModel.m
//  Artists
//
//  Created by Filipe Patrício on 01/06/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "ArtistModel.h"
#import "NSString+Random.h"

@implementation ArtistModel


-(void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeInteger:self.artistID forKey:@"id"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.longDescription forKey:@"description"];
    [coder encodeObject:self.stage forKey:@"stage"];
    [coder encodeObject:self.imageURL forKey:@"image_url"];
    [coder encodeObject:self.startDate forKey:@"start_date"];
}

-(instancetype)initWithCoder:(NSCoder*)decoder
{
    if(self = [[ArtistModel alloc] init])
    {
        self.artistID = [decoder decodeIntegerForKey:@"id"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.longDescription = [decoder decodeObjectForKey:@"description"];
        self.stage = [decoder decodeObjectForKey:@"stage"];
        self.imageURL = [decoder decodeObjectForKey:@"image_url"];
        self.startDate = [decoder decodeObjectForKey:@"start_date"];
    }
    
    return self;
}

-(id)copyWithZone:(NSZone*)zone
{
    ArtistModel *copyArtist = [[ArtistModel allocWithZone:zone] init];
    if(copyArtist)
    {
        copyArtist.artistID = self.artistID;
        copyArtist.name = [self.name copyWithZone:zone];
        copyArtist.longDescription = [self.longDescription copyWithZone:zone];
        copyArtist.stage = [self.stage copyWithZone:zone];
        copyArtist.imageURL = [self.imageURL copyWithZone:zone];
        copyArtist.startDate = [self.startDate copyWithZone:zone];
        
    }
    return copyArtist;
}

- (BOOL)isEqual:(id)object
{
    if(object == self)
        return YES;
    else if( !object || ![object isKindOfClass:[self class]])
        return NO;
    return [self isEqualToArtist:object];
}

- (BOOL)isEqualToArtist:(ArtistModel*)artist
{
    //THE FIELDS THAT WE USE HERE WE SHOULD USE IN HASH
    if(![self.name isEqualToString:artist.name])
        return NO;
    else if (![self.stage isEqualToString:artist.stage])
        return NO;
    return YES;
}

- (NSUInteger)hash
{
    return self.name.hash ^ self.stage.hash;
}

+(instancetype)randomArtist
{
    
    ArtistModel *artist = [[ArtistModel alloc] init];
    if(artist)
    {
        artist.artistID = arc4random_uniform(10);
        artist.name = [NSString randomNameGeneratorWithLength:10];
    }
    
    
    return artist;
}




@end
