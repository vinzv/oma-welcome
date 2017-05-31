import sys
import os
import gettext

from PyQt5.QtCore import QProcess
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QPushButton, QTextEdit

gettext.install("om-welcome")

class gui(QMainWindow):
    def __init__(self):
        super(gui, self).__init__()
        self.initUI()

    def dataReady(self):
        cursor = self.output.textCursor()
        cursor.movePosition(cursor.End)
        cursor.insertText(str(self.process.readAll()))
        self.output.ensureCursorVisible()

    def callProgram(self):
        arch = os.uname()[4]
        version = '1.0.5.3-1'
        
        self.process.start('urpmi --auto -v http://dl.maxthon.com/linux/rpm/' + arch +'/packages/maxthon-browser-stable-' + version + '.' + arch + '.rpm')

    def initUI(self):
        layout = QVBoxLayout()
        self.runButton = QPushButton( _('Click to Install') )
        self.runButton.clicked.connect(self.callProgram)

        self.output = QTextEdit()
        self.output.setReadOnly(1)

        layout.addWidget(self.output)
        layout.addWidget(self.runButton)

        centralWidget = QWidget()
        centralWidget.setLayout(layout)
        self.setCentralWidget(centralWidget)

        # QProcess object for external app
        self.process = QtCore.QProcess(self)
        # QProcess emits `readyRead` when there is data to be read
        self.process.readyRead.connect(self.dataReady)

        # Just to prevent accidentally running multiple times
        # Disable the button when process starts, and enable it when it finishes
        self.process.started.connect(lambda: self.runButton.setEnabled(False))
        self.process.finished.connect(lambda: self.runButton.setEnabled(True))


#Function Main Start
def main():
    app = QApplication(sys.argv)
    ui=gui()
    ui.show()
    sys.exit(app.exec_())
#Function Main END

if __name__ == '__main__':
    main() 
