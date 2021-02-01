// A suduko puzzle is a 9x9 array with numbers from 0-9.

// Some examples:

var diagonal =
    [ [1,0,0,0,0,0,0,0,0]
    , [0,2,0,0,0,0,0,0,0]
    , [0,0,3,0,0,0,0,0,0]
    , [0,0,0,4,0,0,0,0,0]
    , [0,0,0,0,5,0,0,0,0]
    , [0,0,0,0,0,6,0,0,0]
    , [0,0,0,0,0,0,7,0,0]
    , [0,0,0,0,0,0,0,8,0]
    , [0,0,0,0,0,0,0,0,9] ];

var easy =
    [ [0,2,0,4,5,6,7,8,9]
    , [4,5,7,0,8,0,2,3,6]
    , [6,8,9,2,3,7,0,4,0]
    , [0,0,5,3,6,2,9,7,4]
    , [2,7,4,0,9,0,6,5,3]
    , [3,9,6,5,7,4,8,0,0]
    , [0,4,0,6,1,8,3,9,7]
    , [7,6,1,0,4,0,5,2,8]
    , [9,3,8,7,2,5,0,6,0] ];

var medium =
    [ [0,4,0,0,0,2,0,1,9]
    , [0,0,0,3,5,1,0,8,6]
    , [3,1,0,0,9,4,7,0,0]
    , [0,9,4,0,0,0,0,0,7]
    , [0,0,0,0,0,0,0,0,0]
    , [2,0,0,0,0,0,8,9,0]
    , [0,0,9,5,2,0,0,4,1]
    , [4,2,0,1,6,9,0,0,0]
    , [1,6,0,8,0,0,0,7,0] ];

var hard =
    [ [0,2,0,0,0,0,0,0,0]
    , [0,0,0,6,0,0,0,0,3]
    , [0,7,4,0,8,0,0,0,0]
    , [0,0,0,0,0,3,0,0,2]
    , [0,8,0,0,4,0,0,1,0]
    , [6,0,0,5,0,0,0,0,0]
    , [0,0,0,0,1,0,7,8,0]
    , [5,0,0,0,0,9,0,0,0]
    , [0,0,0,0,0,0,0,4,0] ];

var almostsolved =
    [ [0,2,3,4,5,6,7,8,9]
    , [4,5,7,1,8,9,2,3,6]
    , [6,8,9,2,3,7,1,4,5]
    , [8,1,5,3,6,2,9,7,4]
    , [2,7,4,8,9,1,6,5,3]
    , [3,9,6,5,7,4,8,1,2]
    , [5,4,2,6,1,8,3,9,7]
    , [7,6,1,9,4,3,5,2,8]
    , [9,3,8,7,2,5,4,6,1] ];

var solved =
    [ [1,2,3,4,5,6,7,8,9]
    , [4,5,7,1,8,9,2,3,6]
    , [6,8,9,2,3,7,1,4,5]
    , [8,1,5,3,6,2,9,7,4]
    , [2,7,4,8,9,1,6,5,3]
    , [3,9,6,5,7,4,8,1,2]
    , [5,4,2,6,1,8,3,9,7]
    , [7,6,1,9,4,3,5,2,8]
    , [9,3,8,7,2,5,4,6,1] ];

// Return an empty sudoku
function emptySudoku() {
    return [ [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0]
           , [0,0,0,0,0,0,0,0,0] ];
}


// Convert an array of arrays to a string keeping track of the inner
// arrays.
function arrayToString(arr) {
    //reduce the array with '[]' and linebreak between the elemets.
    //we have to start with empty string for the accumulator
    return arr.reduce((a, b) => a + '[' + b + ']<br>', ''); 
}


// Compute all 27 blocks of a sudoku. Returns all 9 rows, 9 cols and 9
// 3x3 blocks
function blocks(sud) {
    let rows = sud;
    let cols = emptySudoku();
    let blocks = emptySudoku();
    let arr = []

    //Making rows out of columns
    for(const i in sud) {
        for(const j in sud[i]) {
            cols[i][j] = sud[j][i]
        }
    }

    for(i = 0; i < 3; i++) {
        for(j = 0; j < 9; j++) {
            for(k = 0; k < 3; k++) {
                //Just adding them in a straight line becuase
                //I couldnt think of a better way
                arr.push(sud[j][k + i*3])
            }
        }
    }

    for(i = 0; i < 9; i++) {
        for(j = 0; j < 9; j++) {
            blocks[i][j] = arr[j + i*9]
        }
    }

    return rows.concat(cols).concat(blocks)
}


// Check that a block is valid (i.e. that it contains no duplicate
// number 1-9, but multiple 0 is fine).
function isValidBlock(b) {
    let numbersMap = {}
    for(const item of b) {
        if(item == 0) {
            continue
        }
        //If we've added the item to the map before, we have a duplicate
        if(numbersMap[item]) {
            return false
        } else {
            numbersMap[item] = true
        }
    }

    return true
}


// Check that a sudoku is valid by checking that all of its blocks are
// valid.
function isValid(sud) {
    for(const arr of blocks(sud)) {
        if(!isValidBlock(arr)) {
            return false
        }
    }
    return true
}

//Check if sudoku has zeroes
function hasZeroes(sud) {
    for(const arr of sud) {
        for(const el of arr) {
            if(el == 0) 
                return true
        }
    }

    return false
}


// Check if a sudoku is solved by checking that there are no zeroes
// and that it is valid.
function isSolved(sud) {
    return !hasZeroes(sud) && isValid(sud)
}


// Draw the start sudoku
function init(sud) {

}


// What to do when the user clicks on a tile (not called "click"
// because that caused some problems with some browsers)
function klick() {

}


// Fetch the current sudoku
function getSudoku() {

}
