//
//  FISComputerPlayer.m
//  DeployOnDay1Redux
//
//  Created by Timothy Clem on 9/22/15.
//  Copyright © 2015 The Flatiron School. All rights reserved.
//

#import "FISComputerPlayer.h"

@implementation FISComputerPlayer




+(BOOL)isEnabled
{
    return YES;
}

-(FISTicTacToePosition)nextPlay
{
    NSMutableArray *board = self.game.board;
    NSString *yourSign = @"X";
    NSUInteger counter = 0;
    NSArray *flatboard = [board valueForKeyPath: @"@unionOfArrays.self"];
    
    NSUInteger column = 9;
    NSUInteger row = 9;
    

    
    for (NSString *element in flatboard) {
        if ([element isEqualToString:@""]) {
            counter++;
        }
    }
    if (counter % 2 == 0) {
        yourSign = @"O";
    }
    
    if (counter == 9) {
        NSLog(@"\n\n\n   ---   NEW GAME   ---");
    }
    
    NSLog(@"\nInitializing -- player: %@, move: %li, column: %li, row: %li", yourSign, 10 - counter, column, row);
    
    
    for (NSUInteger i = 0; i < 3; i++) {
        if (([board[i][0] isEqualToString: board[i][1]] && ![board[i][0] isEqualToString:@""]) && [board[i][2] isEqualToString:@""]) {
            NSLog(@"-- Inside [i][0] <-> [i][1]"); //////////////////////////
            column = i;
            row = 2;
            if ([board[i][0] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        } else if (([board[i][1] isEqualToString: board[i][2]] && ![board[i][1] isEqualToString:@""]) && [board[i][0] isEqualToString:@""]) {
            NSLog(@"-- Inside [i][1] <-> [i][2]"); //////////////////////////
            column = i;
            row = 0;
            if ([board[i][1] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        } else if (([board[i][0] isEqualToString: board[i][2]] && ![board[i][0] isEqualToString:@""]) && [board[i][1] isEqualToString:@""]) {
            NSLog(@"-- Inside [i][0] <-> [i][2]"); //////////////////////////
            column = i;
            row = 1;
            if ([board[i][0] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        } else if (([board[0][i] isEqualToString: board[1][i]] && ![board[0][i] isEqualToString:@""]) && [board[2][i] isEqualToString:@""]) {
            NSLog(@"-- Inside [0][i] <-> [1][i]"); //////////////////////////
            column = 2;
            row = i;
            if ([board[0][i] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        } else if (([board[1][i] isEqualToString: board[2][i]] && ![board[1][i] isEqualToString:@""]) && [board[0][i] isEqualToString:@""]) {
            NSLog(@"-- Inside [1][i] <-> [2][i]"); //////////////////////////
            column = 0;
            row = i;
            if ([board[1][i] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        } else if (([board[0][i] isEqualToString: board[2][i]] && ![board[0][i] isEqualToString:@""] && [board[1][i] isEqualToString:@""])) {
            NSLog(@"-- Inside [0][i] <-> [2][i]"); //////////////////////////
            column = 1;
            row = i;
            if ([board[0][i] isEqualToString: yourSign]) {
                return FISTicTacToePositionMake(column, row);
            }
        }
        NSLog(@"Inside the loop -- i: %li, column: %li, row: %li", i, column, row);
    }
    
    NSArray *rightDiagonal = @[board[0][0], board[1][1], board[2][2]];
    NSArray *leftDiagonal = @[board[2][0], board[1][1], board[0][2]];
    
    if ((([rightDiagonal[0] isEqualToString: rightDiagonal[1]] || [rightDiagonal[0] isEqualToString: rightDiagonal[2]]) && ![rightDiagonal[0] isEqualToString:@""]) ||
        ([rightDiagonal[1] isEqualToString: rightDiagonal[2]] && ![rightDiagonal[1] isEqualToString:@""])) {
        
        if ([rightDiagonal containsObject:@""]) {
            NSUInteger blankElementIndex = [rightDiagonal indexOfObject:@""];
            column = blankElementIndex;
            row = blankElementIndex;
        }
        
    }
    
    if ((([leftDiagonal[0] isEqualToString: leftDiagonal[1]] || [leftDiagonal[0] isEqualToString: leftDiagonal[2]]) && ![leftDiagonal[0] isEqualToString:@""]) ||
        ([leftDiagonal[1] isEqualToString: leftDiagonal[2]] && ![leftDiagonal[1] isEqualToString:@""])) {
        if ([leftDiagonal containsObject:@""]) {
            NSUInteger blankElementIndex = [leftDiagonal indexOfObject:@""];
            column = 2 - blankElementIndex;
            row = blankElementIndex;
        }
        
    }
    
    NSLog(@"After diagonals -- column: %li, row: %li", column, row);
    
    if (column > 2 || row > 2) {
        column = arc4random_uniform(3);
        row = arc4random_uniform(3);
        while (![board[column][row] isEqualToString:@""]) {
            column = arc4random_uniform(3);
            row = arc4random_uniform(3);
        }
    }
    
    NSLog(@"Before return -- column: %li, row: %li", column, row);
    
    return FISTicTacToePositionMake(column, row);
}

@end
