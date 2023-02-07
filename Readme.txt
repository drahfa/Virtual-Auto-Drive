Readme.txt 
Ahmad Faisal Mohamad Ayob
ahmad.faisal@umt.edu.my

7 January 2020 - Begin writing this readme.txt
7 February 2023 - Added MATLAB requirements and Extras

Matlab Requirements
- Deep Learning Toolbox
- Image Processing Toolbox

Extras (if you are running GTA V)
- in the 'extras' folder, find the commandline.txt file and place it within the root of GTA V installation e.g. D:\SteamLibrary\steamapps\common\Grand Theft Auto V\
- commandline.txt shall resize GTA V to 800 600 resolution

Installation notes

1. Install the supported Python for Matlab. As of typing, the supported Python version for the use within Matlab is 3.7

Read: https://www.python.org/downloads/release/python-370/
At the bottom of the text, the download is: https://www.python.org/ftp/python/3.7.0/python-3.7.0-amd64.exe

- Install to C Drive. In the installation GUI of python will typically set to C:\Python37

2. Go to Install MATLAB Engine API for Python: https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html
Observe the command below, my matlabroot is: D:\Program Files\MATLAB\R2019b

At a Windows operating system prompt —
cd "matlabroot\extern\engines\python"
python setup.py install

a) click the start button, type cmd, hit Enter
b) since my installation of MATLAB was at D:\ drive, so I type D: in the cmd
c) type cd "D:\Program Files\MATLAB\R2019b\extern\engines\python"
d) type python setup.py install
e) if all good, you'll see text similar like below in the cmd after long set of installation status text
...
running install_egg_info
Writing C:\Python37\Lib\site-packages\matlabengineforpython-R2019b-py3.7.egg-info

3. Start MATLAB, or restart MATLAB
4. Type pyenv in MATLAB Command Window
All are successful, you'll get this output:

>> pyenv

ans = 

  PythonEnvironment with properties:

          Version: "3.7"
       Executable: "C:\Python37\python.EXE"
          Library: "C:\Python37\python37.dll"
             Home: "C:\Python37"
           Status: NotLoaded
    ExecutionMode: InProcess

5. For keyboard press recording, we'll need win32api
if you have updated pip, skip this section. Or if  you are confused, run this section :-)
a) click the start button, type cmd, hit Enter
b) type C:\
c) Download get-pip.py to C:\ drive (https://bootstrap.pypa.io/get-pip.py)
d) Run the following command: python get-pip.py
e) now pip is installed. 
f) refer here: https://stackoverflow.com/questions/21343774/importerror-no-module-named-win32api
in cmd, type pip install pywin32
You'll message like this:
Installing collected packages: pywin32
Successfully installed pywin32-227
g) in cmd, type cd c:\Python37\Scripts
f) in cmd, type python pywin32_postinstall.py -install
if succesful, you'll get: The pywin32 extensions were successfully installed.


6. Restart your computer.




