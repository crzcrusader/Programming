from brainflow.board_shim import BoardShim, BrainFlowInputParams
from brainflow.data_filter import DataFilter
import time

params = BrainFlowInputParams()
params.serial_port = "COM3"  # or your port

board = BoardShim(0, params)  # board ID depends on device

board.prepare_session()
board.start_stream()

time.sleep(5)  # collect data

data = board.get_board_data()

board.stop_stream()
board.release_session()

print(data.shape)
