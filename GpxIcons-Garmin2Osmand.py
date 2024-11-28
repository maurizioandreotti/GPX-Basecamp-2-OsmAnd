import sys
import base64
import os
import json
import lxml.etree as ET
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtWebEngineWidgets import *

import xml.dom.minidom as minidom 
def pretty_print_xml(xml_string): 
    parsed_xml = minidom.parseString(xml_string)
    return parsed_xml.toprettyxml(indent=" ")

class Browser(QMainWindow):
    def __init__(self):
        super(Browser, self).__init__()
        self.load_config()
        self.init_ui()
        self.xml_content = None # Variable to store XML content
        
    def load_config(self):
        self.config_file = 'config.json'
        self.config = {
            "default_xslt": "Gpx-Garmin2Osmand.xsl",
            "xslt_folder": "",
            "xml_folder": ""
        }
        if os.path.exists(self.config_file):
            with open(self.config_file, 'r') as file:
                loaded_config = json.load(file)
                self.config.update(loaded_config)  # Merge loaded config with defaults
    
    def save_config(self):
        with open(self.config_file, 'w') as file:
            json.dump(self.config, file)
    
    def init_ui(self):
        self.browser = QWebEngineView()
        self.setCentralWidget(self.browser)
        self.showMaximized()
        self.browser.setHtml("""
            <html>
                <head>
                    <style>
                        body { font-family: Arial, sans-serif; }
                        h1 { color: #4CAF50; }
                    </style>
                </head>
                <body>
                    <h1>Gpx Icons - Garmin2 Osmand</h1>
                             This program modifies a GPX file transforming Garmin icons in Osmand format
                </body>
            </html>
        """)

        self.setup_xml_toolbar()
        self.setup_xsl_toolbar()
        self.setup_transform_toolbar()
        self.setup_menu()


    def setup_xml_toolbar(self):
        xmlbar = QToolBar()
        self.addToolBarBreak()
        self.addToolBar(xmlbar)

        xml_file_btn = QAction('Select GPX/XML file', self)
        xml_file_btn.triggered.connect(self.open_xml_file_dialog)
        xmlbar.addAction(xml_file_btn)

        self.xml_filename_display = QLineEdit(self)
        self.xml_filename_display.setReadOnly(True)
        xmlbar.addWidget(self.xml_filename_display)

        self.apply_toolbar_style(xmlbar)

    def apply_toolbar_style(self, toolbar):
        toolbar.setStyleSheet("""
            QToolBar {
                border: 1px solid #000; /* Border around the toolbar */
            }
            QToolButton {
                border: 2px solid #000; /* Border around the buttons */
                border-radius: 5px; /* Rounded corners */
                padding: 5px; /* Padding inside the buttons */
                background-color: #f0f0f0; /* Light grey background */
                color: #000; /* Text color */
            }
            QToolButton:hover {
                background-color: #dcdcdc; /* Slightly darker background on hover */
            }
            QToolButton:pressed {
                background-color: #c0c0c0; /* Darker background when pressed */
            }
        """)


    def setup_xsl_toolbar(self):
        xslbar = QToolBar()
        self.addToolBarBreak()
        self.addToolBar(xslbar)

        xsl_file_btn = QAction('Select XSL', self)
        xsl_file_btn.triggered.connect(self.open_xsl_file_dialog)
        xslbar.addAction(xsl_file_btn)

        self.xsl_filename_display = QLineEdit(self)
        self.xsl_filename_display.setReadOnly(True)
        self.xsl_filename_display.setText(self.config["default_xslt"])
        xslbar.addWidget(self.xsl_filename_display)


        self.apply_toolbar_style(xslbar)

    def setup_transform_toolbar(self):
        transformbar = QToolBar()
        self.addToolBarBreak()
        self.addToolBar(transformbar)

        transform_btn = QAction('Execute Transformation', self)
        transform_btn.triggered.connect(self.execute_transformation)
        transformbar.addAction(transform_btn)

        save_btn = QAction('Save GPX with icons in OSMAnd format', self)
        save_btn.triggered.connect(self.save_GPX_file)
        transformbar.addAction(save_btn)

        self.apply_toolbar_style(transformbar)
       
    def setup_menu(self):
        menubar = self.menuBar()
        
        settings_menu = menubar.addMenu('Settings')
        config_action = QAction('Configure...', self)
        config_action.triggered.connect(self.open_config_dialog)
        settings_menu.addAction(config_action)

        help_menu = menubar.addMenu('Help')
        info_action = QAction('Info', self)
        info_action.triggered.connect(self.show_info_dialog)
        help_menu.addAction(info_action)

    def show_info_dialog(self):
        QMessageBox.information(self, "Application Info",
            "GPX Icons from Basecamp 2 Osmand format\n"
            "Version 1.0\n"
            "For more information, visit: https://www.innovationengineering.it\n"
            "© 2024 Maurizio Andreotti - Innovation Engineering"
        )

    def open_xml_file_dialog(self):
        options = QFileDialog.Options()
        folder = self.config["xml_folder"]  # Specify your default folder here
        fileName, _ = QFileDialog.getOpenFileName(self, "Open File", folder, "GPX/XML Files (*.gpx *.xml);;All Files (*)", options=options)
        if fileName:
            content, fileType = self.processXML(fileName)           
            if content:
                self.xml_content = content  # Store content in variable
                self.update_browser(content, fileType, fileName)

    def update_browser(self, content, fileType, fileName):
        if fileType == "xml":
            source_code = self.escape_html(content)
            #show xml in the main window
            self.browser.setHtml("<pre>{}</pre>".format(source_code))
            #update filename in the textbox
            self.xml_filename_display.setText(fileName)
        elif fileType == "error":
            self.browser.setHtml(content)
            self.xml_filename_display.setText(fileName)

    def escape_html(self, html_content): 
        from html import escape 
        return escape(html_content)    

    def processXML(self, filePath):   
        try:
            with open(filePath, 'r', encoding='utf-8') as file:
                xmlContent = file.read()
                return xmlContent, "xml"
        except Exception as e:
            return f"Error reading GPX file: {e}", "error"

    def open_xsl_file_dialog(self):
        options = QFileDialog.Options()
        folder = self.config["xslt_folder"] or ""
        fileName, _ = QFileDialog.getOpenFileName(self, "Select XSL File", folder, "XSL Files (*.xsl *.xslt);;All Files (*)", options=options)
        if fileName:
            print("Selected XSL file:", fileName)
            self.xsl_filename_display.setText(fileName)

    def open_config_dialog(self):
        dialog = QDialog(self)
        dialog.setWindowTitle("Configure Preferences")
        dialog.resize(800, 200)  # Set the window size to 400x400 pixels
        layout = QGridLayout()

        xslt_label = QLabel("Default XSLT File:")
        self.xslt_input = QLineEdit(self.config["default_xslt"])
        xslt_browse_btn = QPushButton("Browse")
        xslt_browse_btn.clicked.connect(self.browse_xslt_file)
        layout.addWidget(xslt_label, 0, 0)
        layout.addWidget(self.xslt_input, 0, 1)
        layout.addWidget(xslt_browse_btn, 0, 2)

        xslt_folder_label = QLabel("XSLT Files Folder:")
        self.xslt_folder_input = QLineEdit(self.config["xslt_folder"])
        xslt_folder_browse_btn = QPushButton("Browse")
        xslt_folder_browse_btn.clicked.connect(self.browse_xslt_folder)
        layout.addWidget(xslt_folder_label, 1, 0)
        layout.addWidget(self.xslt_folder_input, 1, 1)
        layout.addWidget(xslt_folder_browse_btn, 1, 2)

        xml_folder_label = QLabel("GPX/XML Files Folder:")
        self.xml_folder_input = QLineEdit(self.config["xml_folder"])
        xml_folder_browse_btn = QPushButton("Browse")
        xml_folder_browse_btn.clicked.connect(self.browse_xml_folder)
        layout.addWidget(xml_folder_label, 2, 0)
        layout.addWidget(self.xml_folder_input, 2, 1)
        layout.addWidget(xml_folder_browse_btn, 2, 2)

        save_btn = QPushButton("Save and Close")
        save_btn.clicked.connect(lambda: self.save_config_changes(dialog))
        layout.addWidget(save_btn, 3, 0, 1, 3)

        dialog.setLayout(layout)
        dialog.exec_()

    def browse_xslt_file(self):
        fileName, _ = QFileDialog.getOpenFileName(self, "Select XSLT File", "", "XSLT Files (*.xslt *.xsl);;All Files (*)")
        if fileName:
            self.xslt_input.setText(fileName)

    def browse_xslt_folder(self):
        folder = QFileDialog.getExistingDirectory(self, "Select XSLT Files Folder")
        if folder:
            self.xslt_folder_input.setText(folder)

    def browse_xml_folder(self):
        folder = QFileDialog.getExistingDirectory(self, "Select GPX/XML Files Folder")
        if folder:
            self.xml_folder_input.setText(folder)

    def save_config_changes(self, dialog):
        self.config["default_xslt"] = self.xslt_input.text()
        self.config["xslt_folder"] = self.xslt_folder_input.text()
        self.config["xml_folder"] = self.xml_folder_input.text()
        self.save_config()
        self.xsl_filename_display.setText(self.config["default_xslt"])
        dialog.accept()  # Close the dialog

    def remove_whitespace(xml_string): 
        return "".join(xml_string.split())

    def execute_transformation(self):
        xml_file = self.xml_filename_display.text()
        xsl_file = self.xsl_filename_display.text()

        if not self.xml_content or not xsl_file:
            QMessageBox.warning(self, "Warning", "Please select both GPX/XML and XSL files.")
            return
        try:
            dom = ET.fromstring(self.xml_content.encode('utf-8'))  # Encode the string to bytes
            xslt = ET.parse(xsl_file)
            transform = ET.XSLT(xslt)
            newdom = transform(dom)
            self.transformed_gpx = str(newdom)
            escaped_content = self.escape_html(self.transformed_gpx)  # Ensure the content is escaped
            self.browser.setHtml(f"<pre>{escaped_content}</pre>")
        except ET.XMLSyntaxError as e:
            QMessageBox.critical(self, "XML Error", f"XML Syntax Error: {e}")
        except Exception as e:
            QMessageBox.critical(self, "Error", str(e))

    def save_GPX_file(self):
        if not hasattr(self, 'transformed_gpx'):
            QMessageBox.warning(self, "Warning", "Please execute the transformation first.")
            return
        
        xml_file = self.xml_filename_display.text()
        default_html_file = os.path.splitext(xml_file)[0] + ".osm.gpx"
        options = QFileDialog.Options()
        fileName, _ = QFileDialog.getSaveFileName(self, "Save GPX File", default_html_file, "GPX Files (*.gpx);;All Files (*)", options=options)
        if fileName:
            try:
                with open(fileName, 'w', encoding='utf-8') as file: # Specify the encoding
                    file.write(self.transformed_gpx)
                QMessageBox.information(self, "Success", f"File saved as {fileName}")
            except Exception as e:
                QMessageBox.critical(self, "Error", str(e))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    QApplication.setApplicationName("My Browser")
    window = Browser()
    app.exec_()