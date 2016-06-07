//
//  FISTicTacToeGame.m
//  DeployOnDay1Redux
//
//  Created by Timothy Clem on 9/22/15.
//  Copyright © 2015 The Flatiron School. All rights reserved.
//

#import "FISTicTacToeGame.h"

@interface FISTicTacToeGame ()

@property (nonatomic, strong) NSMutableArray *board;

@end


@implementation FISTicTacToeGame

-(instancetype)init
{
    self = [super init];
    if(self) {
        [self resetBoard];
    }

    return self;
}

-(void)resetBoard
{
    self.board = [@[[@[@"", @"", @""] mutableCopy], [@[@"", @"", @""] mutableCopy], [@[@"", @"", @""] mutableCopy]] mutableCopy];
}

-(NSString *)playerAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    return self.board[column][row];
}

-(BOOL)canPlayAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    if ([self.board[column][row] isEqualToString: @""]) {
        return YES;
    } else {
        return NO;
    }
}

-(void)playXAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    self.board[column][row] = @"X";
}

-(void)playOAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    self.board[column][row] = @"O";
}

-(NSString *)winningPlayer
{
    for (NSUInteger i = 0; i < 3; i++) {
        if ([self.board[i][0] isEqualToString: self.board[i][1]] && [self.board[i][0] isEqualToString: self.board[i][2]]) {
            return self.board[i][0];
        }
        if ([self.board[0][i] isEqualToString: self.board[1][i]] && [self.board[0][i] isEqualToString: self.board[2][i]]) {
            return self.board[0][i];
        }
    }
    
    if ([self.board[0][0] isEqualToString: self.board[1][1]] && [self.board[0][0] isEqualToString: self.board[2][2]]) {
        return self.board[0][0];
    }
    if ([self.board[0][2] isEqualToString: self.board[1][1]] && [self.board[0][2] isEqualToString: self.board[2][0]]) {
        return self.board[0][2];
    }
    return @"";
}

-(BOOL)isADraw
{
    NSArray *flatboard = [self.board valueForKeyPath: @"@unionOfArrays.self"];
    if ([flatboard containsObject:@""]) {
        return NO;
    } else {
        return YES;
    }
}

@end
