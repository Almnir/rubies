  require 'win32/api'
  include Win32

  # Callback example - Enumerate windows
  EnumWindows     = API.new('EnumWindows', 'KP', 'L', 'user32')
  GetWindowText   = API.new('GetWindowText', 'LPI', 'I', 'user32')
  EnumWindowsProc = API::Callback.new('LP', 'I'){ |handle, param|
    buf = '\0' * 200
    puts 1
    GetWindowText.call(handle, buf, 200);
    puts 2 
    puts buf.strip unless buf.strip.empty?
    puts 3
    buf.index(param).nil? ? true : false
    puts 4
  }

  EnumWindows.call(EnumWindowsProc, 'Firefox')