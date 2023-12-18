# <>---< XCAPE SCRIPT >---<>
# >< version 1.0.0 || Coded by N0M4D ><
#
# > REQUIREMENTS
#    > python +3
#    > pip install keyboard

import keyboard
import time

_key: str = 'esc'
_sleep_time: int = 60
_cycle: int = 0

def print_header():
    print('<>---> XCAPE SCRIPT <---<>')
    print(' > Running ...')
    print('')

# simulate Escape press
def press_escape():
  keyboard.press_and_release(_key)

# loop execution
print_header()
try:
  while True:
    time.sleep(_sleep_time)
    press_escape()

    _cycle=_cycle+1
    print('    > cycle: ', _cycle)
    
except KeyboardInterrupt:
  pass
