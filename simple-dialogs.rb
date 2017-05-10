require 'fox16'
require 'fox16/colors'

include Fox

class ComparerWindow < FXMainWindow
  def initialize(app)
    # Call the base class initialize() first
    super(app, "Comparer App")
    self.width = 400
    self.height = 300

    # # Menu bar, along the top
    # menubar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
  
    # # Button bar along the bottom
    # buttons = FXHorizontalFrame.new(self, LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X)

    # The frame takes up the rest of the space
    buttframeSource = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|LAYOUT_FILL_X|FRAME_THICK)

    sourceButton = FXButton.new(buttframeSource, "Источник", :opts => BUTTON_NORMAL|LAYOUT_LEFT)

    @sourceText = FXTextField.new(buttframeSource, 0, nil, 0,
      TEXTFIELD_READONLY|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
    @sourceText.text = "не задано"
    @sourceText.disable

    sourceButton.connect(SEL_COMMAND) do
      dirDialog = FXDirDialog.new(self, "Choose a directory")
      if dirDialog.execute != 0
        @sourceText.text = dirDialog.directory
      end
    end

    # The frame takes up the rest of the space
    buttframeDest = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|LAYOUT_FILL_X|FRAME_THICK)

    destButton = FXButton.new(buttframeDest, "Назначение")

    @destText = FXTextField.new(buttframeDest, 0, nil, 0,
      TEXTFIELD_READONLY|FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X)
    @destText.text = "не задано"
    @destText.disable

    destButton.connect(SEL_COMMAND) do
      ffont = FXFont.new(getApp(), "Arial", 24, FONTWEIGHT_BOLD,FONTSLANT_ITALIC, FONTENCODING_UNICODE)
      dirDialog = FXDirDialog.new(self, "Choose a directory")
      if dirDialog.execute != 0
        @destText.text = dirDialog.directory
      end
    end

    buttframeStart = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|LAYOUT_FILL_X|FRAME_THICK)

    startButton = FXButton.new(buttframeStart, "ПУУУУУУУУУУУУУУУСК!!!", :opts => LAYOUT_FILL_X|FRAME_RAISED|FRAME_THICK)
    
    startButton.connect(SEL_COMMAND) do
      getApp().beginWaitCursor do 
        mainProcess
      end
    end

    # The frame takes up the rest of the space
    textframe = FXHorizontalFrame.new(self,
      LAYOUT_SIDE_TOP|LAYOUT_FILL_X|LAYOUT_FILL_Y|FRAME_SUNKEN|FRAME_THICK)
    
    # File menu
    # filemenu = FXMenuPane.new(self)
    # FXMenuCommand.new(filemenu, "&Quit\tCtl-Q\tQuit the application.", nil,
    #   getApp(), FXApp::ID_QUIT)
    # FXMenuTitle.new(menubar, "&File", nil, filemenu)
    
    # Text window
    @text = FXText.new(textframe, nil, 0,
      TEXT_READONLY|TEXT_WORDWRAP|LAYOUT_FILL_X|LAYOUT_FILL_Y)
    
    # Construct some hilite styles
    hs1 = FXHiliteStyle.from_text(@text)
    hs1.normalForeColor = FXColor::Red
    hs1.normalBackColor = FXColor::Blue
    hs1.style = FXText::STYLE_BOLD

    hs2 = FXHiliteStyle.from_text(@text)
    hs2.normalForeColor = FXColor::Blue
    hs2.normalBackColor = FXColor::Yellow
    hs2.style = FXText::STYLE_UNDERLINE
    
    # Enable the style buffer for this text widget
    @text.styled = true
    
    # Set the styles
    @text.hiliteStyles = [hs1, hs2]
    
  end

  def mainProcess
    sourceDir = @sourceText.text.to_s.gsub('\\','/').gsub(/^\//,'//')
    destDir = @destText.text.to_s.gsub('\\','/').gsub(/^\//,'//')

    # проходим по подкаталогам исходного каталога
    Dir.glob(File.join(sourceDir, '**')) do |soDir|
        next if sourceDir == soDir
        # puts "#{sourceDir}, #{soDir}, **/*.* исходный каталог взят"

        # проходим по файлам подкаталога
        Dir.glob(File.join(soDir, '**', '*.*')) do |soFile|
            lastSourceNum = soFile.split('.').first(1).join.split('_').last(1).first
            # если не число в конце имени, то следующий
            if lastSourceNum !~ /[a-z]*[0-9]+$/
                next
            end
            # puts "#{soFile} исходный файл выбран"
            @text.appendStyledText("#{soFile} исходный файл выбран\n", 1) 
            # каталог назначения
            doDir = soDir.split('/').last
            count = 0
            # puts "каталог назначения - #{destDir}#{doDir}"
            @text.appendStyledText("каталог назначения - #{destDir}#{doDir}\n", 1) 
            # ищем с таким же на конце в подкаталогах каталога назначения
            Dir.glob(File.join(destDir, doDir, '**', '*.*')) do |deFile|
                # puts "#{deFile} файл назначения взят"
                lastDestNum = deFile.split('.').first(1).join.split('_').last(1).first
                # если не число в конце имени, то следующий
                if lastDestNum !~ /[a-z]*[0-9]+$/
                    next
                elsif lastDestNum == lastSourceNum
                     count += 1   
                end
            end
            if count == 0
              # puts "#{soFile} не найдено соответствий"
              @text.appendStyledText("#{soFile} не найдено соответствий\n", 2) 
            else
              # puts "#{count} соответствий найдено"
              @text.appendStyledText("#{count} соответствий найдено\n", 1) 
            end
        end
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  application = FXApp.new("StyledText", "FoxTest")
  ComparerWindow.new(application)
  application.create
  application.run
end