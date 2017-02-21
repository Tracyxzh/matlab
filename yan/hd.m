function varargout = hd(varargin)
% HD MATLAB code for hd.fig
%      HD, by itself, creates a new HD or raises the existing
%      singleton*.
%
%      H = HD returns the handle to a new HD or the handle to
%      the existing singleton*.
%
%      HD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HD.M with the given input arguments.
%
%      HD('Property','Value',...) creates a new HD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hd

% Last Modified by GUIDE v2.5 08-Feb-2017 14:22:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hd_OpeningFcn, ...
                   'gui_OutputFcn',  @hd_OutputFcn, ...
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


% --- Executes just before hd is made visible.
function hd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hd (see VARARGIN)

% Choose default command line output for hd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_Bn.
function open_Bn_Callback(hObject, eventdata, handles)
% hObject    handle to open_Bn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'选择图片');
if isequal(filename,0)
    disp('Users Selected Canceled');
else
str=[pathname filename];
im = imread(str);
% axes(handles.axes1);%axes1是坐标轴的标示
imshow(im);
end;

% --- Executes on button press in save_Bn.
function save_Bn_Callback(hObject, eventdata, handles)
% hObject    handle to save_Bn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
