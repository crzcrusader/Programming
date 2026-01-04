#What this program does
#4×4 grid (16 cards, 8 matching pairs) using emoji symbols.
#Click a tile to reveal it; click a second tile to try to match.
#If the pair matches they stay revealed and disabled; otherwise they flip back after a short pause.
#Shows moves, matches, and an elapsed timer.
#A Restart button resets and reshuffles.
#Clean, readable code with comments and a step-by-step explanation below.*/

#!/usr/bin/env python3
"""
memory_game.py

A simple Memory/Concentration game using Tkinter.
Paste into VS Code and run with: python memory_game.py
"""

import tkinter as tk
from tkinter import messagebox
import random
import time

# -------------------------
# CONFIGURATION / CONSTANTS
# -------------------------
ROWS = 4
COLS = 4
PAIRS = (ROWS * COLS) // 2
FLIP_DELAY_MS = 500   # milliseconds to show two non-matching cards before flipping back

# Choose any set of 8 distinct symbols (emojis or simple text). If your system doesn't show emojis,
# replace with letters like ['A','B','C',...].
SYMBOLS = ["🍎", "🍌", "🍇", "🍒", "🍑", "🍍", "🥝", "🍉",
           "⭐", "🌙", "☀️", "⚡", "💧", "🔥", "🍀", "🎵", "👻","💍"]


class MemoryGame:
    def __init__(self, master):
        self.master = master
        master.title("Memory Match Game")

        # Top frame for stats and controls
        top_frame = tk.Frame(master)
        top_frame.pack(pady=8)

        # Moves / matches / timer labels
        self.moves = 0
        self.matches = 0
        self.start_time = None
        self.timer_running = False

        self.moves_label = tk.Label(top_frame, text=f"Moves: {self.moves}", font=("Arial", 12))
        self.moves_label.grid(row=0, column=0, padx=8)

        self.matches_label = tk.Label(top_frame, text=f"Matches: {self.matches}/{PAIRS}", font=("Arial", 12))
        self.matches_label.grid(row=0, column=1, padx=8)

        self.timer_label = tk.Label(top_frame, text="Time: 0.0s", font=("Arial", 12))
        self.timer_label.grid(row=0, column=2, padx=8)

        restart_btn = tk.Button(top_frame, text="Restart", command=self.restart_game)
        restart_btn.grid(row=0, column=3, padx=8)

        # Main frame for card buttons
        self.board_frame = tk.Frame(master)
        self.board_frame.pack(padx=10, pady=10)

        # Game state
        self.buttons = {}            # (r,c) -> Button widget
        self.card_values = {}        # (r,c) -> symbol (what the card hides)
        self.revealed = {}           # (r,c) -> bool
        self.locked = False          # lock clicks during flip-back delay
        self.first_selection = None  # (r,c) of the first flipped card in a pair
        self._create_board()
        self.restart_game()

    # -------------------------
    # Board creation & helpers
    # -------------------------
    def _create_board(self):
        """Create button widgets in a grid and bind them to click handler."""
        for r in range(ROWS):
            for c in range(COLS):
                btn = tk.Button(self.board_frame,
                                text="?",          # initial hidden display
                                width=6, height=3,
                                font=("Arial", 20),
                                command=lambda row=r, col=c: self.on_card_click(row, col))
                btn.grid(row=r, column=c, padx=5, pady=5)
                self.buttons[(r, c)] = btn
                self.revealed[(r, c)] = False
                self.card_values[(r, c)] = None

    def _shuffle_cards(self):
        """Assign symbols randomly to board positions (two of each symbol)."""
        # pick PAIRS many symbols from SYMBOLS (support SYMBOLS longer than needed)
        chosen = random.sample(SYMBOLS, PAIRS)
        deck = chosen * 2                 # duplicate to make pairs
        random.shuffle(deck)
        # Map deck entries to (r,c)
        it = iter(deck)
        for r in range(ROWS):
            for c in range(COLS):
                self.card_values[(r, c)] = next(it)
                self.revealed[(r, c)] = False

    # -------------------------
    # Gameplay & UI handlers
    # -------------------------
    def on_card_click(self, r, c):
        """Handler for when a card button is clicked."""
        if self.locked:
            # temporarily ignore clicks while cards are waiting to flip back
            return
        if self.revealed[(r, c)]:
            # already revealed matched card or currently face-up
            return

        # Start timer on first user click
        if not self.timer_running:
            self.start_timer()

        # Reveal the card visually
        self._reveal_card(r, c)

        if self.first_selection is None:
            # this is the first card of a potential pair
            self.first_selection = (r, c)
        else:
            # second card clicked — check for match
            r1, c1 = self.first_selection
            r2, c2 = r, c
            self.moves += 1
            self.moves_label.config(text=f"Moves: {self.moves}")

            if self.card_values[(r1, c1)] == self.card_values[(r2, c2)]:
                # Match found — leave them revealed and disable buttons
                self.matches += 1
                self.matches_label.config(text=f"Matches: {self.matches}/{PAIRS}")
                self.buttons[(r1, c1)].config(state="disabled")
                self.buttons[(r2, c2)].config(state="disabled")
                self.first_selection = None

                # Win condition
                if self.matches == PAIRS:
                    self.stop_timer()
                    elapsed = time.time() - self.start_time
                    messagebox.showinfo("You win!",
                                        f"You matched all pairs in {self.moves} moves!\nTime: {elapsed:.1f} s")
            else:
                # Not a match — flip back after a delay
                self.locked = True
                self.master.after(FLIP_DELAY_MS, lambda: self._hide_cards((r1, c1), (r2, c2)))

    def _reveal_card(self, r, c):
        """Show the symbol on the button and mark it revealed."""
        self.buttons[(r, c)].config(text=self.card_values[(r, c)], disabledforeground="black")
        self.revealed[(r, c)] = True

    def _hide_cards(self, pos1, pos2):
        """Flip two cards back face-down (used when they don't match)."""
        for pos in (pos1, pos2):
            # double-check not matched/disabled
            btn = self.buttons[pos]
            if btn['state'] != "disabled":
                btn.config(text="?")
                self.revealed[pos] = False
        self.first_selection = None
        self.locked = False

    # -------------------------
    # Timer & control utilities
    # -------------------------
    def start_timer(self):
        self.start_time = time.time()
        self.timer_running = True
        self._update_timer()

    def _update_timer(self):
        if self.timer_running:
            elapsed = time.time() - self.start_time
            self.timer_label.config(text=f"Time: {elapsed:.1f}s")
            # schedule next update in 100 ms
            self.master.after(100, self._update_timer)

    def stop_timer(self):
        self.timer_running = False

    def restart_game(self):
        """Reset stats, reshuffle deck, and re-enable buttons."""
        # Reset counters and labels
        self.moves = 0
        self.matches = 0
        self.moves_label.config(text=f"Moves: {self.moves}")
        self.matches_label.config(text=f"Matches: {self.matches}/{PAIRS}")

        # Reset timer
        self.stop_timer()
        self.timer_label.config(text="Time: 0.0s")
        self.start_time = None
        self.timer_running = False

        # Shuffle and reset buttons
        self._shuffle_cards()
        for pos, btn in self.buttons.items():
            btn.config(text="?", state="normal")
            self.revealed[pos] = False

        self.locked = False
        self.first_selection = None


def main():
    root = tk.Tk()
    game = MemoryGame(root)
    root.mainloop()


if __name__ == "__main__":
    main()
