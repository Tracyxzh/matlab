function varargout = words(varargin)
% WORDS MATLAB code for words.fig
%      WORDS, by itself, creates a new WORDS or raises the existing
%      singleton*.
%
%      H = WORDS returns the handle to a new WORDS or the handle to
%      the existing singleton*.
%
%      WORDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORDS.M with the given input arguments.
%
%      WORDS('Property','Value',...) creates a new WORDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before words_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to words_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help words

% Last Modified by GUIDE v2.5 10-Feb-2017 13:47:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @words_OpeningFcn, ...
                   'gui_OutputFcn',  @words_OutputFcn, ...
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
% h=figure;

% End initialization code - DO NOT EDIT


% --- Executes just before words is made visible.
function words_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to words (see VARARGIN)

% Choose default command line output for words
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes words wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = words_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
