// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

/** # Color Bottle Game

## Description
The game has:

- 5 bottles of different colors in a sequence.

- Allows players 5 attempts to arrange bottles correctly

- Informs players of correct arrangements after each attempt

- Randomly shuffles bottles after 5 attempts

- Prevents players from continuing if they win; requires a new game.

- Takes player's attempted arrangement as input (5 integers: 1-5)

- Returns number of correct arrangements */

contract ColorBottleGame {
    // Has 5 bottles of different colors in a sequence
    uint8[] private bottles = [1, 2, 3, 4, 5];
    uint8[] private correctArrangement;
    uint8 private attempts = 0;
    bool private gameWon;

    constructor() {
        shuffleBottles();
    }

    function shuffleBottles() private {
        for (uint8 i = 0; i < bottles.length; i++) {
            uint8 temp = bottles[i];
            uint256 randomHash = uint256(
                keccak256(abi.encodePacked(block.timestamp, i))
            );
            uint8 randomIndex = uint8(randomHash % bottles.length);
            bottles[i] = bottles[randomIndex];
            bottles[randomIndex] = temp;
        }
    }

    function play(
        uint8[] memory arrangement
    ) public returns (uint8 correctArrangements) {
        // Prevents players from continuing if they win; requires a new game.
        require(!gameWon, "Game already won. Start a new game.");
        // Randomly shuffles bottles after 5 attempts
        if (attempts > 5) {
            shuffleBottles();
            attempts = 0;
        }

        uint8 correct = 0;
        for (uint8 i = 0; i < bottles.length; i++) {
            if (arrangement[i] == bottles[i]) {
                correct++;
            }
        }

        if (correct == 5) {
            gameWon = true;
        }

        //  Allows players 5 attempts to arrange bottles correctly
        attempts++;
        return correct;
    }

    function getBottles() public view returns (uint8[] memory) {
        return bottles;
    }

    function getCorrectArrangement() public view returns (uint8[] memory) {
        return correctArrangement;
    }

    function getAttempts() public view returns (uint8) {
        return attempts;
    }

    function isGameWon() public view returns (bool) {
        return gameWon;
    }
}
