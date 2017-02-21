function varargout = xixi(varargin)
% XIXI MATLAB code for xixi.fig
%      XIXI, by itself, creates a new XIXI or raises the existing
%      singleton*.
%
%      H = XIXI returns the handle to a new XIXI or the handle to
%      the existing singleton*.
%
%      XIXI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XIXI.M with the given input arguments.
%
%      XIXI('Property','Value',...) creates a new XIXI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xixi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xixi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xixi

% Last Modified by GUIDE v2.5 08-Feb-2017 23:42:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xixi_OpeningFcn, ...
                   'gui_OutputFcn',  @xixi_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before xixi is made visible.
function xixi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xixi (see VARARGIN)

% Choose default command line output for xixi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes xixi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xixi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)

% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function preDo_Callback(hObject, eventdata, handles)
% hObject    handle to preDo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function thin_Callback(hObject, eventdata, handles)
% hObject    handle to thin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timgBinary = getappdata(0,'tbinaryimg'); % 获取二值化图像  
timgThin = thin(timgBinary);
axes(handles.tthinImg);
setappdata(0,'tbinaryimg',timgThin); % 设置全局变量 细化图像
imshow(timgThin);
cimgBinary = getappdata(0,'cbinaryimg'); % 获取二值化图像  
cimgThin = thin(cimgBinary);
axes(handles.cthinImg);
setappdata(0,'cbinaryimg',cimgThin); % 设置全局变量 细化图像
imshow(cimgThin);

% --------------------------------------------------------------------
function wordDo_Callback(hObject, eventdata, handles)
% hObject    handle to wordDo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function score_Callback(hObject, eventdata, handles)
% hObject    handle to score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function getword_Callback(hObject, eventdata, handles)
% hObject    handle to getword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
words;
timgBinary = getappdata(0,'tbinaryimg'); % 获取二值化图像  
[ temrcutp, temccutp ] = getwords(timgBinary);
% m = size(temrcutp, 2);
% n = size(temccutp, 2);
% for r = 1 : m
%     for c = 1 : n
%         
%     end
% end

cimgBinary = getappdata(0,'cbinaryimg'); % 获取二值化图像  
[ cprcutp, cpccutp ] = getwords(cimgBinary);


% --------------------------------------------------------------------
function denoise_Callback(hObject, eventdata, handles)
% hObject    handle to denoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timgNoise = medfilt2(getappdata(0,'tgrayimg'), [5, 5]); % 获取灰度图像 中值滤波
axes(handles.tnoiseImg);
setappdata(0,'tdnoiseimg',timgNoise); % 设置全局变量 去噪图像
imshow(timgNoise);
cimgNoise = medfilt2(getappdata(0,'cgrayimg'), [5, 5]); % 获取灰度图像 
axes(handles.cnoiseImg);
setappdata(0,'cdnoiseimg',cimgNoise); % 设置全局变量 去噪图像
imshow(cimgNoise);

% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timgGray = rgb2gray(getappdata(0,'trawimg')); % 获取原始图像
axes(handles.tgrayImg);
setappdata(0,'tgrayimg',timgGray); % 设置全局变量 灰度图像
imshow(timgGray);
cimgGray = rgb2gray(getappdata(0,'crawimg')); % 设置全局变量 灰度图像
axes(handles.cgrayImg);
setappdata(0,'cgrayimg',cimgGray);
imshow(cimgGray);

% --------------------------------------------------------------------
function binary_Callback(hObject, eventdata, handles)
% hObject    handle to binary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
timgDnoise = getappdata(0,'tdnoiseimg'); % 获取去噪图像  
T = graythresh(timgDnoise); % 计算Otsu's阈值 
timgBinary = im2bw(timgDnoise, T);
axes(handles.tbinaryImg);
setappdata(0,'tbinaryimg',timgBinary); % 设置全局变量 二值化图像
imshow(timgBinary);
cimgDnoise = getappdata(0,'cdnoiseimg'); % 获取去噪图像  
T = graythresh(cimgDnoise); % 计算Otsu's阈值 
cimgBinary = im2bw(cimgDnoise, T);
axes(handles.cbinaryImg);
setappdata(0,'cbinaryimg',cimgBinary); % 设置全局变量 二值化图像
imshow(cimgBinary);

% --------------------------------------------------------------------
function template_Callback(hObject, eventdata, handles)
% hObject    handle to template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'选择图片');
if isequal(filename,0)
    disp('Users Selected Canceled');
else
str=[pathname filename];
im = imread(str);
axes(handles.trawImg);%axes1是坐标轴的标示
imshow(im);
setappdata(0,'trawimg',im);
end;

% --------------------------------------------------------------------
function copy_Callback(hObject, eventdata, handles)
% hObject    handle to copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'选择图片');
if isequal(filename,0)
    disp('Users Selected Canceled');
else
str=[pathname filename];
im = imread(str);
axes(handles.crawImg);%axes1是坐标轴的标示
imshow(im);
setappdata(0,'crawimg',im);
end;


% --------------------------------------------------------------------
function recognition_Callback(hObject, eventdata, handles)
% hObject    handle to recognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function stroke_Callback(hObject, eventdata, handles)
% hObject    handle to stroke (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
