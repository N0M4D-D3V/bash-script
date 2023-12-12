# pip install keyboard
import keyboard
import time

_key: str = 'esc'
_sleep_time: int = 60

# simulate Escape press
def press_escape():
  print('Pressing configured key ...')
  print(_key)
  keyboard.press_and_release(_key)

# loop execution
try:
  while True:
    press_escape()
    time.sleep(_sleep_time)
except KeyboardInterrupt:
  pass
