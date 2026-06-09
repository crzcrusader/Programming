import brainflow as bf
import time
from brainflow.board_shim import BoardShim, BrainFlowInputParams, BoardIds

params = BrainFlowInputParams()
params.serial_port = "COM3"          # Change to your port
params.other_info = '{"gain": 12}'   # Recommended gain

board = BoardShim(BoardIds.NEUROPAWN_KNIGHT_BOARD.value, params)
board.prepare_session()
board.start_stream(450000)

time.sleep(2)

# Enable channels (example: 8 channels)
for ch in range(1, 9):
    time.sleep(0.5)
    board.config_board(f"chon_{ch}_12")   # Enable channel with gain 12
    time.sleep(1)
    board.config_board(f"rldadd_{ch}")    # Enable Right Leg Drive for channel
    time.sleep(0.5)

# Read data in a loop
while True:
    data = board.get_board_data()
    print(data)  # numpy array: rows = channels, cols = samples