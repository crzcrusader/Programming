import random
import os
import time

# ---------------------------------------------
# Memory Game with Best Score Table
# ---------------------------------------------

# Function to read scores from file
def load_scores(filename="scores.txt"):
    scores = {}
    if os.path.exists(filename):
        with open(filename, "r") as f:
            for line in f:
                name, value = line.strip().split(":")
                scores[name] = int(value)
    return scores

# Function to save scores to file
def save_scores(scores, filename="scores.txt"):
    with open(filename, "w") as f:
        for name, value in scores.items():
            f.write(f"{name}:{value}\n")

# Function to display best scores
def display_best_scores(scores):
    if not scores:
        print("\nNo scores yet — be the first to set one!\n")
        return

    print("\n🏆 Best Scores 🏆")
    print("-" * 20)
    for name, value in sorted(scores.items(), key=lambda x: x[1]):
        print(f"{name}: {value} attempts")
    print("-" * 20)

# Function to generate shuffled board
def create_board():
    symbols = ["A", "B", "C", "D"]  # 4 pairs = 8 cards total
    cards = symbols * 2
    random.shuffle(cards)
    return cards

# Function to print the board
def print_board(guessed, cards):
    print("\nBoard:")
    for i, card in enumerate(cards):
        if i in guessed:
            print(f"[{card}]", end=" ")
        else:
            print(f"[{i}]", end=" ")
    print("\n")

# Main game logic
def play_game():
    player_name = input("Enter your name: ").capitalize()
    cards = create_board()
    guessed = set()
    attempts = 0

    while len(guessed) < len(cards):
        print_board(guessed, cards)
        try:
            first = int(input("Pick the first card number: "))
            second = int(input("Pick the second card number: "))
        except ValueError:
            print("Invalid input. Enter a number.")
            continue

        if first == second or first not in range(len(cards)) or second not in range(len(cards)):
            print("Invalid selection. Try again.")
            continue

        attempts += 1

        print(f"You flipped {cards[first]} and {cards[second]}")

        if cards[first] == cards[second]:
            print("✅ It's a match!")
            guessed.add(first)
            guessed.add(second)
        else:
            print("❌ Not a match. Try again.")
            time.sleep(1)

    print(f"\n🎉 Congratulations, {player_name}! You completed the game in {attempts} attempts.")

    # Load existing scores and update if better
    scores = load_scores()
    if player_name not in scores or attempts < scores[player_name]:
        scores[player_name] = attempts
        print("🏅 New personal best!")

    # Save updated scores and display leaderboard
    save_scores(scores)
    display_best_scores(scores)

# Run the game
if __name__ == "__main__":
    print("=== MEMORY GAME ===")
    existing_scores = load_scores()
    display_best_scores(existing_scores)
    play_game()
